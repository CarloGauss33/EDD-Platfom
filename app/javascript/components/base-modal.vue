<!-- eslint-disable max-len -->
<script setup lang="ts">
import {
  Dialog,
  DialogOverlay,
} from '@headlessui/vue';

interface Props {
  open: boolean;
}

withDefaults(defineProps<Props>(), {
  open: false,
});

defineEmits<{(e: 'close'): void}>();
</script>

<template>
  <Dialog
    :open="open"
    class="fixed inset-0 z-50 flex items-center justify-center px-1"
    @close="() => {}"
  >
    <DialogOverlay
      class="fixed inset-0 bg-black opacity-60"
    />
    <div class="relative mx-auto flex max-h-screen w-full flex-col overflow-auto rounded-md bg-white md:max-w-screen-md">
      <button
        class="absolute top-0 right-0 p-2"
        @click="$emit('close')"
      >
        <svg
          class="h-6 w-6 text-gray-800"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M6 18L18 6M6 6l12 12"
          />
        </svg>
      </button>

      <div class="p-10">
        <slot :close="() => $emit('close')" />
      </div>
    </div>
  </Dialog>
</template>
