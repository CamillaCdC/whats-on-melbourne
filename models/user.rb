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