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
  validates :neighborhood_id, presence: true 

  before_create :change_host_status_true
  before_destroy :change_host_status_false 

  def change_host_status_true
    new_host = User.find(self.host_id)
    new_host.update(host: true)
  end 

  def change_host_status_false
    old_host = User.find(self.host_id)
    if old_host.listings.size == 1 
      old_host.update(host: false)
    end 
  end 

  def average_review_rating 
    self.reviews.reduce(0) {|sum, review| sum + review.rating} / self.reviews.size.to_f
  end 
end
