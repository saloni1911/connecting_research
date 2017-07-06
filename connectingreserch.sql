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

-- INSERT INTO dishes(name, image_url) VALUES ('pudding', 'https://www.bbcgoodfood.com/sites/default/files/styles/recipe/public/recipe_images/recipe-image-legacy-id--1270451_8.jpg?itok=6raGNNjr');
-- INSERT INTO dishes(name, image_url) VALUES ('cake', 'https://www.puregelato.com.au/images/cake/Choc-Drip-Gelato-Cake.jpg');

CREATE TABLE comments(
	id SERIAL4 PRIMARY KEY,
	body TEXT,
	publication_id INTEGER
);
-- dish_id in this table is primary key in above table-->

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

