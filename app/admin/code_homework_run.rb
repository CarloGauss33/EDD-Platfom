ActiveAdmin.register CodeHomeworkRun do
  permit_params :code_homework_id, :student_id, :status, :created_at, :updated_at

  show do
    attributes_table do
      row :code_homework
      row :student
      tag_row :status
      row :run_results
      row :graded_at
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :code_homework
      f.input :student
      f.input :status
      f.input :graded_at, as: :date_time_picker
      f.input :created_at, as: :date_time_picker
      f.input :updated_at, as: :date_time_picker
    end
    f.actions
  end
end
