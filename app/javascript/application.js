import { createApp } from 'vue';
import Rails from '@rails/ujs';
import InlineSvg from 'vue-inline-svg';
import './css/application.css';

import AssignmentForm from './components/assignment-form.vue';
import AssignmentsList from './components/assignments-list.vue';
import BaseScanner from './components/base-scanner.vue';
import BaseButton from './components/base-button.vue';
import BaseNotice from './components/base-notice.vue';

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

  app.component('InlineSvg', InlineSvg);
  app.component('BaseScanner', BaseScanner);
  app.component('BaseButton', BaseButton);
  app.component('BaseNotice', BaseNotice);

  app.mount('#vue-app');

  return app;
});
