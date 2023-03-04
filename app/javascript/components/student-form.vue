<script setup lang="ts">
import { defineProps, reactive, ref, computed, watch } from 'vue';
import { object, string, number } from 'yup';
import { rutValidate, rutFormat } from 'rut-helpers';

import studentsApi from 'api/students';

const props = defineProps<{
  course: Course;
  courseClasses: CourseClass[];
}>();

interface StudentForm {
  courseClassId: number;
  user: User;
}

const form = reactive<Partial<StudentForm>>({
  courseClassId: props.courseClasses[0]?.id,
  user: {
    names: undefined,
    lastNames: undefined,
    email: undefined,
    rut: undefined,
    githubUsername: undefined,
    universityId: undefined,
  },
});

const UNIVERSITY_ID_LENGTH = 8;

const formRules = object({
  courseClassId: number().required().label('Sección'),
  user: object({
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
  }),
});

const courseClassesOptions = computed(() => props.courseClasses.map((courseClass) => ({
  name: `Sección ${courseClass.section} - ${courseClass.professorName}`,
  id: courseClass.id,
})));

watch(() => form.user?.rut, (newValue, oldValue) => {
  if (newValue && newValue !== oldValue && form.user) {
    form.user.rut = rutFormat(newValue);
  }
});

const isSubmitting = ref(false);
const isSuccess = ref(false);
const isError = ref(false);
const user = ref<User | null>(null);

async function submit() {
  const ONE_SECOND = 1000;
  if (!form.user || !form.courseClassId) {
    return;
  }

  isSubmitting.value = true;
  studentsApi.create(
    form.user,
    form.courseClassId,
    props.course.id,
  )
    .then((response) => {
      user.value = response.data;
      isSuccess.value = true;
    })
    .catch(() => {
      isError.value = true;
    })
    .finally(() => {
      setTimeout(() => {
        isSubmitting.value = false;
      }, ONE_SECOND);
    });
}

function closeModal() {
  if (isSuccess.value) {
    window.location.href = '/';
  } else {
    isSuccess.value = false;
    isError.value = false;
  }
}

</script>
<template>
  <base-modal
    :open="isSuccess || isSubmitting || isError"
    @close="closeModal"
  >
    <div
      v-if="isSubmitting"
      class="text-center"
    >
      Cargando...
    </div>

    <div
      v-if="isError"
      class="text-center"
    >
      Ha ocurrido un error, por favor intenta nuevamente.
    </div>

    <div
      v-if="isSuccess && !isSubmitting"
      class="flex flex-col items-center justify-center"
    >
      <h2 class="mb-4 text-center text-xl font-semibold">
        Te has registrado correctamente!
      </h2>
      <p>
        Para acceder a la plataforma del curso debes ingresar con tu mail.
        la contraseña por defecto es tu número de alumno.
      </p>
    </div>
  </base-modal>
  <div class="w-full rounded-lg bg-slate-100 px-4 py-6 text-justify shadow-lg">
    <h2 class="mb-2 text-center text-xl font-semibold">
      {{ props.course.code }} - {{ props.course.name }}
    </h2>
    <base-notice
      class="mb-4"
    >
      El formulario es para registrarte en la plataforma del curso. De esa forma podrás subir tus interrogaciones
      y generar los repositorios para las tareas.
    </base-notice>
    <v-form
      :validation-schema="formRules"
      keep-values
      class="grid grid-cols-1 items-center justify-center gap-4 md:grid-cols-2"
      @submit="submit"
    >
      <base-select
        v-model="form.courseClassId"
        label="Sección"
        name="courseClassId"
        :options="courseClassesOptions"
        class="md:col-span-2"
        required
      />
      <base-input
        v-model="form.user.names"
        label="Nombres"
        name="user.names"
        placeholder="Stuart"
        required
      />
      <base-input
        v-model="form.user.lastNames"
        label="Apellidos"
        name="user.lastNames"
        placeholder="Little"
        required
      />
      <base-input
        v-model="form.user.email"
        label="Email"
        name="user.email"
        placeholder="stuartlittle@uc.cl"
        required
      />
      <base-input
        v-model="form.user.rut"
        label="Rut"
        name="user.rut"
        placeholder="12345678-9"
        required
      />
      <base-input
        v-model="form.user.universityId"
        label="Número de alumno"
        name="user.universityId"
        placeholder="12345678"
        required
      />
      <base-input
        v-model="form.user.githubUsername"
        label="Usuario de Github"
        name="user.githubUsername"
        placeholder="StuartLittle"
        required
      >
        <template #prefix>
          @
        </template>
      </base-input>
      <base-button
        type="submit"
        :disabled="isSubmitting"
        :loading="isSubmitting"
        class="mt-4 md:col-span-2"
      >
        Enviar
      </base-button>
    </v-form>
  </div>
</template>
