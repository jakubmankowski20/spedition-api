ActiveAdmin.register Vehicle do
  menu priority: 6
  permit_params :truck_brand, :registration_number, :max_load, :produce_year, :next_review

  index do
    selectable_column
    column :truck_brand
    column :registration_number
    column :max_load
    column :produce_year
    column :next_review
    actions
  end
  form do |f|
    f.inputs "Vehicle" do
      f.input :truck_brand
      f.input :registration_number
      f.input :max_load
      f.input :produce_year
      f.input :next_review
    end
    f.actions
  end
  actions :index, :show, :new, :create, :update, :edit
end
ActiveAdmin.setup do |config|
  config.default_per_page = 30
end
