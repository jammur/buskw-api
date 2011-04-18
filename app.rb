get '/' do
  erb :index
end

get '/stops' do
  content_type :json
  
  output = {
    stops: Stop.all
  }
  
  output.to_json
end

get '/stops/:stop_id' do
  content_type :json
  
  output = Stop.find(params[:stop_id])
  
  if output.nil?
    search_error = {
      message: "Unable to find stop with id #{params[:stop_id]}"
    }
    output = {
      error: search_error
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
    output = {
      stop_times: times
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
      output = {
        stop_times: times
      }
    end
  end
  
  output.to_json
end