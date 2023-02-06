<script setup lang="ts">
import { defineProps, withDefaults, computed, ref, onMounted } from 'vue';
import AssignmentResponseApi, {
  type AssignmentQuestionUploadResponse,
  type AssignmentQuestionResponse,
  type AssignmentQuestion,
  type Assignment,
} from 'api/assignment-response';

type User = {
    id?: number;
    firstName?: string;
    fullName?: string;
    username?: string;
    email?: string;
    githubUsername?: string;
    universityId?: string;
    rut?: string;
    names?: string;
    lastNames?: string;
};

interface Props {
  assignment: Assignment;
  assignmentQuestions: AssignmentQuestion[];
  uploadedAssignmentQuestionResponses: AssignmentQuestionUploadResponse[];
  courseId: number;
  user: User;
}

const props = withDefaults(defineProps<Props>(), {
  assignmentQuestions: undefined,
  assignment: undefined,
});

const numberOfQuestions = computed(() => props.assignmentQuestions.length - 1);
const ableToUpload = computed(() => props.assignment.status === 'active');
const currentQuestionIndex = ref<number>(ableToUpload.value ? 0 : numberOfQuestions.value + 1);
const assignmentQuestionResponses = ref<AssignmentQuestionResponse[]>(
  new Array(numberOfQuestions.value + 1)
    .fill(0)
    .map((_, index) => ({
      id: index * -1,
      file: undefined,
      description: '',
    })),
);
const uploadResponses = ref<AssignmentQuestionUploadResponse[]>(Array(numberOfQuestions.value + 1)
  .fill(0)
  .map((_, index) => ({
    assignmentQuestionId: props.assignmentQuestions[index].id,
    id: index * -1,
  })));
const hasError = ref<boolean>(false);
const isSubmitting = ref<boolean>(false);
const errorMessage = ref<string>('');

const blobValues = ref<string[]>(new Array(numberOfQuestions.value + 1).fill(''));
const isLastStep = computed(() => currentQuestionIndex.value === numberOfQuestions.value);
const anyNewResponse = computed(() => blobValues.value.some((blob) => blob !== ''));

function arrayIdFromAssignmentQuestionId(assignmentQuestionId: number) {
  return props.assignmentQuestions.findIndex(
    (assignmentQuestion) => assignmentQuestion.id === assignmentQuestionId,
  );
}

function filenameForQuestion(question: AssignmentQuestion) {
  return `${question.sluggedTitle}_${props.user.username}.pdf`;
}

function stepSubmitted(index: number) {
  return uploadResponses.value[index] && uploadResponses.value[index].file !== undefined;
}

const currentStepSubmitted = computed(() => stepSubmitted(currentQuestionIndex.value));

// eslint-disable-next-line max-statements
async function submitCurrentQuestion() {
  if (!ableToUpload.value) {
    return;
  }
  const currentBlob = blobValues.value[currentQuestionIndex.value];
  if (currentBlob === '') {
    let currentResponse = uploadResponses.value[currentQuestionIndex.value];
    if (currentResponse && currentResponse.id as number < 0) {
      currentResponse = {
        id: currentQuestionIndex.value * -1,
      };
    }
    currentQuestionIndex.value += 1;

    return;
  }
  isSubmitting.value = true;
  const blob = new Blob([currentBlob], { type: 'application/pdf' });
  const courseId = props.courseId;
  const assignmentId = props.assignment.id;
  const assignmentQuestionId = props.assignmentQuestions[currentQuestionIndex.value].id;
  const filename = filenameForQuestion(props.assignmentQuestions[currentQuestionIndex.value]);
  assignmentQuestionResponses.value[currentQuestionIndex.value].file = new File([blob], filename, {
    type: 'application/pdf' });

  try {
    uploadResponses.value[currentQuestionIndex.value] = await AssignmentResponseApi.create(
      courseId,
      assignmentId,
      assignmentQuestionId,
      assignmentQuestionResponses.value[currentQuestionIndex.value],
    );
    currentQuestionIndex.value += 1;
    isSubmitting.value = false;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  } catch (error: any) {
    errorMessage.value = error?.message;
    hasError.value = true;
    isSubmitting.value = false;
  }
}

function downloadQuestion(index: number) {
  const blob = new Blob([blobValues.value[index]], { type: 'application/pdf' });
  const url = URL.createObjectURL(blob);
  const link = document.createElement('a');
  const filename = filenameForQuestion(props.assignmentQuestions[index]);
  link.href = url;
  link.setAttribute('download', filename);
  document.body.appendChild(link);
  link.click();
  link.remove();
}

