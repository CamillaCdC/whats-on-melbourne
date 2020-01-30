
def new_question(question, user, event)
    run_sql("insert into questions (question, user_id, event_id) values ($1, $2, $3);", [question, user, event])
end

def find_questions_by_event_id(id)
    questions_all = run_sql("select * from questions where event_id = $1;", [id]).to_a
end

def find_user_events_ids(user_id)
    event_ids = run_sql("select event_id from users_events_junction where user_id = $1", [user_id]).to_a
    event_ids_arr = []
    event_ids.each do |pair|
        event_ids_arr << pair.values.join.to_i
    end
    return event_ids_arr
end

def find_question_by_id(id)
    run_sql("select * from questions where id = $1", [id]).first
end

def insert_answer(answer, id)
    run_sql("update questions set answer = $1 where id = $2;", [answer, id])
end

def get_event_id_from_quesiton_id(id)
    run_sql("select event_id from questions where id = $1;", [id]).first.values.join.to_i
end

def find_answers(id)
    run_sql("select answer from questions where event_id = $1", [id])
end