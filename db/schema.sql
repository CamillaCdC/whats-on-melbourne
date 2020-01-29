

CREATE DATABASE whatsonmelbourne;

CREATE TABLE eventOrganisers (
    id SERIAL PRIMARY KEY, 
    organiser_name VARCHAR(200) UNIQUE NOT NULL, 
    password_digest VARCHAR(400) NOT NULL
);

CREATE TABLE events (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(200) NOT NULL, 
    image_url VARCHAR(500) NOT NULL, 
    organiser_id INTEGER NOT NULL, 
    FOREIGN KEY (organiser_id) REFERENCES eventOrganisers (id) ON DELETE CASCADE
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    username VARCHAR(200) NOT NULL, 
    email VARCHAR(500) UNIQUE NOT NULL, 
    password_digest VARCHAR(400) NOT NULL
);