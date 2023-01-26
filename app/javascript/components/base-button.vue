<script setup lang="ts">
import { computed, useAttrs } from 'vue';

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
    'text-white',
    'text-center',
    'bg-edd-blue-500 hover:bg-edd-blue-800',
    'disabled:hover:bg-edd-blue-500 disabled:bg-edd-blue-500',
  ],
  secondary: [
    'text-edd-blue-700',
    'hover:bg-edd-blue-200',
    'text-center',
    'bg-edd-blue-100',
    'disabled:hover:bg-edd-blue-100 disabled:bg-edd-blue-100',
  ],
  tertiary: [
    'text-white disabled:text-slate-800',
    'text-center',
    'bg-edd-blue-500 hover:bg-edd-blue-800',
    'disabled:hover:bg-slate-300 disabled:bg-slate-300',
  ],
  text: [
    'text-current',
  ],
};

const sizes = {
  md: [
    'py-3',
    'px-4',
    'text-lg',
  ],
  sm: [
    'py-2',
    'px-4',
    'text-sm',
  ],
};

const attrs = useAttrs();
const currentVariant = computed(() => variants[props.variant as keyof typeof variants]);
const currentTag = computed(() => (attrs.href ? 'a' : 'button'));
const currentSize = computed(() => sizes[props.size as keyof typeof sizes]);
</script>

<template>
  <component
    :is="currentTag"
    class="inline-flex items-center justify-center rounded-lg font-medium disabled:opacity-75"
    :class="[currentVariant, currentSize]"
  >
    <span v-if="props.loading">
      <svg
        class="h-4 w-4 animate-spin"
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
      >
        <circle
          class="opacity-25"
          cx="12"
          cy="12"
          r="10"
          stroke="currentColor"
          stroke-width="4"
        />
        <path
          class="opacity-75"
          fill="currentColor"
          d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135
              5.824 3 7.938l3-2.647z"
        />
      </svg>
    </span>
    <template v-else>
      <slot />
    </template>
  </component>
</template>
