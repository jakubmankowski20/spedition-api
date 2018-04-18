require 'rails_helper'

RSpec.describe 'Vehicles API', type: :request do
  # init data
  let!(:vehicles) { create_list(:vehicle, 10) }
  let(:vehicle_id) { vehicles.first.id }

  # GET /vehicles
  describe 'GET /vehicles' do 
    before { get '/vehicles' }

    it 'returns vehicles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end
end