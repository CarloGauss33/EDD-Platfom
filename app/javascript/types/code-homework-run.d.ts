export interface CodeHomeworkRun {
  id?: number;
  status?: string;
  submittedAt?: string;
  gradedAt?: string;
  runResults?: { [key: string]: string };
  createdAt?: string;
  updatedAt?: string;
}
