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
  
  output = {
    stops: stops
  }
  
  output.to_json
end

get '/stops/:stop_id' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  if stop.nil?
    search_error = {
      message: "Unable to find stop with id #{params[:stop_id]}"
    }
    output = {
      error: search_error
    }
  else
    stopOutput = {
      id: stop.id,
      name: stop.name,
      latitude: stop.latitude,
      longitude: stop.longitude
    }
    
    output = {
      stop: stopOutput
    }
  end
  
  output.to_json
end

get '/stops/:stop_id/times' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  
  if stop.nil?
    search_error = {
      message: "Unable to find stop with id #{params[:stop_id]}"
    }
    output = {
      error: search_error
    }
  else
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
    
    output = {
      stop_times: timesOutput
    }
  end
  
  output.to_json
end

get '/stops/:stop_id/times/:route_id' do
  content_type :json
  
  stop = Stop.find(params[:stop_id])
  
  if stop.nil?
    search_error = {
      message: "Unable to find stop with id #{params[:stop_id]}"
    }
    output = {
      error: search_error
    }
  else
    times = StopTime.where(stop_id: params[:stop_id], route_id: params[:route_id])
    
    if times.nil?
      search_error = {
        message: "Route #{params[:route_id]} does not stop at stop #{params[:stop_id]}"
      }
      output = {
        error: search_error
      }
    else
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
      
      output = {
        stop_times: timesOutput
      }
    end
  end
  
  output.to_json
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
  
  output = {
    routes: routes
  }
  
  output.to_json
end

get '/routes/:route_id' do
  content_type :json
  
  route = Route.find(params[:route_id])
  
  if route.nil?
    search_error = {
      message: "Unable to find route with id #{params[:route_id]}"
    }
    output = {
      error: search_error
    }
  else
    routeOutput = {
      id: route.id,
      name: route.name
    }
    
    output = {
      route: routeOutput
    }
  end
  
  output.to_json
end

get '/routes/:route_id/times' do
  content_type :json
  
  route = Route.find(params[:route_id])
  
  if route.nil?
    search_error = {
      message: "Unable to find route with id #{params[:route_id]}"
    }
    output = {
      error: search_error
    }
  else
    times = StopTime.where(route_id: params[:route_id]).asc(:trip_id)
    
    if times.nil?
      search_error = {
        message: "Route #{params[:route_id]} has no stops"
      }
      output = {
        error: search_error
      }
    else
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
      
      output = {
        stop_times: timesOutput
      }
    end
  end
  
  output.to_json
end