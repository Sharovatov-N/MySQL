/*  2.Подобрать сервис который будет служить основой для вашей курсовой работы.
	
Для своей курсовой работы по теме "Базы данных" я выбрал библиотеку электронных книг -  https://www.litres.ru/. 

	3.(по желанию) Предложить свою реализацию лайков и постов.
	
Для реализации постов и лайков не обходимо создать три таблицы:
1. таблица posts - посты
2. таблица like_status - справочная таблица (like, dislike)
3. таблица reviews - оценка проста (отзывы)
*/

CREATE TABLE posts (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	author_post INT UNSIGNED NOT NULL,
	post MEDIUMTEXT NOT NULL,
	created_at DATETIME DEFAULT NOW()
);

CREATE TABLE like_status (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	status VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE reviews (
	user_id INT UNSIGNED NOT NULL,
	posts_id INT UNSIGNED NOT NULL,
	comment TEXT,
	like_id INT UNSIGNED,
	created_at DATETIME DEFAULT NOW()
);