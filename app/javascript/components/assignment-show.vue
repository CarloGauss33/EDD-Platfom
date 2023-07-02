<script setup lang="ts">
import ConfettiExplosion from 'vue-confetti-explosion';
import AssignmentResponseApi, {
  type AssignmentQuestionUploadResponse,
  type AssignmentQuestionResponse,
  type AssignmentQuestion,
  type Assignment,
} from 'api/assignment-response';

import { defineProps, withDefaults, computed, ref, onMounted } from 'vue';
import { useMutation } from '@tanstack/vue-query';
import type { User } from '../types/user';

interface Props {
  assignment: Assignment;
  assignmentQuestionResponses: AssignmentQuestionResponse[];
  isNewResponse: boolean;
  user: User;
}

const props = withDefaults(defineProps<Props>(), {
  isNewResponse: false,
});

const titleText = computed(() => {
  if (props.isNewResponse) {
    return `🥳🎉 Se ha subido con éxito la respuesta a ${props.assignment.name} 🥳🎉`;
  }

  return `Respuesta para ${props.assignment.name}`;
});
</script>
<template>
  <ConfettiExplosion
    v-if="props.isNewResponse"
    class="absolute top-0 mx-auto h-full w-full"
    :particle-count="200"
    :duration="5000"
    :force="0.8"
  />
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg">
    <h1
      class="mb-4 text-center text-xl font-bold md:text-2xl"
    >
      {{ titleText }}
    </h1>
    <base-notice
      class="mb-4 w-full"
    >
      Si deseas actualizar tu respuesta puedes acceder nuevamente al form
      <base-button
        class="ml-2"
        :href="`/assignments/${props.assignment.id}`"
        variant="secondary"
        size="sm"
      >
        Acceder al form
      </base-button>
    </base-notice>

    <div
      class="mb-12 grid grid-cols-1 gap-4 md:grid-cols-4"
    >
      <a
        v-for="(uploadedResponse) in assignmentQuestionResponses"
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
          {{ uploadedResponse.assignmentQuestionTitle }}
        </h3>
        <h2 class="text-center">
          Estado: {{ uploadedResponse.file ? "Respondida" : "No respondida" }}
        </h2>
        <p
          v-if="uploadedResponse.file"
          class="text-center"
        >
          Apreta para ver la respuesta
        </p>
      </a>
    </div>
    <base-button
      href="/"
      variant="secondary"
      class="w-full"
    >
      Volver al inicio
    </base-button>
  </div>
</template>
