class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'
  
  has_many :guests, :through => :reservations, :class_name => "User"
  
  #Don't know how to do this in Active Record Associations 
  def hosts 
    self.trips.map {|trip| trip.listing.host }
  end 

  def host_reviews 
    self.reservations.map {|res| res.review }
  end 
end
