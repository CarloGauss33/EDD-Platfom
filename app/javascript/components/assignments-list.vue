<script setup lang="ts">
import { defineProps } from 'vue';
import type { Assignment } from 'api/assignment-response';
import AssignmentItem from 'components/assignment-item.vue';

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
  assignments: Assignment[];
  user: User;
}

const props = defineProps<Props>();
</script>
<template>
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg">
    <h1 class="mb-4 text-center text-2xl font-bold">
      Interrogaciones de {{ props.user.fullName }}
    </h1>

    <div
      v-if="props.assignments.length > 0"
      class="flex flex-col gap-4"
    >
      <assignment-item
        v-for="assignment in props.assignments"
        :key="assignment.id"
        :assignment="assignment"
      />
    </div>
    <div v-else>
      <p class="text-center text-xl">
        No tienes exámenes disponibles
      </p>
    </div>
  </div>
</template>
