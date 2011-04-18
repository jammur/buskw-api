class Stop
  include Mongoid::Document
  
  identity :type => String
  field :name
  field :latitude
  field :longitude
end