class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  include Functional
  def city_openings(start_string, end_string)
    openings(start_string, end_string)
  end
end

