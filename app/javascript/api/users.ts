import { serialize } from 'object-to-formdata';
import decamelizeKeys from '../utils/decamelize-for-files';
import api from './index';

import type { User } from '../types/user';

export default {
  update(user: User) {
    const path = '/api/internal/users';

    return api({
      method: 'put',
      url: path,
      data: serialize(decamelizeKeys({ 'user': user })),
    }).then((response) => response.data.user as User);
  },
};
