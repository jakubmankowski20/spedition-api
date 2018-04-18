class Vehicle < ActiveRecord::Base

  validates_presence_of :truck_brand, :registration_number
end