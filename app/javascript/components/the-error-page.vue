<script setup lang="ts">
import { defineProps, withDefaults } from 'vue';

interface Props {
  errorCode: '404' | '500';
}
withDefaults(defineProps<Props>(), {
  errorCode: '404',
});

</script>
<template>
  <div class="flex h-full flex-col items-center justify-center">
    <div class="text-8xl font-bold">
      {{ errorCode }}
    </div>
    <div class="text-3xl">
      {{ $t(`errors.${errorCode}`) }}
    </div>
    <base-button
      class="mt-4"
      href="/"
    >
      {{ $t('errors.homeLinkText') }}
    </base-button>
  </div>
</template>
