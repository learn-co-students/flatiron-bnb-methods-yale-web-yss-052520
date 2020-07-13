class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, :through => :listings

  def neighborhood_openings(startdate, enddate)
    listings.select {|l| l.available(startdate.to_datetime, enddate.to_datetime) }
  end

  def self.highest_ratio_res_to_listings
    all.max_by {|neighborhood| neighborhood.ratio_res_to_listings}
  end

  def ratio_res_to_listings
    listings.count == 0 ? 0 : reservations.count / listings.count
  end

  def self.most_res
    all.max_by {|neighborhood| neighborhood.reservations.count}
  end
end
