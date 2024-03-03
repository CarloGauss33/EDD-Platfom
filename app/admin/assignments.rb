ActiveAdmin.register Assignment do
  decorate_with AssignmentDecorator

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

  scope :with_active_semester, default: true
  scope :all

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
      f.input :start_date, as: :date_time_picker
      f.input :end_date, as: :date_time_picker
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
      row :submitted_responses_count
      row :non_submitted_responses_count
      row :created_at
      row :updated_at
    end

    panel "Assignment Questions" do
      table_for assignment.assignment_questions do
        column :question do |o|
          link_to o.title, admin_assignment_assignment_question_path(assignment, o)
        end
        column :response_count do |o|
          o.assignment_question_responses.count
        end
        column :description
        column :question_type
      end
    end

    panel "Assignment Responses" do
      paginated_collection(assignment.assignment_responses.page(params[:page]).per(10), download_links: false) do
        table_for collection do
          column :id do |o|
            link_to o.id, admin_assignment_assignment_response_path(assignment, o)
          end
          column :user do |o|
            link_to o.student_email, admin_user_path(o.user)
          end
          column :status
          column :created_at
          column :updated_at
        end
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
