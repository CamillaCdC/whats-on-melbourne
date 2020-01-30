def all_events 
    run_sql("SELECT * FROM events ORDER BY date asc, start_time asc;")
end

def find_event_by_id(value)
    run_sql("SELECT * FROM events where id = $1 ORDER BY date asc;;", [value]).first
end

def update_event(name, id, date, starttime, endtime)
    run_sql("update events set name = $1, date = $2, start_time = $3, end_time = $4 where id = $5;", [name, date, starttime, endtime, id])
end

def delete_event(id)
    run_sql("delete from events where id = $1;", [id])
end

def create_new_event(name, image, organiser_id, date, description, start_time, end_time)
    run_sql("insert into events (name, image_url, organiser_id, date, description, start_time, end_time) values ($1, $2, $3, $4, $5, $6, $7);", [name, image, organiser_id, date, description, start_time, end_time])
end

def update_image(image, id)
    run_sql("update events set image_url = $1 where id = $2;", [image, id])
end