import { createApp } from 'vue';
import { Field, Form, ErrorMessage } from 'vee-validate';
import { VueQueryPlugin } from '@tanstack/vue-query';
import Rails from '@rails/ujs';
import InlineSvg from 'vue-inline-svg';
import './css/application.css';

import AssignmentForm from './components/assignment-form.vue';
import AssignmentsList from './components/assignments-list.vue';
import BaseScanner from './components/base-scanner.vue';
import BaseButton from './components/base-button.vue';
import BaseNotice from './components/base-notice.vue';

// eslint-disable-next-line max-statements
document.addEventListener('DOMContentLoaded', () => {
  Rails.start();

  const app = createApp({
    components: {
      BaseButton,
      AssignmentForm,
      AssignmentsList,
      BaseScanner,
      BaseNotice,
    },
  });

  app.use(VueQueryPlugin);

  app.component('InlineSvg', InlineSvg);
  app.component('VField', Field);
  app.component('VForm', Form);
  app.component('VErrorMessage', ErrorMessage);

  app.component('BaseScanner', BaseScanner);
  app.component('BaseButton', BaseButton);
  app.component('BaseNotice', BaseNotice);

  app.mount('#vue-app');

  return app;
});
