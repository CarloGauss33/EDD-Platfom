
import { serialize } from 'object-to-formdata';
import decamelizeKeys from '../utils/decamelize-for-files';
import api from './index';

export interface Assignment {
  id: number;
  name: string;
  description: string;
  kind: string;
  startDate: Date;
  endDate: Date;
}
export interface AssignmentResponse {
  id: number;
  assignmentId: number;
  userId: number;
  status: string;
  finalScore: number;
  createdAt: Date;
  updatedAt: Date;
}

export interface AssignmentQuestion {
  id: number;
  assignmentId: number;
  title?: string;
  sluggedTitle?: string;
  description?: string;
  questionType?: string;
}

export interface AssignmentQuestionResponse {
  score?: number;
  description?: string;
  file?: File | Blob;
}

export interface AssignmentQuestionUploadResponse {
  assignmentQuestionId?: number;
  id?: number;
  description?: string;
  file?: { 'url': string, 'filename': string } | undefined;
}

export default {
  create(courseId: number, assignmentId: number, assignmentQuestionId: number, data: AssignmentQuestionResponse) {
    const path = `/api/internal/courses/${courseId}/` +
                 `assignments/${assignmentId}/assignment_questions/` +
                 `${assignmentQuestionId}/assignment_question_response`;

    return api({
      method: 'post',
      url: path,
      data: serialize(decamelizeKeys({ 'assignment_question_response': data })),
    }).then((response) => response.data.assignmentQuestionResponse as AssignmentQuestionUploadResponse);
  },
};

