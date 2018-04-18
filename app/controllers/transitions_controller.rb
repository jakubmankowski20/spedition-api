class TransitionsController < ApplicationController
  before_action :set_transition, only: [:show]

  # GET /transitions
  def index
    @transitions = (Transition.all).where('is_internal = false')
    @transitionsInfo = @transitions.map do |t|
    {
        :id => t.id,
        :status_from =>
        {
            :id => Status.find(t.status_from_id).id,
            :name => Status.find(t.status_from_id).name,
            :code => Status.find(t.status_from_id).code
        },
        :status_to =>
        {
            :id => Status.find(t.status_to_id).id,
            :name => Status.find(t.status_to_id).name,
            :code => Status.find(t.status_to_id).code
        }
    }
    end
    json_response(@transitionsInfo)
  end

  # GET /transitions/:id
  def show
    json_response(@transition)
  end

  private

  def set_transition
    @transition = Transition.find(params[:id])
  end

  def transition_params
    # whitelist params
    params.permit(:status_from_id, :status_to_id)
  end
end
