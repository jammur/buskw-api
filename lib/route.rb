class Route
  include Mongoid::Document
  
  identity :type => String
  field :name
end