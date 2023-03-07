<script setup lang="ts">
import { defineProps, withDefaults, computed } from 'vue';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import type { Assignment } from 'api/assignment-response';

interface Props {
  assignment: Assignment;
  isSubmitted?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  assignment: undefined,
});

const computedStatus = computed(() => {
  if (props.isSubmitted) {
    return 'submitted';
  }

  return props.assignment.status;
});

function formatDate(date: string) {
  return format(Date.parse(date), 'dd MMMM - HH:MM', { locale: es });
}
</script>
<template>
  <a
    :href="`/assignments/${props.assignment.id}`"
  >
    <div class="mb:py-6 flex flex-col justify-between rounded-lg bg-white px-4 pt-4 pb-2 shadow-lg hover:bg-edd-blue-500 hover:text-white hover:shadow-xl md:flex-row md:py-8">
      <div class="mb-6 flex flex-col gap-4 md:mb-0 md:flex-row">
        <div
          class="hidden w-24 items-center justify-center rounded-md bg-edd-blue-500 px-2 py-1 text-sm font-semibold text-white md:flex"
        >
          {{ $t(`assignment.status.${computedStatus}`) }}
        </div>
        <div class="flex flex-col">
          <h1 class="flex flex-row items-center justify-between text-xl font-bold md:text-2xl">
            {{ props.assignment.course.code }} - {{ props.assignment.name }}
            <inline-svg
              v-if="props.isSubmitted"
              :src="require(`images/check-circle.svg`)"
              class="ml-2 h-6 w-6"
            />
          </h1>
          <p class="text-sm">
            {{ props.assignment.course.name }}
          </p>
        </div>
      </div>
      <div class="mb-2 flex flex-col pr-4 md:mb-0 md:items-end">
        <p class="text-sm">
          Inicio: {{ formatDate(props.assignment.startDate) }}
        </p>
        <p class="text-sm">
          Termino: {{ formatDate(props.assignment.endDate) }}
        </p>
      </div>
      <div
        class="flex w-full items-center justify-center rounded-md bg-edd-blue-500 px-2 py-1 text-sm font-semibold text-white md:hidden"
        variant="secondary"
      >
        {{ $t(`assignment.status.${computedStatus}`) }}
      </div>
    </div></a>
</template>
