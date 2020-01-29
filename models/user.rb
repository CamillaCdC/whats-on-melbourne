def user_logged_in?
    if session[:user_id]
      return true
    else
      return false
    end
end

def find_user_by_email(email)
    run_sql("select * from users where email = $1;", [email])
end

def current_user
    current_user = run_sql("select * from users where id = $1;", [session[:user_id]]).first
end

def find_user_by_id(id)
    run_sql("select * from users where id = $1;", [id])
end

def add_user_event(user_id, event_id)
    run_sql("insert into users_events_junction (user_id, event_id) values ($1, $2);", [user_id, event_id])
end

def find_user_events_info(user_id)
    event_ids = run_sql("select event_id from users_events_junction where user_id = $1", [user_id]).to_a
    event_info = []
    event_ids.each do |pair|
        event = pair.values.join.to_i
        event_info << run_sql("select name, image_url, id, date from events where id = $1", [event]).first
    end
    event_info.sort_by do |event|
        event['date']
    end
end

def find_user_events_ids(user_id)
    event_ids = run_sql("select event_id from users_events_junction where user_id = $1", [user_id]).to_a
    event_ids_arr = []
    event_ids.each do |pair|
        event_ids_arr << pair.values.join.to_i
    end
    return event_ids_arr
end

def user_attending(event_id)
    events_attending = find_user_events_ids(session[:user_id])
    events_attending.include? event_id.to_i
end

def remove_from_user_events(event_id)
    run_sql("delete from users_events_junction where event_id = $1 and user_id = $2;", [event_id, session[:user_id]])
end

def new_user(name, email, password)
    digested_password = BCrypt::Password.create(password)
    userurl = name.gsub(" ", "-")
    run_sql("insert into users (username, userurl, email, password_digest) values ($1, $2, $3, $4);", [name, userurl, email, digested_password])
end