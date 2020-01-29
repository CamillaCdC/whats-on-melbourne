get '/question/event/:id' do
    redirect to '/user/login' unless user_logged_in?
    @event = find_event_by_id(params[:id])
    @organiser = find_organiser_by_id(@event['organiser_id'])
    erb :"/question/ask"
end

patch '/question/answer/:id' do
    redirect to '/organiser/login' unless organiser_logged_in?
    insert_answer(params[:answer], params[:id])
    @event_id = get_event_id_from_quesiton_id(params[:id])
    redirect "/organiser/event/#{@event_id}"
end

post '/question/:id' do
    redirect to '/user/login' unless user_logged_in?
    new_question(params[:question], session[:user_id], params[:id])
    redirect "/event/#{params[:id]}"
end

get '/question/:id/answer' do
    redirect to '/organiser/login' unless organiser_logged_in?
    @question = find_question_by_id(params[:id])
    @event = find_event_by_id(@question['event_id'])
    erb :"/question/answer"    
end