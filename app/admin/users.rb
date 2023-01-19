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
  end
end
