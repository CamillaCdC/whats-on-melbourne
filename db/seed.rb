require_relative 'shared.rb'
require 'bcrypt'
require 'pry'

# digested_password = BCrypt::Password.create('pudding')

# run_sql("INSERT INTO event_organisers (organiser_name, password_digest, email) VALUES ($1, $2, $3);", ['test organiser', digested_password, "dt@ga.co"]);

test_organiser = run_sql("select * from event_organisers").first;

title1 = ['art', 'theatre', 'food', 'games', 'discuss']
title2 = ['party', 'dance', 'life', 'walk', 'experience']

description = "The Lady of the Lake, her arm clad in the purest shimmering samite, held aloft Excalibur from the bosom of the water, signifying by divine providence that I, Arthur, was to carry Excalibur. That is why I am your king. Well, we did do the nose. Well, Mercia's a temperate zone! What a strange person."

image = "https://www.crucial.com.au/blog/wp-content/uploads/2014/12/events_medium.jpg"

10.times do 
    run_sql("insert into events (name, image_url, description, organiser_id, date, start_time, end_time) values ($1, $2, $3, $4, $5, $6, $7);", ["#{title1.sample} #{title2.sample}", "#{image}", "#{description}", test_organiser["id"], Time.now.strftime("%Y-%m-%d"), "18:00", "21:30"])   
end

# username = 'test user'

# userurl = username.gsub(" ", "-")

# run_sql("INSERT INTO users (username, userurl, email, password_digest) VALUES ($1, $2, $3, $4);", [username, userurl, 'dt@ga.co', digested_password]);