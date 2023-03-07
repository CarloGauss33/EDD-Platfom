<script setup lang="ts">
import { defineProps, withDefaults, reactive, ref, computed } from 'vue';
import { object, string } from 'yup';
import { rutValidate } from 'rut-helpers';

import usersApi from 'api/users';

interface Props {
  user: User;
}
const props = withDefaults(defineProps<Props>(), {
  user: undefined,
});

const mode = ref<'edit' | 'view'>('view');
const hasError = ref(false);
const isDisabled = computed(() => mode.value === 'view');

const UNIVERSITY_ID_LENGTH = 8;

const form = reactive<Partial<User>>({
  names: props.user?.names,
  lastNames: props.user?.lastNames,
  email: props.user?.email,
  rut: props.user?.rut,
  githubUsername: props.user?.githubUsername,
  universityId: props.user?.universityId,
});

const formRules = object({
  names: string().required().label('Nombres'),
  lastNames: string().required().label('Apellidos'),
  email: string().required()
    .email()
    .matches(/@uc\.cl$/, 'El correo debe ser de la UC')
    .label('Email'),
  rut: string().required()
    .test((value) => {
      if (value) {
        return rutValidate(value);
      }

      return false;
    })
    .label('Rut'),
  githubUsername: string().required().label('Usuario de Github'),
  universityId: string().required()
    .min(UNIVERSITY_ID_LENGTH)
    .max(UNIVERSITY_ID_LENGTH)
    .label('Número de alumno'),
});

function toggleEdit() {
  mode.value = mode.value === 'edit' ? 'view' : 'edit';
}

async function onSubmit() {
  try {
    await usersApi.update(form);
    mode.value = 'view';
  } catch (error) {
    hasError.value = true;
  }
}

</script>
<template>
  <div class="mx-auto w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg md:w-1/2">
    <div class="mb-8 flex flex-row items-center justify-between gap-x-4">
      <h2 class="text-left text-2xl font-bold">
        {{ $t('profile.title') }}
      </h2>

      <base-button
        size="md"
        @click="toggleEdit"
      >
        {{ isDisabled ? $t('profile.edit') : $t('profile.view') }}
      </base-button>
    </div>
    <v-form
      :validation-schema="formRules"
      keep-values
      class="grid grid-cols-1 items-center justify-center gap-4"
    >
      <base-input
        v-model="form.names"
        label="Nombres"
        name="user.names"
        placeholder="Stuart"
        :disabled="isDisabled"
        required
      />
      <base-input
        v-model="form.lastNames"
        label="Apellidos"
        name="user.lastNames"
        placeholder="Little"
        :disabled="isDisabled"
        required
      />
      <base-input
        v-model="form.rut"
        label="Rut"
        name="user.rut"
        placeholder="12345678-9"
        :disabled="isDisabled"
        required
      />
      <base-input
        v-model="form.universityId"
        label="Número de alumno"
        name="user.universityId"
        placeholder="12345678"
        :disabled="isDisabled"
        required
      />
      <base-input
        v-model="form.githubUsername"
        label="Usuario de Github"
        name="user.githubUsername"
        placeholder="StuartLittle"
        :disabled="isDisabled"
        required
      >
        <template #prefix>
          @
        </template>
      </base-input>
      <base-button
        v-if="!isDisabled"
        class="mt-4"
        @click="onSubmit"
      >
        Enviar
      </base-button>
      <base-notice
        v-if="hasError"
        variant="text"
      >
        {{ $t('profile.error') }}
      </base-notice>
      <a
        v-if="isDisabled"
        href="/users/sign_out"
        data-method="delete"
        class="mt-2 text-center text-lg text-red-500 underline hover:text-red-600"
      >
        {{ $t('profile.logout') }}
      </a>
    </v-form>
  </div>
</template>
