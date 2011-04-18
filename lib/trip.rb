class Trip
  include Mongoid::Document
  
  identity :type => String
  field :route_id
  field :headsign
end