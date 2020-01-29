get '/organiser/login' do
    erb :"/organiser/login"
end

post '/organiser/login' do
    @error = nil
    results = find_organiser_by_name(params[:organiserName])
    if results.count == 1 && BCrypt::Password.new(results[0]['password_digest']) == params[:password]
        session[:organiser_id] = results[0]['id']
        redirect '/organiser/events'
    else
        @error = "Incorrect username or password"
        erb :"/organiser/login"
    end
end

get '/organiser/events' do 
    @events = find_organiser_events_by_id(session[:organiser_id])
    erb :'/organiser/my_events'
end

get '/organiser/new' do
    erb :"/organiser/new"
end

post '/organiser' do
    new_organiser(params[:name], params[:password])
    redirect "/organiser/login"
end

get '/organiser/event/:id' do
    @event = find_event_by_id(params[:id])
    @num_attendees = num_users_attending_event(params[:id]) 
    @questions = find_questions_by_event_id(params[:id])
    erb :"/organiser/event_details"
end

patch '/organiser/event/:id' do
    update_event(params[:name], params[:image_url], params[:id], params[:date])
    redirect "/organiser/event/#{params[:id]}"
end