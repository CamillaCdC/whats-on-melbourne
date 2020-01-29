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
    redirect "/organiser/login" unless organiser_logged_in?
        @events = find_organiser_by_id(session[:organiser_id])
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
    erb :"/organiser/event_details"
end