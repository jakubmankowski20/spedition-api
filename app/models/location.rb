class Location < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def address
    [country, city, street, building_no].compact.join(', ')
  end
end