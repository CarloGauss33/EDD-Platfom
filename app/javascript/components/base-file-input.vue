<script setup lang="ts">
import { useField } from 'vee-validate';
import { toRef } from 'vue';

interface Props {
  modelValue?: File | { filename: string; url: string };
  label?: string;
  name: string;
  required?: boolean;
  labelHint?: string;
  accept?: string;
  disabled?: boolean;
}
const props = withDefaults(defineProps<Props>(), {
  label: '',
  modelValue: undefined,
  labelHint: undefined,
  disabled: false,
  accept: 'application/pdf,image/*',
});

const name = toRef(props, 'name');

const {
  value: inputValue,
  errorMessage,
  handleBlur,
  handleChange,
} = useField(name, undefined, {
  initialValue: props.modelValue,
});

function setFile(e: Event) {
  const fileInput = e.target as HTMLInputElement;
  if (fileInput.files && fileInput.files[0]) {
    handleChange(fileInput.files[0]);
  }
}

function isFile(value: typeof props.modelValue): value is File {
  return value instanceof File;
}
</script>

<template>
  <div>
    <BaseLabel
      :label="label"
      :name="name"
      :required="required"
      :label-hint="labelHint"
    >
      <div
        v-if="isFile(modelValue) || !modelValue"
        class="flex"
        :class="{'border-red-600': !!errorMessage}"
      >
        <div
          class="form-input w-full rounded-lg rounded-r-none border py-3 px-2 font-normal"
          :class="props.disabled ? 'bg-edd-blue-100 text-slate-800 opacity-75' : 'bg-white'"
        >
          {{ modelValue ? modelValue.name : '&nbsp;' }}
        </div>
        <span
          class="inline-flex cursor-pointer select-none items-center justify-center rounded-r-lg px-4 text-sm font-medium "
          :class="props.disabled ? 'bg-edd-blue-100 text-slate-800 opacity-75' : 'bg-edd-blue-500 text-white'"
          type="button"
        >
          Adjuntar
        </span>
      </div>
      <a
        v-else
        :href="modelValue?.url"
        target="_blank"
        class="form-input w-full rounded-lg border py-3 px-2 font-normal"
      >
        {{ modelValue?.filename }}
      </a>
      <input
        :id="name"
        type="file"
        :name="name"
        class="hidden"
        :accept="accept"
        :disabled="props.disabled"
        :class="[{
          'text-red-600 border-red-600': !!errorMessage,
          'rounded-l-none': $slots.before,
        }]"
        @change="setFile"
        @blur="handleBlur"
      >
    </BaseLabel>
    <p
      v-show="errorMessage"
      class="text-right text-xs text-red-600"
    >
      {{ errorMessage }}
    </p>
  </div>
</template>
