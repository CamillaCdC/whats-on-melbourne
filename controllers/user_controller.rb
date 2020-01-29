get '/user/login' do
    erb :"/user/login"
end

post '/user/login' do
    @error = nil
    results = find_user_by_email(params[:email])
    if results.count == 1 && BCrypt::Password.new(results[0]['password_digest']) == params[:password]
        session[:user_id] = results[0]['id']
        redirect '/'
    else
        @error = "Incorrect username or password"
        erb :"/user/login"
    end
end