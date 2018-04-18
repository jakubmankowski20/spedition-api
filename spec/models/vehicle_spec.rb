require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  it { should validate_presence_of(:truck_brand) }
  it { should validate_presence_of(:registration_number) }
end