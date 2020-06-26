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
 
 
  before_create :make_user_host 
  before_destroy :make_user_not_host  

  def free_in_dates(start, finish)
    # checks if listing is free between start and finish dates 
    self.reservations.each do |res| 
      if res.res_in_dates(start,finish)  
        return false 
      end 
    end 
    return true 
  end 

  def average_review_rating
    sum, count = 0.0 , 0.0 
    self.reviews.each do |review| 
      if review.rating 
        sum += review.rating 
        count += 1 
      end 
    end 
    return sum / count 
  end 

  private 

  def make_user_host 
    if self.host 
      self.host.update_attribute(:host, true)
    end 
  end 

  def make_user_not_host 
    if self.host 
      self.host.update_attribute(:host, false) if self.host.listings.length == 1 
    end 
  end 

end
