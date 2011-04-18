class StopTime
  include Mongoid::Document
  
  field :stop_id
  field :trip_id
  field :route_id
  field :arrival_time
  field :departure_time
  field :stop_sequence
  
  index([
    [:stop_id, Mongo::ASCENDING],
    [:route_id, Mongo::ASCENDING]
  ])
end