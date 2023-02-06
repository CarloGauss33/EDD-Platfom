ActiveAdmin.register Assignment do
  belongs_to :course, optional: true

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
                :end_date,
                assignment_questions_attributes: [:id, :question_type, :title, :description, :_destroy]

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
      f.input :assignment_url
      f.input :status
      f.input :kind
      f.input :responses_required
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
      hr
      f.has_many :assignment_questions, heading: false, allow_destroy: true do |r|
        r.input :question_type
        r.input :title
        r.input :description
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :course
      row :name
      row :description
      row :status
      row :kind
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end
    panel "Assignment Questions" do
      table_for assignment.assignment_questions do
        column :title do |o|
          link_to o.title, admin_assignment_assignment_question_path(assignment, o)
        end
        column :description
        column :question_type
      end
    end
  end

  sidebar "Assignment Data", only: :show do
    ul do
      li link_to "Assignment Responses", admin_assignment_assignment_responses_path(assignment)
      li link_to "Assignment Questions", admin_assignment_assignment_questions_path(assignment)
    end
  end
end
