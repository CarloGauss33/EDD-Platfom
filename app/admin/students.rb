ActiveAdmin.register Student do
  belongs_to :course_class

  permit_params :user_id,
                :course_class_id,
                :status,
                :canvas_enrollment_id

  form do |f|
    f.inputs do
      f.input :user
      f.input :status
      f.input :canvas_enrollment_id
    end
    f.actions
  end
end
