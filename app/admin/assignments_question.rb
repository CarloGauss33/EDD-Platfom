ActiveAdmin.register AssignmentQuestion do
  includes :assignment, :assignment_question_responses
  belongs_to :assignment

  permit_params :assignment_id,
                :question_type,
                :title,
                :description

  collection_action :download_all_responses, method: :get do
    send_data DownloadAssignmentQuestionResponsesCsvJob.perform_now(params[:assignment_id]),
              filename: "assignment_question_responses-#{Time.now}.csv"
  end

  action_item :download_all_responses, only: :show do
    link_to 'Descargar Respuestas',
            download_all_responses_admin_assignment_assignment_questions_path(
              assignment_question
            )
  end

  index do
    selectable_column
    id_column
    column :assignment
    column :question_type
    column :title
    column :description
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :assignment
      row :question_type
      row :title
      row :description
      row :created_at
      row :updated_at
    end

    panel "Respuestas Individuales" do
      paginated_collection(
        assignment_question.assignment_question_responses.page(params[:page]).per(15),
        param_name: 'page',
        download_links: false
      ) do
        table_for collection do
          column :email do |o|
            link_to o.assignment_response.student.user.email,
                    admin_course_class_student_path(o.assignment_response.student.course_class,
                                                    o.assignment_response.student)
          end
          column :score
          column :file do |o|
            link_to 'Abrir Documento',
                    o.file.url,
                    target: '_blank',
                    rel: 'noopener'
          end
        end
      end
    end
  end
end
