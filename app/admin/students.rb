ActiveAdmin.register Student do
  belongs_to :course_class

  permit_params :user_id,
                :course_class_id,
                :status

  form do |f|
    f.inputs do
      f.input :user
      f.input :status
    end
    f.actions
  end
end
