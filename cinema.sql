DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;


CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE tickets (
  id SERIAL8 PRIMARY KEY,
  customer_id INT8 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT8 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id SERIAL8 PRIMARY KEY,
  start_time TIMESTAMP,
  tickets_sold INT,
  film INT8 REFERENCES films(id) ON DELETE CASCADE
)
