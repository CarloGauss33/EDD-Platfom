ActiveAdmin.register CourseClass do
  belongs_to :course
  permit_params :course_id, :section, :canvas_course_id, :professor_name, :professor_email

  index do
    selectable_column
    id_column
    column :course
    column :section
    column :canvas_course_id
    column :professor_name
    column :professor_email
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
      row :created_at
      row :updated_at
    end
  end
end