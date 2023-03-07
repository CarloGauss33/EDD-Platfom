import { createApp } from 'vue';
import { createI18n } from 'vue-i18n';
import { Field, Form, ErrorMessage } from 'vee-validate';
import { VueQueryPlugin } from '@tanstack/vue-query';
import Rails from '@rails/ujs';
import InlineSvg from 'vue-inline-svg';
import './css/application.css';

import AssignmentForm from './components/assignment-form.vue';
import AssignmentsList from './components/assignments-list.vue';
import StudentForm from './components/student-form.vue';
import UserProfile from './components/user-profile.vue';

import TheNavbar from './components/the-navbar.vue';
import BaseScanner from './components/base-scanner.vue';
import BaseButton from './components/base-button.vue';
import BaseNotice from './components/base-notice.vue';
import BaseInput from './components/base-input.vue';
import BaseSelect from './components/base-select.vue';
import BaseLabel from './components/base-label.vue';
import BaseModal from './components/base-modal.vue';

import esCL from './locales/es-CL.json';

type MessageSchema = typeof esCL;

// eslint-disable-next-line max-statements
document.addEventListener('DOMContentLoaded', () => {
  Rails.start();

  const i18n = createI18n<[MessageSchema], 'es-CL'>({
    locale: 'es-CL',
    messages: {
      'es-CL': esCL,
    },
  });

  const app = createApp({
    components: {
      TheNavbar,
      BaseButton,
      AssignmentForm,
      AssignmentsList,
      StudentForm,
      UserProfile,
    },
  });

  app.use(VueQueryPlugin);
  app.use(i18n);

  app.component('InlineSvg', InlineSvg);
  app.component('VField', Field);
  app.component('VForm', Form);
  app.component('VErrorMessage', ErrorMessage);

  app.component('BaseScanner', BaseScanner);
  app.component('BaseButton', BaseButton);
  app.component('BaseNotice', BaseNotice);
  app.component('BaseInput', BaseInput);
  app.component('BaseSelect', BaseSelect);
  app.component('BaseLabel', BaseLabel);
  app.component('BaseModal', BaseModal);

  app.mount('#vue-app');

  return app;
});
