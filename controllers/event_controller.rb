get '/event/new' do 
    erb :"/event/new"
end

get '/event/:id' do 
    @event = find_event_by_id(params[:id])
    erb :"/event/details"
end

get '/event/:id/edit' do
    @event = find_event_by_id(params[:id])
    erb :"/event/edit"    
end

patch '/event/:id' do
    update_event(params[:name], params[:image_url], params[:id])
    redirect "/event/#{params[:id]}"
end

delete '/event/:id' do
    delete_event(params[:id])
    redirect "/organiser/events"
end

post '/event' do
    create_new_event(params[:name], params[:image_url], session[:organiser_id])
    redirect "/organiser/events"
  end