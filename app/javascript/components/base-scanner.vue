<!-- eslint-disable @typescript-eslint/no-non-null-assertion -->
<!-- eslint-disable no-unused-vars -->
<!-- eslint-disable new-cap -->
<!-- eslint-disable no-var -->
<!-- eslint-disable max-statements -->
<!-- eslint-disable @typescript-eslint/no-explicit-any -->
<!-- eslint-disable no-magic-numbers -->
<script setup lang="ts">
import { jsPDF } from 'jspdf';
import { ref, computed } from 'vue';
import * as imageConversion from 'image-conversion';

interface Props {
  minAttachments?: number;
  downloadAfterScan?: boolean;
  attachmentBaseName?: string;
  submitLabel?: string;
  alreadyScanned?: boolean;
  isSubmitting?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  minAttachments: 1,
  downloadAfterScan: false,
  attachmentBaseName: 'attachment',
  submitLabel: 'Guardar y enviar',
  isSubmitting: false,
});

const emit = defineEmits<{(e: 'update:modelValue', value: any): void,
  (e: 'update:isGenerating', value: boolean): void,
  (e: 'submit'): void
}>();

const images = ref<string[]>([]);
const inputRendering = ref<boolean[]>([false]);
const numberOfAttachments = ref(props.minAttachments);
const isAnyInputRendering = computed(() => inputRendering.value.some(x => x));
const isAnyImageFieldOccupied = computed(() => images.value.some(x => x));
const ableToSubmit = computed(() => !isAnyInputRendering.value && isAnyImageFieldOccupied.value && !props.isSubmitting);

const skipMessage = computed(() => {
  if (props.alreadyScanned) {
    return 'Continuar';
  }

  return 'Saltar pregunta';
});

const uploadMessage = computed(() => {
  if (props.alreadyScanned) {
    return 'Actualizar respuesta';
  }

  return props.submitLabel;
});

async function generatePDF() {
  const doc = new jsPDF('p', 'mm', 'a4', true);
  const currentTimestamp = new Date().getTime().toString();

  images.value.forEach((image, index) => {
    const alias = `image${index}`;
    doc.setFontSize(7);
    doc.text(`Page ${index + 1}`, 200, 2);
    doc.text(currentTimestamp, 0, 2);
    doc.addImage(image, 'JPEG', 3.5, 3.5, 203, 290, alias, 'SLOW');

    if (index < images.value.length - 1) {
      doc.addPage();
    } else {
      emit('update:modelValue', doc.output('blob'));
    }
  });
}

function submit() {
  if (!ableToSubmit.value) {
    emit('submit');

    return;
  }
  emit('update:isGenerating', true);
  generatePDF().then(() => {
    emit('update:isGenerating', false);
    emit('submit');
  });
}

function removeImage(index: number) {
  if (images.value.length > 1) {
    images.value.splice(index, 1);
    inputRendering.value.splice(index, 1);
    numberOfAttachments.value--;
  } else {
    images.value = [];
    inputRendering.value = [];
  }
}

async function onFileChange(event: Event, index: number) {
  inputRendering.value[index] = true;

  const file = (event.target as HTMLInputElement).files![0];

  imageConversion.compress(
    file,
    {
      quality: 0.3,
      type: 'image/jpeg' as imageConversion.EImageType,
    }).then(res => {
    var reader = new FileReader();
    reader.readAsDataURL(res);
    reader.onload = function () {
      images.value[index] = reader.result as string;
      inputRendering.value[index] = false;
    };
  }).finally(() => {
    inputRendering.value[index] = false;
  });
}

</script>
<template>
  <div class="mb-2 flex flex-col items-center gap-x-2 md:grid md:grid-cols-4">
    <div
      v-for="i in numberOfAttachments"
      :key="i"
    >
      <label
        :for="`file-field-${i}`"
        class="mb-2 block text-sm font-bold text-gray-700"
      >
        <div v-if="images[i-1]">
          <div
            class="h-96 w-64 rounded-md bg-cover bg-center p-0.5"
            :style="{ backgroundImage: `url(${images[i-1]})` }"
          >
            <div class="flex h-8 w-16 items-center justify-center rounded-lg bg-edd-blue-500 hover:cursor-pointer">
              <button
                class="text-xl font-bold text-white shadow-lg"
                @click="removeImage(i-1)"
              >X</button>
            </div>
          </div>
        </div>
        <div v-else>
          <div class="flex h-96 w-64 flex-col items-center justify-center rounded-md bg-edd-blue-100 hover:cursor-pointer">
            <i class="fas fa-file-upload text-4xl text-edd-blue-800" />
            <span class="p-2 text-2xl text-edd-blue-800">
              Agregar Captura
            </span>
          </div>
        </div>
      </label>
      <input
        :id="`file-field-${i}`"
        type="file"
        accept="image/jpg"
        capture="environment"
        class="hidden"
        @change="onFileChange($event, i-1)"
      >
    </div>
  </div>
  <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
    <base-button
      variant="secondary"
      type="button"
      :disabled="isAnyInputRendering"
      @click="numberOfAttachments = numberOfAttachments + 1"
    >
      Añadir más archivos
    </base-button>
    <base-button
      type="button"
      :disabled="isAnyInputRendering || !ableToSubmit"
      @click="submit"
    >
      {{ ableToSubmit ? uploadMessage : skipMessage }}
    </base-button>
  </div>
  <base-notice
    v-if="isAnyInputRendering"
    class="mt-5 w-full opacity-70"
    variant="secondary"
  >
    Procesando imágenes...
  </base-notice>
</template>
