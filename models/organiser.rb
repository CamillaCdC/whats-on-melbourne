def organiser_logged_in?
    if session[:organiser_id]
      return true
    else
      return false
    end
end

def current_organiser
    current_organiser = run_sql("select * from eventOrganisers where id = $1;", [session[:organiser_id]]).first
end

def find_organiser_by_name(name)
    run_sql("select * from eventOrganisers where organiser_name = $1;", [name])
end

def find_organiser_by_id(id)
    run_sql("select * from events where organiser_id = $1", [id])
end

def new_organiser(name, password)
    digested_password = BCrypt::Password.create(password)
    run_sql("insert into eventOrganisers (organiser_name, password_digest) values ($1, $2);", [name, digested_password])
end
