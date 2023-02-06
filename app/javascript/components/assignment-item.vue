<script setup lang="ts">
import { defineProps, withDefaults } from 'vue';
import { format } from 'date-fns';
import { es } from 'date-fns/locale';
import type { Assignment } from 'api/assignment-response';

interface Props {
  assignment: Assignment;
}

const props = withDefaults(defineProps<Props>(), {
  assignment: undefined,
});

function formatDate(date: string) {
  return format(Date.parse(date), 'dd-MM-yyyy HH:MM', { locale: es });
}
</script>
<template>
  <a
    :href="`/assignments/${props.assignment.id}`"
  >
    <div class="mb:py-6 flex flex-col justify-between rounded-lg bg-white px-4 pt-4 pb-2 shadow-lg hover:bg-edd-blue-500 hover:text-white hover:shadow-xl md:flex-row md:py-8">
      <div class="mb-6 flex flex-col gap-4 md:mb-0 md:flex-row">
        <base-notice
          class="hidden md:block"
        >
          {{ props.assignment.status?.toUpperCase() }}
        </base-notice>
        <div class="flex flex-col">
          <h1 class="text-xl font-bold md:text-2xl">
            {{ props.assignment.course.code }} - {{ props.assignment.name }}
          </h1>
          <p class="text-sm">
            {{ props.assignment.course.name }}
          </p>
        </div>
      </div>
      <div class="mb-2 flex flex-col pr-4 md:mb-0 md:items-end">
        <p class="text-sm">
          Fecha Inicio: {{ formatDate(props.assignment.startDate) }}
        </p>
        <p class="text-sm">
          Fecha Termino: {{ formatDate(props.assignment.endDate) }}
        </p>
      </div>
      <base-notice
        class="h-4 rounded-md md:hidden"
        variant="secondary"
      >
        {{ props.assignment.status?.toUpperCase() }}
      </base-notice>
    </div></a>
</template>
