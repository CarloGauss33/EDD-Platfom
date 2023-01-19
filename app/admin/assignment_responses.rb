ActiveAdmin.register AssignmentResponse do
  belongs_to :assignment

  permit_params :assignment_id,
                :student_id,
                :status,
                :final_score,
                assignment_response_documents_attributes: [:id, :file, :score, :_destroy]

  index do
    selectable_column
    id_column
    column :assignment
    column :student do |o|
      link_to o.student.user.email, admin_course_class_student_path(o.student.course_class, o.student)
    end
    column :status
    actions
  end

  show do
    attributes_table do
      row :assignment
      row :student do |o|
        link_to o.student.user.email, admin_course_class_student_path(o.student.course_class, o.student)
      end
      row :status
      row :final_score
      row :documents do |assignment_response|
        table_for assignment_response.assignment_response_documents do
          column :file do |document|
            link_to document.filename, document.file.url
          end
          column :score
        end
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :assignment
      f.input :student
      f.input :status
      f.input :final_score
      f.inputs do
        f.has_many :assignment_response_documents, allow_destroy: true do |s|
          s.input :file, as: :file
          s.input :score
        end
      end
    end
    f.actions
  end
end
