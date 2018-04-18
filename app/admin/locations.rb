ActiveAdmin.register Location do
  menu priority: 5
  permit_params :name, :short_name, :country, :city, :street, :building_no

  index do
    selectable_column
    column :name
    column :short_name
    column :country
    column :city
    column :street
    column :building_no
    actions
  end

  form do |f|
    f.inputs "Locations" do
      f.input :name
      f.input :short_name
      f.input :country
      f.input :city
      f.input :street
      f.input :building_no
    end
    f.actions
  end

  filter :name
  filter :country
  filter :city
  filter :street
  actions :index, :show, :new, :create, :update, :edit, :destroy
end
ActiveAdmin.setup do |config|
  config.default_per_page = 30
end
