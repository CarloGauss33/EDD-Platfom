<script setup lang="ts">
import { computed } from 'vue';

type Props = {
  variant?: 'default' | 'secondary';
  size?: string;
  loading?: boolean;
}

const props = withDefaults(
  defineProps<Props>(),
  {
    variant: 'default',
    size: 'md',
  },
);

const variants = {
  default: [
    'text-edd-blue-50',
    'text-center',
    'bg-edd-blue-400',
  ],
  secondary: [
    'text-edd-blue-600',
    'text-center',
    'bg-edd-blue-50',
  ],
  error: [
    'text-white',
    'text-center',
    'bg-red-500 hover:bg-red-800',
  ],
};

const sizes = {
  md: [
    'py-2',
    'px-4',
    'text-sm',
  ],
};

const currentVariant = computed(() => variants[props.variant as keyof typeof variants]);
const currentSize = computed(() => sizes[props.size as keyof typeof sizes]);
</script>

<template>
  <div
    class="inline-flex items-center justify-center rounded-lg font-medium"
    :class="[currentVariant, currentSize]"
  >
    <slot />
  </div>
</template>
