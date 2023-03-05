<script setup lang="ts">
import { useField } from 'vee-validate';
import { useAttrs, watch } from 'vue';

interface Props {
  type?: string;
  modelValue?: string | number | unknown[];
  label?: string;
  placeholder?: string;
  name: string;
  is?: string;
  required?: boolean;
  labelHint?: string;
  disabled?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  type: 'text',
  is: 'input',
  label: '',
  modelValue: undefined,
  placeholder: undefined,
  labelHint: undefined,
  disabled: false,
});

const emit = defineEmits<{(e: 'update:modelValue', value: number | string | unknown[]): void}>();

const {
  value: inputValue,
  errorMessage,
  handleBlur,
  handleChange,
} = useField(props.name, undefined, {
  initialValue: props.modelValue,
});

watch(inputValue, (newVal) => {
  if (newVal === props.modelValue) {
    return;
  }

  emit('update:modelValue', newVal);
});

const attrs = useAttrs();
const attrsWithoutClass = Object.fromEntries(Object.entries(attrs).filter(([key, _]) => key !== 'class'));
</script>

<script lang="ts">
export default {
  inheritAttrs: false,
};
</script>

<template>
  <div :class="$attrs.class">
    <BaseLabel
      :label="label"
      :name="name"
      :required="props.required"
      :label-hint="labelHint"
    />
    <div class="flex">
      <span
        v-if="$slots.prefix"
        class="flex items-center whitespace-nowrap rounded-l py-3 px-2 text-white"
        :class="[
          props.disabled ? 'bg-slate-500 text-slate-700 opacity-75' : 'bg-edd-blue-500'
        ]"
      >
        <slot name="prefix" />
      </span>
      <component
        v-bind="attrsWithoutClass"
        :is="is"
        :id="name"
        :value="inputValue"
        :placeholder="placeholder"
        :name="name"
        :type="type"
        :disabled="props.disabled"
        :required="props.required"
        class="w-full rounded-md px-2 py-3 focus:border-edd-blue-200 focus:outline-none focus:ring-2 focus:ring-edd-blue-500 focus:ring-offset-2"
        :class="[
          props.disabled ? 'bg-slate-300 border-slate-500 text-slate-700 opacity-75' : 'bg-white',
          {
            '!text-red-600 !border-red-600': !!errorMessage,
            'rounded-l-none': $slots.prefix,
          }
        ]"
        @input="handleChange"
        @blur="handleBlur"
      />
    </div>
    <p
      v-show="errorMessage"
      class="py-0.5 text-right text-xs text-red-500"
    >
      {{ errorMessage }}
    </p>
  </div>
</template>

