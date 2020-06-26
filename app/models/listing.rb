class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  # has_many :guests, :class_name => "User", :through => :reservations
  has_many :guests, :through => :reservations
  after_create :make_user_host
  before_destroy :unmake_user_host
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood_id, presence: true

  def is_open(date1, date2)
    # byebug
    !self.reservations.find {|res| res.checkin.between?(date1, date2) || res.checkin.between?(date1, date2) } 
  end

  def average_review_rating
    if self.reviews.count > 0
      self.reviews.sum(&:rating).to_f/self.reviews.count
    else
      0
    end
  end

  # private

  def make_user_host
    self.host.update(host: true)
  end

  def unmake_user_host
    # byebug
    # if host.listings.reject{|listing| listing == self}.empty?
    # byebug
    if self.host.listings.reject{|listing| listing == self}.empty?
      puts "Making the Host false"
      self.host.update(host: false)
    end
  end
  
end
