ActiveAdmin.register CodeHomework do
  belongs_to :course, optional: true

  permit_params :course_id,
                :name,
                :homework_url,
                :start_date,
                :end_date,
                :repository_prefix,
                :template_repository_url,
                :solution_repository_url,
                :testcases_url

  show do
    attributes_table do
      row :course
      row :name
      row :homework_url
      row :start_date
      row :end_date
      row :repository_prefix
      row :template_repository_url
      row :solution_repository_url
      row :testcases_url
    end

    panel 'Code Homework Runs' do
      paginated_collection(
        code_homework
          .code_homework_runs.includes(student: :user)
          .page(params[:page]).per(20)
      ) do
        table_for(collection) do
          column :id do |o|
            link_to o.id, admin_code_homework_run_path(o)
          end
          column :student
          column :status
          column :created_at
          column :updated_at
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :course
      f.input :name
      f.input :homework_url
      f.input :start_date, as: :date_time_picker
      f.input :end_date, as: :date_time_picker
      f.input :repository_prefix
      f.input :template_repository_url
      f.input :solution_repository_url
      f.input :testcases_url
    end
    f.actions
  end
end
