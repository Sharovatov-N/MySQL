-- Практическое задание по теме “Оптимизация запросов”

/* 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата 
создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS dump_log_users;
DELIMITER //
CREATE TRIGGER dump_log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
DELIMITER ;

DROP TRIGGER IF EXISTS dump_log_catalogs;
DELIMITER //
CREATE TRIGGER dump_log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;

DROP TRIGGER IF EXISTS dump_log_products;
DELIMITER //
CREATE TRIGGER dump_log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
DELIMITER ;

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DROP TABLE IF EXISTS test_users; 
CREATE TABLE test_users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
 	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP PROCEDURE IF EXISTS insert_into_users ;
DELIMITER //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 100;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO test_users(name, birthday_at) VALUES (CONCAT('user_', j), DATE(CURRENT_TIMESTAMP - INTERVAL FLOOR(RAND() * 365) DAY));
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //
DELIMITER ;

SELECT * FROM test_users;

CALL insert_into_users();

SELECT * FROM test_users LIMIT 3;


-- Практическое задание по теме “NoSQL”

-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

SADD ip '127.0.0.1' '127.0.0.2' '127.0.0.3'

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

set alex@mail.ru alex 
set alex alex@mail.ru

get alex@mail.ru 
get alex 

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use products
db.products.insert({
	"name": "Intel Core i3-8100", 
	"description": "Процессор для настольных ПК", 
	"price": "8000.00", 
	"catalog_id": "Процессоры", 
	"created_at": new Date(), 
	"updated_at": new Date()
}) 

db.products.insertMany([
	{
		"name": "AMD FX-8320", 
		"description": "Процессор для настольных ПК", 
		"price": "4000.00", 
		"catalog_id": "Процессоры", 
		"created_at": new Date(), 
		"updated_at": new Date()
	},
	{
		"name": "AMD FX-8320E", 
		"description": "Процессор для настольных ПК", 
		"price": "4500.00", 
		"catalog_id": "Процессоры", 
		"created_at": new Date(), 
		"updated_at": new Date()
	}
])

db.products.find().pretty()
db.products.find({name: "AMD FX-8320"}).pretty()
