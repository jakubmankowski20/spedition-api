class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy, :assign]
  before_action :authorize_request, only: [:my, :assign]

  attr_reader :current_user

  # GET /orders
  def index
    orders = Order.all

    
      # start_location = Location.find(t.start_location_id)
      # finish_location = Location.find(t.finish_location_id)
      # status = Status.find(t.status_id)
      # ware = Ware.find(t.ware_id)
    ordersInfo = orders.map do |t|
      {

          :id => t.id,
          :start_location =>
           {
               :name => Location.find(t.start_location_id).name,
               :short_name => Location.find(t.start_location_id).short_name,
               :country => Location.find(t.start_location_id).country,
               :city => Location.find(t.start_location_id).city,
               :street => Location.find(t.start_location_id).street,
               :building_no => Location.find(t.start_location_id).building_no,
               :latitude => Location.find(t.start_location_id).latitude,
               :longitude => Location.find(t.start_location_id).longitude
           },
          :finish_location =>
           {
              :name => Location.find(t.finish_location_id).name,
              :short_name => Location.find(t.finish_location_id).short_name,
              :country => Location.find(t.finish_location_id).country,
              :city => Location.find(t.finish_location_id).city,
              :street => Location.find(t.finish_location_id).street,
              :building_no => Location.find(t.finish_location_id).building_no,
              :latitude => Location.find(t.finish_location_id).latitude,
              :longitude => Location.find(t.finish_location_id).longitude
          },
          :start_date => t.start_date,
          :finish_date => t.finish_date,
          :status =>
              {
                  :id => t.status_id,
                  :name => Status.find(t.status_id).name
              },
          :vehicle =>
              if t.vehicle_id then
              vehicle = Vehicle.find(t.vehicle_id)
              {
                  :truck_brand => vehicle.truck_brand,
                  :register_number => vehicle.registration_number,
                  :max_load => vehicle.max_load

              }
              else
              {
                  :truck_brand => '',
                  :register_number => '',
                  :max_load => ''
              }
              end,
          :assigned_to_user =>
              if t.assigned_to_user_id then
                user = User.find(t.assigned_to_user_id)
              {
                  :name => user.name,
                  :surname => user.surname,
              }
              else
              {
                  :name => '',
                  :surname => '',
              }

              end,
          :ware =>
              {
                  :type_name => WareType.find(Ware.find(t.ware_id).ware_type_id).name,
                  :license_required => WareType.find(Ware.find(t.ware_id).ware_type_id).license_required,
                  :mass => Ware.find(t.ware_id).mass,
                  :country => Ware.find(t.ware_id).country
              }
      }
      end
    json_response(ordersInfo)
  end

  # POST /orders
  def create
    @order = Order.create!(order_params)
    json_response(@order, :created)
  end

  # GET /orders/:id
  def show
    order = Order.find(params[:id])
    start_location = Location.find(order.start_location_id)
    finish_location = Location.find(order.finish_location_id)
    status = Status.find(order.status_id)
    ware = Ware.find(order.ware_id)
    @orderInfo =
    {
        :id => order.id,
        :start_location =>
            {
                :name => start_location.name,
                :short_name => start_location.short_name,
                :country => start_location.country,
                :city => start_location.city,
                :street => start_location.street,
                :building_no => start_location.building_no,
                :latitude => start_location.latitude,
                :longitude => start_location.longitude,
            },
        :finish_location =>
            {
                :name => finish_location.name,
                :short_name => finish_location.short_name,
                :country => finish_location.country,
                :city => finish_location.city,
                :street => finish_location.street,
                :building_no => finish_location.building_no,
                :latitude => finish_location.latitude,
                :longitude => finish_location.longitude
            },
        :start_date => order.start_date,
        :finish_date => order.finish_date,
        :status =>
            {
                :id => order.status_id,
                :name => status.name
            },
        :vehicle =>
            if order.vehicle_id then
              vehicle = Vehicle.find(order.vehicle_id)
              {
                  :truck_brand => vehicle.truck_brand,
                  :register_number => vehicle.registration_number,
                  :max_load => vehicle.max_load

              }
            else
              {
                  :truck_brand => '',
                  :register_number => '',
                  :max_load => ''
              }
            end,
        :assigned_to_user =>
            if order.assigned_to_user_id then
              user = User.find(order.assigned_to_user_id)
              {
                  :name => user.name,
                  :surname => user.surname,
              }
            else
              {
                  :name => '',
                  :surname => '',
              }

            end,
        :ware =>
            {
                :type_name => WareType.find(ware.ware_type_id).name,
                :license_required => WareType.find(ware.ware_type_id).license_required,
                :mass => ware.mass,
                :country => ware.country
            }
    }
    json_response(@orderInfo)
  end

  # PUT /orders/:id
  def update
    @order.update(order_params)
    head :no_content
  end

  # DELETE /orders/:id
  def destroy
    @order.destroy
    head :no_content
  end

  # POST /orders/:id/assign
  def assign
    @order.assigned_to_user_id = current_user.id
    @order.status_id = Status.where(code:"ASSIGN").first.id
    @order.save!
    head :no_content
  end

  # GET /orders/my
  def my
    @orders = current_user.orders
    @ordersInfo = @orders.map do |t|
      start_location = Location.find(t.start_location_id)
      finish_location = Location.find(t.finish_location_id)
      status = Status.find(t.status_id)
      ware = Ware.find(t.ware_id)
      {

          :id => t.id,
          :start_location =>
              {
                  :name => start_location.name,
                  :short_name => start_location.short_name,
                  :country => start_location.country,
                  :city => start_location.city,
                  :street => start_location.street,
                  :building_no => start_location.building_no,
                  :latitude => start_location.latitude,
                  :longitude => start_location.longitude,
              },
          :finish_location =>
              {
                  :name => finish_location.name,
                  :short_name => finish_location.short_name,
                  :country => finish_location.country,
                  :city => finish_location.city,
                  :street => finish_location.street,
                  :building_no => finish_location.building_no,
                  :latitude => finish_location.latitude,
                  :longitude => finish_location.longitude
              },
          :start_date => t.start_date,
          :finish_date => t.finish_date,
          :status =>
              {
                  :id => t.status_id,
                  :name => status.name
              },
          :vehicle =>
              if t.vehicle_id then
                vehicle = Vehicle.find(t.vehicle_id)
                {
                    :truck_brand => vehicle.truck_brand,
                    :register_number => vehicle.registration_number,
                    :max_load => vehicle.max_load

                }
              else
                {
                    :truck_brand => '',
                    :register_number => '',
                    :max_load => ''
                }
              end,
          :assigned_to_user =>
              if t.assigned_to_user_id then
                user = User.find(t.assigned_to_user_id)
                {
                    :name => user.name,
                    :surname => user.surname,
                }
              else
                {
                    :name => '',
                    :surname => '',
                }
              end,
          :ware =>
              {
                  :type_name => WareType.find(ware.ware_type_id).name
              }
      }
    end
    json_response(@ordersInfo)
  end

  private

  def order_params
    # whitelist params
    params.permit(:start_location_id, :finish_location_id, :created_at, :start_date, :finish_date, :create_user_id, :status_id, :assigned_to_user_id, :description, :priority_id, :available_from, :available_to, :vehicle_id, :ware_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end

end
