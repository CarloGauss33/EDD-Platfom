import { serialize } from 'object-to-formdata';
import decamelizeKeys from '../utils/decamelize-for-files';
import api from './index';

import type { User } from '../types/user';

export default {
  create(user: User, courseClassId: number, courseId: number) {
    const path = `/api/internal/courses/${courseId}/course_classes/${courseClassId}/students`;

    return api({
      method: 'post',
      url: path,
      data: serialize(decamelizeKeys({ 'student': { user } })),
    });
  },
};
