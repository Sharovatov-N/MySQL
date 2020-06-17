--  ^^^^^^^^^^^^^^^ 6. скрипты характерных выборок (включающие группировки, JOIN'ы, вложенныетаблицы) ^^^^^^^^^^^^^^^^^^ 

-- Выбрать все книги одного автора (например автора с id = 21).

SELECT id, name_book AS Название FROM books b WHERE id IN
	(SELECT book_id FROM authors_books ab WHERE author_id = 21);

-- Выбрать самого популярного автора.

SELECT DISTINCT ab.author_id,
COUNT(ab.author_id) AS number_books_sold
	FROM authors_books ab
		LEFT JOIN orders_books ob
	ON ob.book_id = ab.book_id WHERE ob.order_id IS NOT NULL
GROUP BY ab.author_id 
ORDER BY number_books_sold DESC
LIMIT 1;

-- Выбрать все книги купленные одним читателем (моя книжная полка).

SELECT id, name_book AS Название FROM books b WHERE id IN 
	(SELECT book_id FROM orders_books ob WHERE order_id IN 
		(SELECT number_order FROM orders o WHERE reader_id = 76)); 

-- Выбрать самого молодого автора в жанре "Детские книги" и выяснить кто он - мужчина или женщина.

SELECT DISTINCT authors_books.author_id, 
author.first_name, 
author.last_name,
profile_author.birthday,
profile_author.gender 
	FROM books 
		JOIN authors_books
	ON  authors_books.book_id = books.id AND books.genre_id = 10 
		LEFT JOIN author 
	ON authors_books.author_id = author.id 
		LEFT JOIN profile_author
	ON profile_author.author_id = author.id 
ORDER BY profile_author.birthday DESC
LIMIT 1;

-- Выбрать десять самых популярных книг.

SELECT DISTINCT books.id,
	name_book,
	COUNT(orders_books.book_id ) AS number_books_sold
FROM books
	JOIN orders_books 
ON orders_books.book_id = books.id
GROUP BY orders_books.book_id
ORDER BY number_books_sold DESC
LIMIT 10; 

-- Выбрать читателей, которые не купили ни одной книги.

SELECT r.id
FROM readers r 
	LEFT JOIN orders
ON orders.reader_id = r.id WHERE orders.number_order IS NULL
GROUP BY r.id ;

-- ^^^^^^^^^^^^^^^^^^^^^^ 7. представления (минимум 2) ^^^^^^^^^^^^^^^^^^^^^^^^^

CREATE VIEW name_book_author_last_name AS SELECT books.name_book AS Название_книги, author.last_name AS Фамилия_автора 
    FROM books
    	LEFT JOIN authors_books 
    ON authors_books.book_id = books.id 
		LEFT JOIN author 
    ON authors_books.author_id = author.id ;
    
 SELECT * FROM name_book_author_last_name;

CREATE VIEW list_authors AS SELECT last_name, first_name FROM author ORDER BY last_name;

SELECT * FROM list_authors;

-- ^^^^^^^^^^^^^^^^^^^^^^^ 8. хранимые процедуры / триггеры ^^^^^^^^^^^^^^^^^^^^^^^^
 
DROP TRIGGER IF EXISTS book_author_b;
DELIMITER //
CREATE TRIGGER book_author_b AFTER INSERT ON books
FOR EACH ROW
BEGIN
    INSERT INTO authors_books (book_id, created_at, updated_at) VALUES (NEW.id, DEFAULT, DEFAULT);
END //
DELIMITER ;

DROP TRIGGER IF EXISTS book_author_a;
DELIMITER //
CREATE TRIGGER book_author_a AFTER INSERT ON authors_books FOR EACH ROW
BEGIN
  IF NEW.author_id IS NULL
    THEN SIGNAL sqlstate '45001' SET message_text = 'author can not be NULL'; 
  END IF;
END //
DELIMITER ;

