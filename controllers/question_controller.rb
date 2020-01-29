get '/question/event/:id' do
    @event = find_event_by_id(params[:id])
    @organiser = find_organiser_by_id(@event['organiser_id'])
    erb :"/question/ask"
end

patch '/question/answer/:id' do
    insert_answer(params[:answer], params[:id])
    @event = get_event_from_quesiton_id(params[:id])[0]['event_id']
    redirect "/organiser/event/#{@event}"
end

post '/question/:id' do
    new_question(params[:question], session[:user_id], params[:id])
    redirect "/event/#{params[:id]}"
end

get '/question/:id/answer' do
    @question = find_question_by_id(params[:id])
    @event = find_event_by_id(@question['event_id'])
    erb :"/question/answer"    
end