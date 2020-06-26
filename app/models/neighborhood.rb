class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings
  include Place::InstanceMethods
  extend Place::ClassMethods

  def neighborhood_openings(date1, date2)
    self.city_openings(date1, date2)
  end
end
