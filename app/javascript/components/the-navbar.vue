<script setup lang="ts">
import { defineProps, withDefaults } from 'vue';

interface Props {
  user?: User;
}

const props = withDefaults(defineProps<Props>(), {
  user: undefined,
});

</script>
<template>
  <header class="flex items-center justify-between rounded-2xl px-4 pt-3 opacity-80 md:px-14">
    <a
      href="/"
      class="text-xl font-semibold md:text-2xl"
    >
      EDD Platform
    </a>

    <base-button
      href="/profile"
      size="sm"
      variant="secondary"
      class="mb-1"
    >
      {{ user ? user.fullName : 'Iniciar sesión' }}
    </base-button>
  </header>
</template>
