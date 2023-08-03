ActiveAdmin.register CourseInformationModule do
  permit_params :course_id,
                :name,
                :description,
                :position,
                :visible,
                course_information_module_items_attributes: [
                  :id,
                  :name,
                  :description,
                  :position,
                  :visible,
                  :_destroy
                ]

  form do |f|
    f.inputs do
      f.input :course
      f.input :name
      f.input :description
      f.input :position
      f.input :visible
      f.has_many :course_information_module_items, heading: false, allow_destroy: true do |r|
        r.input :name
        r.input :description
        r.input :position
        r.input :visible
      end
    end
    f.actions
  end

  show do
    attributes_table do
      row :course
      row :name
      row :description
      row :position
      row :visible
      row :created_at
      row :updated_at
    end

    panel "Course Information Module Items" do
      table_for course_information_module.course_information_module_items do
        column :name
        column :description
        column :position
        column :visible
      end
    end
  end

  index do
    selectable_column
    id_column
    column :course
    column :name
    column :position
    column :visible
    actions
  end
end
