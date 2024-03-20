<script setup lang="ts">
import type { Assignment, AssignmentResponse } from 'api/assignment-response';
import AssignmentItem from 'components/assignment-item.vue';
import type { User } from 'types/user';

interface Props {
  assignments: Assignment[];
  submittedAssignmentsResponses?: AssignmentResponse[];
  user: User;
}

const props = defineProps<Props>();

function isAssignmentAlreadySubmitted(assignment: Assignment) {
  return props.submittedAssignmentsResponses?.some(
    (assignmentResponse) => assignmentResponse.assignmentId === assignment.id,
  );
}
</script>
<template>
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg">
    <h1 class="mb-8 text-center text-2xl font-bold">
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
        :is-submitted="isAssignmentAlreadySubmitted(assignment)"
      />
    </div>
    <div v-else>
      <p class="text-center text-xl">
        No tienes exámenes disponibles
      </p>
    </div>
  </div>
</template>
