get '/event/new' do 
    @min = Time.now.strftime("%Y-%m-%d")
    erb :"/event/new"
end

get '/event/:id/add' do 
    add_user_event(session[:user_id], params[:id])
    redirect "/event/#{params[:id]}"
end

get '/event/:id/remove' do
    remove_from_user_events(params[:id])
    redirect "/event/#{params[:id]}"
end

get '/event/:id' do 
    @event = find_event_by_id(params[:id])
    @questions = find_questions_by_event_id(params[:id])
    erb :"/event/details"
end

get '/event/:id/edit' do
    @min = Time.now.strftime("%Y-%m-%d")
    @event = find_event_by_id(params[:id])
    erb :"/event/edit"    
end

delete '/event/:id' do
    delete_event(params[:id])
    redirect "/organiser/events"
end

post '/event' do
    create_new_event(params[:name], params[:image_url], session[:organiser_id], params[:date])
    redirect "/organiser/events"
end

