CREATE DATABASE whatsonmelbourne;

CREATE TABLE event_organisers (
    id SERIAL PRIMARY KEY, 
    organiser_name VARCHAR(200) UNIQUE NOT NULL, 
    password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(200) NOT NULL, 
    image_url VARCHAR(500) NOT NULL, 
    organiser_id INTEGER NOT NULL, 
    date VARCHAR (15) NOT NULL,
    FOREIGN KEY (organiser_id) REFERENCES event_organisers (id) ON DELETE CASCADE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    username VARCHAR(200) NOT NULL, 
    userurl VARCHAR(200) UNIQUE NOT NULL,
    email VARCHAR(500) UNIQUE NOT NULL, 
    password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE users_events_junction (
    event_id INTEGER, 
    user_id INTEGER, 
    CONSTRAINT event_user_cat_pk PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE questions (
    id SERIAL PRIMARY KEY, 
    question VARCHAR (500) NOT NULL, 
    answer VARCHAR (500),
    user_id INTEGER, 
    event_id INTEGER, 
    FOREIGN KEY (event_id) REFERENCES events (id) ON DELETE CASCADE
);