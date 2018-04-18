ActiveAdmin.register User do
  menu priority: 3
  permit_params :name, :surname, :email, :phone_number, :password
  index do
    selectable_column
    column :name
    column :surname
    column :email
    column :phone_number
    column :create_at
    actions
  end
  form do |f|
    f.inputs "Users" do
      f.input :name
      f.input :surname
      f.input :email
      f.input :phone_number
      f.input :password

    end
    f.actions
  end
  filter :name
  filter :surname
  filter :email
  filter :created_at
  actions :index, :show, :new, :create, :update, :edit
end
ActiveAdmin.setup do |config|
  config.default_per_page = 30
end
