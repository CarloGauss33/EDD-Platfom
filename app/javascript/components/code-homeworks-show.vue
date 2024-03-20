<script setup lang="ts">
import { ref } from 'vue';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import type { CodeHomework } from 'types/code-homework';
import type { CodeHomeworkRun } from 'types/code-homework-run';
import type { User } from 'types/user';
import codeHomeworkRunApi from 'api/code-homework-run';

interface Props {
  codeHomework: CodeHomework;
  codeHomeworkRuns: CodeHomeworkRun[];
  user: User;
}

const props = defineProps<Props>();
const currentShowedRun = ref<CodeHomeworkRun | null>(null);

async function createHomeworkRun() {
  if (!props.codeHomework?.id) {
    return;
  }

  codeHomeworkRunApi.create(props.codeHomework.id).then(() => {
    window.location.reload();
  }).catch(() => {
    alert('You must wait 5 minutes between runs');
  });
}

function formatDate(date: string) {
  if (!date) {
    return 'No definido';
  }

  return format(Date.parse(date), 'dd MMMM - HH:mm', { locale: es });
}

function showResultsForRun(codeHomeworkRun: CodeHomeworkRun) {
  currentShowedRun.value = codeHomeworkRun;
}

</script>
<template>
  <base-modal
    :open="currentShowedRun !== null"
    @close="currentShowedRun = null"
  >
    <div class="flex flex-col gap-4">
      <h1 class="text-2xl font-bold">
        Resultados de la ejecución
      </h1>
      <p>
        {{ currentShowedRun.runResults }}
      </p>
    </div>
  </base-modal>
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 shadow-lg">
    <div class="mb-8 text-center">
      <h1 class="mb-2 text-2xl font-bold">
        {{ codeHomework.name }}
      </h1>
      <p class="text-xl">
        Fecha de entrega: {{ formatDate(codeHomework.endDate) }}
      </p>
      <a
        :href="codeHomework.homeworkUrl"
        class="text-xl text-edd-blue-500 underline hover:text-edd-blue-800"
      >
        {{ codeHomework.homeworkUrl }}
      </a>
    </div>

    <h2 class="my-4 text-center text-2xl font-bold underline">
      Ejecuciones en el Servidor
    </h2>

    <base-button
      type="submit"
      class="mb-4 flex w-full"
      @click="createHomeworkRun"
    >
      Iniciar nueva solicitud
    </base-button>

    <div
      v-if="codeHomeworkRuns.length > 0"
      class="flex flex-col gap-4"
    >
      <div
        v-for="codeHomeworkRun in codeHomeworkRuns"
        :key="codeHomeworkRun.id"
        class="flex justify-between gap-4 rounded-lg bg-white px-4 py-6 shadow-lg"
      >
        <div class="flex flex-row items-center gap-4">
          <span class="rounded-md bg-edd-blue-500 p-4 py-8 text-white">
            {{ codeHomeworkRun.status }}
          </span>
          <div class="flex flex-col">
            <h2 class="mb-4 text-xl font-bold">
              Ejecución del {{ formatDate(codeHomeworkRun.createdAt) }}
            </h2>
            <p> Ejecutada: {{ formatDate(codeHomeworkRun.submittedAt) }} </p>
            <p> Finalizó: {{ formatDate(codeHomeworkRun.gradedAt) }} </p>
          </div>
        </div>

        <base-button
          v-if="codeHomeworkRun.runResults"
          type="button"
          variant="secondary"
          class="mt-4"
          @click="showResultsForRun(codeHomeworkRun)"
        >
          Ver resultados
        </base-button>
      </div>
    </div>
  </div>
</template>
