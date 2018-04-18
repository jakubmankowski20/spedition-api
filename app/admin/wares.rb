ActiveAdmin.register Ware do
  menu priority: 9
  permit_params :ware_type_id, :mass, :country

  index do
    selectable_column
    column :ware_type_id do |p|
      WareType.find(p.ware_type_id).name
    end
    column :mass
    column :country
    actions
  end
  form do |f|
    f.inputs "Wares" do
      f.input :ware_type_id , as: :select, collection: WareType.all.map{|u| ["#{u.name}", u.id]}
      f.input :mass
      f.input :country
    end
    f.actions
  end

  filter :ware_type_id , as: :select, collection: proc { Hash[WareType.all.map{|u| ["#{u.name}", u.id]}]}
  filter :mass
  filter :country

  show do
    attributes_table do
      row :ware_type_id do |p|
        WareType.find(p.ware_type_id).name
      end
      row :mass
      row :country
    end
  end

  actions :index, :show, :new, :create, :update, :edit
end
ActiveAdmin.setup do |config|
  config.default_per_page = 30
end
