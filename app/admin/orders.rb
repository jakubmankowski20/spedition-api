ActiveAdmin.register Order do

  menu priority: 4
  permit_params :start_location_id, :finish_location_id, :start_date, :finish_date, :create_user_id,:assigned_to_user_id, :vehicle_id, :ware_id

  index do
    selectable_column
    id_column
    column :start_location_id do |p|
      Location.find(p.start_location_id).city << " " << Location.find(p.start_location_id).name

    end
    column :finish_location_id do |p|
      Location.find(p.finish_location_id).city << " " << Location.find(p.finish_location_id).name
    end
    column :start_date
    column :finish_date
    column :create_user_id do |p|
      AdminUser.find(p.create_user_id).name.to_s << " " << AdminUser.find(p.create_user_id).surname.to_s
    end
    column :status_id do |p|
      Status.find(p.status_id).name
    end
    column :assigned_to_user_id do |p|
      if p.assigned_to_user_id then 
        User.find(p.assigned_to_user_id).name.to_s  << " " << User.find(p.assigned_to_user_id).surname.to_s
      else
        "No user assigned"
      end
    end
    column :vehicle_id do |p|
      if p.vehicle_id then
        Vehicle.find(p.vehicle_id).truck_brand  << " " << Vehicle.find(p.vehicle_id).registration_number
      else
        "No vehicle assigned"
      end
    end
    column :ware_id do |p|
      WareType.find(Ware.find(p.ware_id).ware_type_id).name
    end
    actions
  end

  form do |f|
    f.inputs "Orders" do
      f.input :start_location_id, as: :select, collection: Location.all.map{|u| ["#{u.city}, #{u.name}", u.id]}, include_blank: false, input_html: { autofocus: true }
      f.input :finish_location_id, as: :select, collection: Location.all.map{|u| ["#{u.city}, #{u.name}", u.id]}, include_blank: false
      f.input :start_date, as: :datetime_picker, :input_html => {:step => 60}
      f.input :finish_date, as: :datetime_picker, :input_html => {:step => 60}
      f.input :create_user_id , as: :select, collection: AdminUser.all.map{|u| ["#{u.name} #{u.surname}", u.id]}, include_blank: false
      f.input :assigned_to_user_id , as: :select, collection: User.all.map{|u| ["#{u.name} #{u.surname}", u.id]}
      f.input :description
      f.input :vehicle_id, as: :select, collection: Vehicle.all.map{|u| ["#{u.truck_brand} #{u.registration_number}", u.id]}
      f.input :ware_id, as: :select, collection: Ware.all.map{|u| ["#{WareType.find(Ware.find(u.id).ware_type_id).name} #{u.country} #{u.mass} t", u.id]}, include_blank: false
    end
    f.actions
  end

  filter :start_location_id, as: :select, collection: proc { Hash[Location.all.map{|u| ["#{u.city}, #{u.name}", u.id]}]}
  filter :finish_location_id, as: :select, collection: proc { Hash[Location.all.map{|u| ["#{u.city}, #{u.name}", u.id]}]}
  filter :create_user_id, as: :select, collection: proc { Hash[AdminUser.all.map{|u| ["#{u.name.to_s} #{u.surname.to_s}", u.id]}]}
  filter :assigned_to_user_id, as: :select, collection: proc { Hash[User.all.map{|u| ["#{u.name} #{u.surname}", u.id]}]}
  filter :vehicle_id, as: :select, collection: proc { Hash[Vehicle.all.map{|u| ["#{u.truck_brand} #{u.registration_number}", u.id]}]}
  filter :ware_id, as: :select, collection: proc { Hash[Ware.all.map{|u| ["#{u.ware_type_id} #{u.mass} t", u.id]}]}

  actions :index, :show, :new, :create, :update, :edit, :destroy

  show do
    attributes_table do
      row :start_location_id do |p|
        @actual_order = p
        Location.find(p.start_location_id).city << " " << Location.find(p.start_location_id).name
      end
      row :finish_location_id do |p|
        Location.find(p.finish_location_id).city << " " << Location.find(p.finish_location_id).name
      end
      row :start_date
      row :finish_date
      row :create_user_id
      # do |p|
      #   AdminUser.find(p.create_user_id).name.to_s << " " << AdminUser.find(p.create_user_id).surname.to_s
      # end
      row :assigned_to_user_id do |p|
        if p.assigned_to_user_id then
          User.find(p.assigned_to_user_id).name.to_s  << " " << User.find(p.assigned_to_user_id).surname.to_s
        else
          "No user assigned"
        end
      end
      row :vehicle_id do |p|
        if p.vehicle_id then
          Vehicle.find(p.vehicle_id).truck_brand  << " " << Vehicle.find(p.vehicle_id).registration_number
        else
          "No vehicle assigned"
        end
      end
      row :ware_id do |p|
        WareType.find(Ware.find(p.ware_id).ware_type_id).name
      end
    end
    history = History.all
    panel "Status history" do
      table_for history.where('order_id = ?', @actual_order).order('change_time desc') do |t|
        t.column("From status") { |hist| Status.find(Transition.find(hist.status_transition_id).status_from_id).name }
        t.column("To status") { |hist| Status.find(Transition.find(hist.status_transition_id).status_to_id).name }
        t.column("Change Date") { |hist| hist.change_time}
      end
    end
  end

  scope :all, :default => true
  scope :open do |orders|
    orders.where('orders.status_id = (SELECT ID FROM STATUSES WHERE statuses.code  = ? )', 'OPEN')
  end
  scope :assign do |orders|
    orders.where('orders.status_id = (SELECT ID FROM STATUSES WHERE statuses.code  = ? )', 'ASSIGN')
  end
  scope :delivered do |orders|
    orders.where('orders.status_id = (SELECT ID FROM STATUSES WHERE statuses.code  = ? )', 'CLOSE')
  end
end

ActiveAdmin.setup do |config|
  config.default_per_page = 30
  config.batch_actions = false
end
