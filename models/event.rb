def all_events 
    run_sql("SELECT * FROM events;")
end

def find_event_by_id(value)
    run_sql("SELECT * FROM events where id = $1;", [value]).first
end

def update_event(name, image, id, date)
    run_sql("update events set name = $1, image_url = $2, date = $3 where id = $4;", [name, image, date, id])
end

def delete_event(id)
    run_sql("delete from events where id = $1;", [id])
end

def create_new_event(name, image, organiser_id, date)
    run_sql("insert into events (name, image_url, organiser_id, date) values ($1, $2, $3, $4);", [name, image, organiser_id, date])
end