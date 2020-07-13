class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true

  before_create do 
    self.host.update(host: true)
  end

  before_destroy do
    if self.host.listings.count == 1
      self.host.update(host: false)
    end
  end

  def available(startdate, enddate)
    !reservations.find {|reservation| reservation.checkin.between?(startdate - 1, enddate + 1) || reservation.checkout.between?(startdate - 1, enddate + 1) }
  end

  def average_review_rating
    reviews.average(:rating)
  end

end
