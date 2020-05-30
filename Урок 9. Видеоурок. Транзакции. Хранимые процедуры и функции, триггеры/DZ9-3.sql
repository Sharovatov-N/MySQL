/* 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать 
фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".*/

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello() RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
  RETURN CASE
      WHEN '06:00' <= CURTIME() AND CURTIME() < '12:00' THEN 'Доброе утро'
      WHEN '12:00' <= CURTIME() AND CURTIME() < '18:00' THEN 'Добрый День'
      WHEN '18:00' <= CURTIME() AND CURTIME() < '00:00' THEN 'Добрый вечер'
      ELSE 'Доброй ночи'
    END;
END //
DELIMITER ;

SELECT hello();

/* 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были 
заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.*/

DROP TRIGGER IF EXISTS null_trigger;
DELIMITER //
CREATE TRIGGER null_trigger BEFORE INSERT ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL
    THEN SIGNAL sqlstate '45001' SET message_text = 'products name or description can not be NULL'; 
  END IF;
END //
DELIMITER ;




