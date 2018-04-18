class StatusesController < ApplicationController

  before_action :set_status, only: [:show]

  # GET /statuses
  def index
    @statuses = Status.all
    json_response(@statuses)
  end

  # GET /statuses/:id
  def show
    json_response(@status)
  end

  private

  def set_status
    @status = Status.find(params[:id])
  end

  def status_params
    # whitelist params
    params.permit(:name, :code)
  end

end
