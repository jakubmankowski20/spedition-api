require 'rails_helper'

RSpec.describe User, type: :model do
  # Make sure User has a 1:m relationship with Order
  it { should have_many(:orders) }
  # Validation tests
  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:login) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:password_digest) }
end