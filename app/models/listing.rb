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

  after_create :become_host
  after_destroy :become_user

  def average_review_rating()
    reviews.average(:rating)
  end

  private

  def become_host()
    self.host.update(host: true)
  end

  def become_user()
    self.host.update(host: false) if self.host.listings.empty?
  end
end
