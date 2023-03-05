<script setup lang="ts">
import { useField } from 'vee-validate';
import { watch } from 'vue';

interface Props {
  modelValue?: string | number;
  options: { id: string; name: string }[];
  label: string;
  name: string;
  required?: boolean;
  labelHint?: string;
  disabled?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  modelValue: undefined,
  labelHint: undefined,
  disabled: false,
});

const emit = defineEmits<{(e: 'update:modelValue', value: number | string): void}>();

const {
  value: inputValue,
  errorMessage,
  handleBlur,
  handleChange,
} = useField(props.name, undefined, {
  initialValue: props.modelValue,
  valueProp: props.modelValue,
});

function onChange(e: Event) {
  const value = (e.target as HTMLInputElement).value;
  handleChange(value);
  emit('update:modelValue', value);
}

</script>

<template>
  <div>
    <BaseLabel
      :label="label"
      :name="name"
      :required="required"
      :label-hint="labelHint"
    />
    <div class="flex">
      <select
        :id="name"
        :name="name"
        class="w-full rounded-lg p-3"
        :class="[
          props.disabled ? 'bg-slate-300 border-slate-500 text-slate-700 opacity-75' : 'border-black',
          { '!text-red-600 !border-red-600 !important': !!errorMessage }
        ]"
        :value="inputValue"
        :disabled="disabled"
        @change="onChange"
        @blur="handleBlur"
      >
        <template v-if="options.length > 0">
          <option
            v-for="option in options"
            :key="option.id"
            :value="option.id"
          >
            {{ option.name }}
          </option>
        </template>
        <option
          v-else
          value=""
        >
          No hay opciones disponibles
        </option>
      </select>
    </div>
    <p
      v-show="errorMessage"
      class="py-0.5 text-right text-xs text-red-500"
    >
      {{ errorMessage }}
    </p>
  </div>
</template>
