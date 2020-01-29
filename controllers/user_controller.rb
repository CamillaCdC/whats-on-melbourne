get '/user/login' do
    erb :"/user/login"
end

post '/user/login' do
    @error = nil
    results = find_user_by_email(params[:email])
    if results.count == 1 && BCrypt::Password.new(results[0]['password_digest']) == params[:password]
        session[:user_id] = results[0]['id']
        redirect "/user/#{results.to_a.first['userurl']}/events"
    else
        @error = "Incorrect username or password"
        erb :"/user/login"
    end
end

get '/user/:userurl/events' do
    redirect to '/user/login' unless user_logged_in?
    @events = find_user_events_info(session[:user_id])
    erb :'/user/my_events'
end

get '/user/new' do
    erb :"/user/new"
end

post '/user' do
    new_user(params[:name], params[:email], params[:password])
    redirect "/user/login"
end