function downloadAllQuestions() {
  for (let i = 0; i <= numberOfQuestions.value; i++) {
    if (blobValues.value[i] === '') {
      continue;
    }

    downloadQuestion(i);
  }
}

function goBackOneStep() {
  if (currentQuestionIndex.value === 0 || !ableToUpload.value) {
    return;
  }

  currentQuestionIndex.value -= 1;
}

onMounted(() => {
  if (props.uploadedAssignmentQuestionResponses.length > 0) {
    props.uploadedAssignmentQuestionResponses.forEach((uploadedAssignmentQuestionResponse) => {
      const index = arrayIdFromAssignmentQuestionId(uploadedAssignmentQuestionResponse.assignmentQuestionId as number);
      uploadResponses.value[index] = { ...uploadedAssignmentQuestionResponse };
    });
  }
});

</script>
<template>
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg">
    <div class="mb-4 grid grid-cols-5 items-center">
      <base-button
        variant="tertiary"
        class="col-span-1 py-1 text-2xl"
        :href="currentQuestionIndex === 0 || !ableToUpload ? '/' : undefined"
        @click="goBackOneStep"
      >
        ←
      </base-button>

      <div class="col-span-3 text-center">
        <h2 class="text-2xl font-bold text-black">
          {{
            currentQuestionIndex > numberOfQuestions ?
              'Resumen' :
              props.assignmentQuestions[currentQuestionIndex].title
          }}
        </h2>
      </div>
    </div>
    <p
      v-if="currentQuestionIndex <= numberOfQuestions"
      class="mb-4 text-black md:text-lg"
    >
      Hola {{ user.firstName }}!, Adjunta las capturas de la interrogación y luego presiona el botón de enviar,
      En caso de no responder la pregunta, puedes saltarla.
    </p>
    <base-notice
      v-if="currentStepSubmitted"
      class="mb-4 flex w-full flex-col gap-2 md:flex-row"
    >
      Ya tienes una respuesta registrada para esta pregunta, si deseas cambiarla, puedes volver a responder.
      <base-button
        variant="secondary"
        size="sm"
        :href="uploadResponses[currentQuestionIndex].file?.url"
        target="_blank"
      >
        Ver respuesta
      </base-button>
    </base-notice>
    <base-notice
      v-if="hasError"
      class="mb-4 w-full"
    >
      {{ errorMessage }}
    </base-notice>

    <div v-if="currentQuestionIndex > numberOfQuestions">
      <div
        v-if="!isLastStep"
        class="flex flex-col justify-center"
      >
        <p class="mb-4 text-justify text-base">
          Tus respuestas fueron enviadas correctamente, puedes visualizarlas a continuación.
          En caso de querer modificar alguna respuesta, puedes volver hacia atrás y realizarlo.
        </p>

        <h1 class="text-center text-xl font-bold text-edd-blue-800">
          Respuestas de {{ user.firstName }}
        </h1>
        <div
          class="mb-12 grid grid-cols-1 gap-4 md:grid-cols-4"
        >
          <a
            v-for="(uploadedResponse, index) in uploadResponses"
            :key="uploadedResponse.id"
            :disabled="!uploadedResponse.file"
            :href="uploadedResponse.file ? uploadedResponse.file.url : '#'"
            :target="uploadedResponse.file ? '_blank' : ''"
            class="flex flex-col items-center justify-center rounded-lg p-4 shadow-lg"
            :class="{
              'bg-edd-blue-100 text-edd-blue-800 hover:text-white hover:bg-edd-blue-800': uploadedResponse.file,
              'cursor-default bg-slate-100 text-slate-500': !uploadedResponse.file,
            }"
          >
            <h3 class="text-center text-xl font-semibold">
              {{ props.assignmentQuestions[index].title }}
            </h3>
            <h2 class="text-center">
              Estado: {{ uploadedResponse.file ? "Respondida" : "No respondida" }}
            </h2>
          </a>
        </div>
        <base-button
          :disabled="isSubmitting || !anyNewResponse"
          @click="downloadAllQuestions"
        >
          Descargar respuestas nuevas
        </base-button>
      </div>
      <div v-else>
        Cargando...
      </div>
    </div>
    <div v-else>
      <div
        v-for="(question, index) in props.assignmentQuestions"
        :key="index"
      >
        <base-scanner
          v-if="index === currentQuestionIndex"
          v-model="blobValues[index]"
          :min-attachments="1"
          :already-scanned="stepSubmitted(index)"
          @submit="submitCurrentQuestion"
        />
      </div>
    </div>
  </div>
</template>
