ActiveAdmin.register CourseClass do
  belongs_to :course
  permit_params :course_id, :section, :canvas_course_id, :professor_name, :professor_email

  action_item :students, only: :show do
    link_to 'Ver estudiantes', admin_course_class_students_path(course_class)
  end

  action_item :upload_enrollments, only: :show do
    link_to 'Subir lista de estudiantes', action: :upload_enrollments
  end

  action_item :sync_students, only: :show do
    link_to('Sincronizar estudiantes con lista',
            sync_students_admin_course_course_class_path(course, course_class),
            method: :post)
  end

  member_action :load_enrollments, method: :post do
    if params[:csv].present? && params[:csv][:file].present?
      LoadCourseClassEnrollmentsCsvJob.perform_now(resource.id, params[:csv][:file])

      redirect_to admin_course_course_class_path(resource.course, resource), notice: 'Lista de estudiantes subida correctamente'
    else
      redirect_to admin_course_course_class_path(resource.course, resource), alert: 'No se ha subido ningún archivo'
    end
  end

  index do
    selectable_column
    id_column
    column :course
    column :section
    column :canvas_course_id
    column :professor_name
    column :professor_email
    row :default_inscription
    column :created_at
    actions
  end

  filter :course
  filter :section
  filter :canvas_course_id
  filter :professor_name
  filter :professor_email

  form do |f|
    f.inputs do
      f.input :course
      f.input :section
      f.input :canvas_course_id
      f.input :professor_name
      f.input :professor_email
      f.input :default_inscription,
              hint: 'Si se selecciona, los nuevos usuarios se inscribirán automáticamente a esta clase'
    end
    f.actions
  end

  show do
    attributes_table do
      row :course
      row :section
      row :canvas_course_id
      row :professor_name
      row :professor_email
      row :enrollments_loaded_at
      row :default_inscription
      row :created_at
      row :updated_at
    end
  end
end
