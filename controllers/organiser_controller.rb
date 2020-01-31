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
    redirect to '/organiser/login' unless organiser_logged_in?
    @events = find_organiser_events_by_id(session[:organiser_id])
    erb :'/organiser/my_events'
end

get '/organiser/new' do
    erb :"/organiser/new"
end

post '/organiser' do
    new_organiser(params[:name], params[:password], params[:email])
    redirect "/organiser/login"
end

get '/organiser/event/:id' do
    redirect to '/organiser/login' unless organiser_logged_in?
    @event = find_event_by_id(params[:id])
    @num_attendees = num_users_attending_event(params[:id]) 
    @questions = find_questions_by_event_id(params[:id])
    Ausburbs::state("VIC").suburbs.each do |suburb| 
        if suburb.postcode == @event['postcode'] 
            @suburb = suburb.name.capitalize
        end
    end
    erb :"/organiser/event_details"
end

patch '/organiser/event/:id' do
    redirect to '/organiser/login' unless organiser_logged_in?
    update_event(params[:name], params[:id], params[:date], params[:starttime], params[:endtime], params[:postcode])
    redirect "/organiser/event/#{params[:id]}"
end

patch '/organiser/event/:id/edit_image' do
    redirect to '/organiser/login' unless organiser_logged_in?
    auth = {
        cloud_name: "davvorufu",
        api_key:    "143522215714335",
        api_secret: "sjpmAB8vJZ4zB3s0QFwfGirz0FU"
    }

    image = Cloudinary::Uploader.upload(params[:image][:tempfile], auth)

    update_image(image['secure_url'], params[:id])

    redirect "/event/#{params[:id]}/edit"
end
