ActiveAdmin.register AssignmentResponse do
  belongs_to :assignment

  permit_params :assignment_id,
                :student_id,
                :status,
                assignment_question_responses_attributes: [:id, :assignment_question_id,
                                                           :response, :comment, :score,
                                                           :file, :_destroy]
  index do
    selectable_column
    id_column
    column :assignment
    column :student do |o|
      link_to o.student.user.email,
              admin_course_class_student_path(o.student.course_class, o.student)
    end
    column :status
    actions
  end

  show do
    attributes_table do
      row :assignment
      row :student do |o|
        link_to o.student.user.email,
                admin_course_class_student_path(o.student.course_class, o.student)
      end
      row :status
      row :score
      row :created_at
      row :updated_at
    end

    panel "Respuestas Individuales" do
      table_for assignment_response.assignment_question_responses do
        column :assignment_question
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

  form do |f|
    f.inputs do
      f.input :assignment
      f.input :student
      f.input :status
      f.inputs 'Responses' do
        f.has_many :assignment_question_responses, heading: false, allow_destroy: true do |r|
          r.input :assignment_question,
                  as: :select,
                  collection: AssignmentQuestion.by_assignment(f.object.assignment_id)
          r.input :score
          r.input :file, as: :file
        end
      end
    end
    f.actions
  end
end
