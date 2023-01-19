ActiveAdmin.register Assignment do
  belongs_to :course

  permit_params :course,
                :name,
                :description,
                :weight,
                :assignment_url,
                :assignment_solution_url,
                :status,
                :kind,
                :number_of_questions,
                :responses_required,
                :start_date,
                :end_date

  index do
    selectable_column
    id_column
    column :course
    column :name
    column :weight
    column :status
    column :kind
    actions
  end

  filter :course
  filter :name

  form do |f|
    f.inputs do
      f.input :course
      f.input :name
      f.input :description
      f.input :weight
      f.input :assignment_url
      f.input :assignment_solution_url
      f.input :status
      f.input :kind
      f.input :number_of_questions
      f.input :responses_required
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end
    f.actions
  end

  show do
    attributes_table do
      row :course
      row :name
      row :description
      row :weight
      row :assignment_url
      row :assignment_solution_url
      row :status
      row :kind
      row :number_of_questions
      row :responses_required
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end
  end

  sidebar "Assignment Responses", only: :show do
    div do
      link_to "Assignment Responses", admin_assignment_assignment_responses_path(assignment)
    end
  end
end
