CREATE TABLE users(
	id SERIAL4 PRIMARY KEY,
	name VARCHAR(400),
	email VARCHAR(400),
	password_digest TEXT,
	location VARCHAR(400),
	degree VARCHAR,
	research_institute VARCHAR,
	research_field_id INTEGER
);

CREATE TABLE comments(
	id SERIAL4 PRIMARY KEY,
	body TEXT,
	user_id INTEGER
);
ALTER TABLE comments ADD COLUMN session_id INTEGER;

CREATE TABLE publications(
	id SERIAL4 PRIMARY KEY,
	title TEXT,
	authors TEXT,
	journal_name VARCHAR,
	user_id INTEGER
);

ALTER TABLE publications ADD COLUMN url VARCHAR;
ALTER TABLE publications ADD COLUMN publication_date VARCHAR(400);

CREATE TABLE research_fields(
	id SERIAL4 PRIMARY KEY,
	name VARCHAR(400)
);

