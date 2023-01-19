ActiveAdmin.register Course do
  permit_params :name,
                :code,
                :description,
                :status,
                :season,
                :year,
                :administrator_email

  action_item :create_course_class, only: :show do
    link_to 'Crear Sección', new_admin_course_course_class_path(course)
  end

  action_item :create_assignment, only: :show do
    link_to 'Crear Interrogación', new_admin_course_assignment_path(course)
  end

  index do
    selectable_column
    id_column
    column :name
    column :code
    column :description
    column :status
    column :season
    column :year
    column :administrator_email
    column :created_at
    actions
  end

  filter :name
  filter :code

  form do |f|
    f.inputs do
      f.input :name
      f.input :code
      f.input :description
      f.input :status
      f.input :season
      f.input :year
      f.input :administrator_email
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :code
      row :description
      row :status
      row :season
      row :year
      row :administrator_email
      row :created_at
      row :updated_at
    end

    panel 'Secciones' do
      table_for course.course_classes do
        column :section do |course_class|
          link_to "Sección #{course_class.section}", admin_course_course_class_path(course, course_class)
        end
        column :professor_name
        column :professor_email
        column :canvas_course_id
      end
    end

    panel 'Interrogaciones' do
      table_for course.assignments do
        column :name do |assignment|
          link_to assignment.name, admin_course_assignment_path(course, assignment)
        end
        column :anwsers do |assignment|
          link_to 'Respuestas', admin_assignment_assignment_responses_path(assignment)
        end
        tag_column :status
        tag_column :kind
        column :assignment_url
        column :start_date
        column :end_date
      end
    end

    panel 'Estudiantes' do
      paginated_collection(
        course.students.page(params[:page]).per(10),
        param_name: 'page',
        download_links: false
      ) do
        table_for collection do
          column :user do |student|
            link_to student.full_name, admin_user_path(student.user)
          end
          column :email
          column :rut
          column :section
        end
      end
    end
  end
end

# == Schema Information
#
# Table name: courses
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
