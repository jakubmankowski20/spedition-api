ActiveAdmin.register WareType do
  menu priority: 9.1
  permit_params :name, :code, :license_required
  index do
    selectable_column
    column :name
    column :code
    column :license_required
    actions
  end
  form do |f|
    f.inputs "Ware Types" do
      f.input :name
      f.input :code
      f.input :license_required
    end
    f.actions
  end
  actions :index, :show, :new, :create, :update, :edit
end
ActiveAdmin.setup do |config|
  config.default_per_page = 30
end
