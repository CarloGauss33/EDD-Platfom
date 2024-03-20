import api from './index';

export default {
  create(codeHomeworkId: number) {
    const path = `/api/internal/code_homeworks/${codeHomeworkId}/code_homework_runs`;

    return api({
      method: 'post',
      url: path,
    });
  },
};
