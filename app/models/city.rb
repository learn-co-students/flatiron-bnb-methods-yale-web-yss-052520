class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(start, finish) 
    #count total available listings for date range 
    self.listings.select{|listing| listing.free_in_dates(date(start),date(finish)) == true}
  end  

  def self.highest_ratio_res_to_listings
    #return city object with highest reservation:listing ratio 
    city_obj = 0
    max = 0 
    self.all.each do |city| 
      if (city.total_reservations / city.listings.length ) > max
        max = city.total_reservations / city.listings.length 
        city_obj = city  
      end 
    end
    return city_obj 
  end 

  def self.most_res 
    city_obj = 0
    max = 0 
    self.all.each do |city| 
      if city.total_reservations > max 
        max = city.total_reservations 
        city_obj = city 
      end
    end 
    return city_obj 
  end 

  def total_reservations
    #count total reservations in one city 
    sum = 0.0 
    self.listings.each do |listing| 
      sum += listing.reservations.count
    end 
    return sum 
  end 

  private 

  def date(string)
    #converts string input date to Date object 
    array = string.split("-") 
    Date.new(array[0].to_i, array[1].to_i, array[2].to_i) 
  end 

end

