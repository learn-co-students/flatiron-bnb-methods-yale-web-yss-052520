class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  include Functional

  def neighborhood_openings(start_string, end_string)
    openings(start_string, end_string)
  end
end
