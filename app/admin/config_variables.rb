ActiveAdmin.register ConfigVariable do
  permit_params :name, :key, :value_type, :value, :description
  actions :all, except: [:new, :destroy]

  index do
    selectable_column
    id_column
    column :name
    tag_column :value_type
    column :value
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :key
      tag_row :value_type
      row :value
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :value
      f.input :description
    end
    f.actions
  end
end
