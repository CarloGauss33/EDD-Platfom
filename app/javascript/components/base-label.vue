<script setup lang="ts">
interface Props {
  label: string;
  name: string | number;
  required?: boolean;
  labelHint?: string;
  tag?: string;
}

withDefaults(
  defineProps<Props>(),
  {
    tag: 'label',
    labelHint: undefined,
  },
);
</script>

<template>
  <component
    :is="tag"
    :for="name"
    class="mb-2 block font-semibold"
  >
    {{ label }}
    <span class="text-sm text-red-500">
      <template v-if="required && !labelHint">
        *
      </template>
      {{ labelHint }}
    </span>
    <slot />
  </component>
</template>
