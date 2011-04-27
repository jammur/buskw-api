get '/' do
  erb :index
end

get '/stops' do
  content_type :json
  
  stops = Array.new
  
  Stop.all.each do |stop|
    stops << {
      id: stop.id,
      name: stop.name,
      latitude: stop.latitude,
      longitude: stop.longitude
    }
  end
  
  stops.to_json
end

get '/stops/:stop_id' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  if stop.nil?
    raise Sinatra::NotFound
    return
  end
  
  stopOutput = {
    id: stop.id,
    name: stop.name,
    latitude: stop.latitude,
    longitude: stop.longitude
  }
  
  stopOutput.to_json
end

get '/stops/:stop_id/routes' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  if stop.nil?
    raise Sinatra::NotFound
    return
  end
  
  route_ids = Set.new
  
  times = StopTime.where(stop_id: params[:stop_id])
  times.each do |time|
    route_ids << time.route_id
  end
  
  routesOutput = Array.new
  
  route_ids.each do |route_id|
    route = Route.find(route_id)
    routesOutput << {
      id: route.id,
      name: route.name
    }
  end
  
  routesOutput.to_json
end

get '/stops/:stop_id/times' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  if stop.nil?
    raise Sinatra::NotFound
    return
  end
  
  times = StopTime.where(stop_id: params[:stop_id])
  timesOutput = Array.new
  
  times.each do |time|
    timesOutput << {
      stop_id: time.stop_id,
      trip_id: time.trip_id,
      route_id: time.route_id,
      arrival_time: time.arrival_time,
      departure_time: time.departure_time,
      stop_sequence: time.stop_sequence
    }
  end
  
  timesOutput.to_json
end

get '/stops/:stop_id/times/:route_id' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  
  if stop.nil?
    raise Sinatra::NotFound
    return
  end
  
  times = StopTime.where(stop_id: params[:stop_id], route_id: params[:route_id])
  timesOutput = Array.new

  times.each do |time|
    timesOutput << {
      stop_id: time.stop_id,
      trip_id: time.trip_id,
      route_id: time.route_id,
      arrival_time: time.arrival_time,
      departure_time: time.departure_time,
      stop_sequence: time.stop_sequence
    }
  end
  
  timesOutput.to_json
end

get '/routes' do
  content_type :json
  
  routes = Array.new
  
  Route.all.each do |route|
    routes << {
      id: route.id,
      name: route.name
    }
  end
  
  routes.to_json
end

get '/routes/:route_id' do
  content_type :json
  
  route = Route.find(params[:route_id])
  
  if route.nil?
    raise Sinatra::NotFound
    return
  end
  
  routeOutput = {
    id: route.id,
    name: route.name
  }
  
  routeOutput.to_json
end

get '/routes/:route_id/times' do
  content_type :json
  
  route = Route.find(params[:route_id])
  
  if route.nil?
    raise Sinatra::NotFound
    return
  end
  
  times = StopTime.where(route_id: params[:route_id]).asc(:trip_id)
  timesOutput = Array.new

  times.each do |time|
    timesOutput << {
      stop_id: time.stop_id,
      trip_id: time.trip_id,
      route_id: time.route_id,
      arrival_time: time.arrival_time,
      departure_time: time.departure_time,
      stop_sequence: time.stop_sequence
    }
  end
  
  timesOutput.to_json
end