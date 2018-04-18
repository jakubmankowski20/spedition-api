class UserController < ApplicationController
  before_action :authorize_request

  # GET /user/profile
  def profile 
    json_response(@current_user)
  end

  # PUT /user/update
  def update
    @current_user.update(user_params)
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :surname, :email, :phone_number)
  end
end
