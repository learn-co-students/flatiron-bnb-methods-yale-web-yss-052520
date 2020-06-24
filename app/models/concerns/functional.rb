module Functional
    extend ActiveSupport::Concern
    # methods defined here are going to extend the class, not the instance of it
    module ClassMethods
        def highest_ratio_res_to_listings
            self.all.max_by { |c| 
              reserves = get_reservations(c.listings).flatten.count
              c.listings.count == 0 ? 0 : reserves.to_f/c.listings.count
            }
          end 
        
          def most_res
            self.all.max_by { |c| 
              get_reservations(c.listings).flatten.count
            }
          end

          private

          def get_reservations(listings)
            listings.map{|l| l.reservations}
          end
    end

    def openings(start_string, end_string)
        @start_date = convert_to_date(start_string)
        @end_date = convert_to_date(end_string)
    
        self.listings.select{|listing|
          reserves = listing.reservations
          reserves.empty? || valid_reserve?(reserves)
        }
    end

    private

    def convert_to_date(date_str)
        Date.strptime(date_str, "%Y-%m-%d")
    end
    
     def valid_reserve?(reserves)
       reserves.reduce(true){|valid, r| 
         valid && !in_between(r.checkin) && !in_between(r.checkout)
       }
     end
    
     def in_between(date_str)
       date_str.between?(@start_date, @end_date)
     end
end