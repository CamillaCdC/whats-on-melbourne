get '/event/new' do 
    @min = Time.now.strftime("%Y-%m-%d")
    erb :"/event/new"
end

get '/event/:id/add' do 
    redirect "/event/#{params[:id]}" unless user_logged_in?
        add_user_event(session[:user_id], params[:id])
        redirect "/event/#{params[:id]}"
end

get '/event/:id/remove' do
    redirect "/event/#{params[:id]}" unless user_logged_in?
        remove_from_user_events(params[:id])
        redirect "/event/#{params[:id]}"
end

get '/event/:id' do 
    @event = find_event_by_id(params[:id])
    erb :"/event/details"
end

get '/event/:id/edit' do
    redirect "/organiser/login" unless organiser_logged_in?
        @event = find_event_by_id(params[:id])
        erb :"/event/edit"    
end

patch '/event/:id' do
    redirect "/organiser/login" unless organiser_logged_in?
        update_event(params[:name], params[:image_url], params[:id])
        redirect "/event/#{params[:id]}"
end

delete '/event/:id' do
    redirect "/organiser/login" unless organiser_logged_in?
        delete_event(params[:id])
        redirect "/organiser/events"
end

post '/event' do
    redirect "/organiser/login" unless organiser_logged_in?
        create_new_event(params[:name], params[:image_url], session[:organiser_id])
        redirect "/organiser/events"
end

