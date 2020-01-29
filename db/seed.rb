require_relative 'shared.rb'
require 'bcrypt'

digested_password = BCrypt::Password.create('pudding')

# run_sql("INSERT INTO eventOrganisers (organiser_name, password_digest) VALUES ($1, $2);", ['test organiser', digested_password]);

# test_organiser = run_sql("select * from eventOrganisers").first;

# title1 = ['art', 'theatre', 'food', 'games', 'discuss']
# title2 = ['party', 'dance', 'life', 'walk', 'experience']

# 10.times do 
#     run_sql("insert into events (name, image_url, organiser_id) values ($1, $2, $3);", ["#{title1.sample} #{title2.sample}", "https://www.crucial.com.au/blog/wp-content/uploads/2014/12/events_medium.jpg", test_organiser["id"]])   
# end

run_sql("INSERT INTO users (username, email, password_digest) VALUES ($1, $2, $3);", ['test user', 'dt@ga.co', digested_password]);