# require_relative './concerns/analyzable.rb'

class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  include Analyzable::InstanceMethods
  extend Analyzable::ClassMethods

  def city_openings(start_date, end_date)
    openings(start_date, end_date)
  end 
end

