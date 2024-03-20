<script setup lang="ts">
import type { CodeHomework } from 'types/code-homework';
import type { User } from 'types/user';

interface Props {
  codeHomeworks: CodeHomework[];
  user: User;
}

const props = defineProps<Props>();

</script>
<template>
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg">
    <h1 class="mb-8 text-center text-2xl font-bold">
      Tareas de {{ props.user.fullName }}
    </h1>

    <div
      v-if="props.codeHomeworks.length > 0"
      class="flex flex-col gap-4"
    >
      <div
        v-for="codeHomework in props.codeHomeworks"
        :key="codeHomework.id"
        :codeHomework="codeHomework"
      >
        <a
          :href="`/code_homeworks/${codeHomework.id}`"
          class="flex flex-row justify-center rounded-lg border-4 border-edd-blue-200 bg-white p-8 text-2xl font-bold shadow-lg hover:bg-edd-blue-500 hover:text-white hover:shadow-xl"
        >
          {{ codeHomework.name }}
        </a>
      </div>
    </div>
  </div>
</template>
