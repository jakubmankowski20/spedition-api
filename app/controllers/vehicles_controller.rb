class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :update, :destroy]

  # GET /vehicles
  def index
    @vehicles = Vehicle.all
    json_response(@vehicles)
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.create!(vehicle_params)
    json_response(@vehicle, :created)
  end

  # GET /vehicles/:id
  def show
    json_response(@vehicle)
  end

  # PUT /vehicles/:id
  def update
    @vehicle.update(vehicle_params)
    head :no_content
  end

  # DELETE /vehicles/:id
  def destroy
    @vehicle.destroy
    head :no_content
  end

  private

  def vehicle_params
    # whitelist params
    params.permit(:truck_brand, :registration_number, :max_load, :produce_year, :next_review)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
