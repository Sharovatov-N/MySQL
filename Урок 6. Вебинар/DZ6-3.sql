   
-- Удаляем внешний ключ таблица 'likes', столбец 'target_id' (ошибочно создан)   
ALTER TABLE likes 
	DROP FOREIGN KEY likes_target_id_fk;

-- 3. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).

SELECT 
COUNT(*) `likes`,
target_id `users`,
(SELECT birthday FROM profiles WHERE user_id = likes.target_id) birthday 
FROM likes 
	WHERE target_id IN(
SELECT (SELECT from_user_id FROM messages m WHERE id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'messages')
UNION
SELECT (SELECT user_id FROM profiles p WHERE user_id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'users')
UNION
SELECT (SELECT user_id FROM media m2 WHERE id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'media')
UNION
SELECT (SELECT user_id FROM posts p2 WHERE id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'posts')
) 
GROUP BY `users`
ORDER BY birthday DESC
LIMIT 10;

-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT 
COUNT(*) `likes`,
(SELECT gender FROM profiles WHERE user_id = likes.user_id) gender 
FROM likes 
GROUP BY gender;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- (критерии активности необходимо определить самостоятельно).

/*Критерий отбора:
	1. Временной интервал (например шесть месяцев) - > NOW() - INTERVAL 6 MONTH
	2. posts <= 1
	3. media <=1
	4. likes <=1
*/

/*
В моем случае временной интервал на тестовых данных бесполезен, практически нет данных удовлетворяющих этим условиям.
Поэтому этот критерий в своем запросе я не использую. Но если использовать, то это условие нужно добавить к каждой таблице учавствующей 
в запросе. Например - (SELECT from_user_id FROM messages m WHERE id = likes.target_id AND created_at > NOW() - INTERVAL 6 MONTH)
По остальным критериям хорошо подходит запрос к заданию №3. Убираем из него столбец 'birthday', добавляем к условиям выборки владельцев
лайков, делаем прямую сортировку по столбцу 'likes' и оганичеваем вывод десятью строками.
*/

SELECT 
COUNT(*) `likes`,
target_id `users` 
FROM likes 
	WHERE target_id IN(
SELECT (SELECT from_user_id FROM messages m WHERE id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'messages')
UNION
SELECT (SELECT user_id FROM profiles p WHERE user_id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'users')
UNION
SELECT (SELECT user_id FROM media m2 WHERE id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'media')
UNION
SELECT (SELECT user_id FROM posts p2 WHERE id = likes.target_id) 
	FROM likes WHERE target_type_id = (
		SELECT id FROM target_types tt WHERE name = 'posts')
UNION 
SELECT user_id FROM likes
) 
GROUP BY `users`
ORDER BY `likes`
LIMIT 10; 
