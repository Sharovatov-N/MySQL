-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
u.id user_id, 
u.name,
o.id order_id
FROM users u
RIGHT JOIN
orders o 
ON
u.id = o.user_id;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 
p.id,
p.name, 
p.price,
c.id cat_id,
c.name `catalog`
FROM products p
JOIN
catalogs c
ON 
p.catalog_id = c.id; 

-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат 
-- английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE IF NOT EXISTS flights(
	id SERIAL PRIMARY KEY,
	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
	`to` VARCHAR(50) NOT NULL COMMENT 'en'
);

CREATE TABLE  IF NOT EXISTS cities(
	label VARCHAR(50) PRIMARY KEY COMMENT 'en', 
	name VARCHAR(50) COMMENT 'ru'
);

ALTER TABLE flights
	ADD CONSTRAINT flights_from_fk
	FOREIGN KEY(`from`) REFERENCES cities(label);

ALTER TABLE flights
	ADD CONSTRAINT flights_to_fk
	FOREIGN KEY(`to`) REFERENCES cities(label);

INSERT INTO cities VALUES
	('Moscow', 'Москва'),
	('Saint Petersburg', 'Санкт-Петербург'),
	('Omsk', 'Омск'),
	('Tomsk', 'Томск'),
	('Ufa', 'Уфа');

INSERT INTO flights VALUES
	(NULL, 'Moscow', 'Saint Petersburg'),
	(NULL, 'Saint Petersburg', 'Omsk'),
	(NULL, 'Omsk', 'Tomsk'),
	(NULL, 'Tomsk', 'Ufa'),
	(NULL, 'Ufa', 'Moscow');


SELECT
	id flight_id,
	(SELECT name FROM cities WHERE label = `from`) `from`,
	(SELECT name FROM cities WHERE label = `to`) `to`
FROM flights
ORDER BY flight_id;
