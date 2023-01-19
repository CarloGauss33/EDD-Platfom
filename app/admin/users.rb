ActiveAdmin.register User do
  permit_params :email,
                :password,
                :password_confirmation,
                :names,
                :last_names,
                :status,
                :canvas_user_id,
                :university_id,
                :rut,
                :github_username

  index do
    selectable_column
    id_column
    column :rut
    column :email
    column :names
    column :last_names
    column :university_id
    column :github_username
    actions
  end

  filter :email
  filter :names

  form do |f|
    f.inputs do
      f.input :email
      f.input :names
      f.input :last_names
      f.input :university_id
      f.input :rut
      f.input :github_username
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

  show do
    attributes_table do
      row :email
      row :names
      row :last_names
      row :university_id
      row :rut
      row :github_username
      row :created_at
      row :updated_at
    end

    panel "Cursos" do
      table_for user.students do
        column :course_class do |o|
          link_to o.course_class.name, admin_course_course_class_path(o.course_class)
        end
        column :section
        column :assignment_responses do |o|
          ul do
            o.assignment_responses.each do |ar|
              li do
                link_to ar.assignment.name,
                        admin_assignment_assignment_response_path(ar.assignment, ar)
              end
            end
          end
        end
      end
    end
  end
end
