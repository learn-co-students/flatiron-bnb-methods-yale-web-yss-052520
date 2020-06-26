module Place
    
    module ClassMethods
         def highest_ratio_res_to_listings
            self.all.max {|city1, city2| city1.res_to_listings <=> city2.res_to_listings }
         end
         
         def most_res
           self.all.max { |city1, city2| city1.reservations.count <=> city2.reservations.count}
         end
       
         def to_date_time(datestring)
           da = datestring.split('-')
           DateTime.new(da[0].to_i, da[1].to_i, da[2].to_i)
         end
    end
    
    module InstanceMethods
        def city_openings(datestring1, datestring2)
            # byebug
            date1 = City.to_date_time(datestring1)
            date2 = City.to_date_time(datestring2)
            self.listings.select {|listing| listing.is_open(date1, date2)}
        end
        
        def res_to_listings
            unless self.listings.count==0
              self.reservations.count.to_f/self.listings.count
            else
              0
            end
        end
    end
    
end