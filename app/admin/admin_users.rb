ActiveAdmin.register AdminUser do
  menu priority: 2
  permit_params :email, :password, :password_confirmation, :name, :surname

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :name
    column :surname
    actions
  end

  filter :name
  filter :surname
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :surname
    end
    f.actions
  end


end
