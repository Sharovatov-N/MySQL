-- 1. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.  

SELECT birthday, user_id, (
  SELECT COUNT(*) FROM likes WHERE 
    (target_id IN (SELECT id FROM media WHERE media.user_id=profiles.user_id) AND target_type_id=3) OR 
    (target_id IN (SELECT id FROM posts WHERE posts.user_id=profiles.user_id) AND target_type_id=4) OR 
    (target_id IN (SELECT id FROM messages WHERE messages.from_user_id=profiles.user_id) AND target_type_id=1) OR
    (target_id=profiles.user_id AND target_type_id=2)
  ) AS likes  FROM profiles 
 	ORDER BY birthday DESC 
 	LIMIT 10;
  
SELECT profiles.user_id AS user_id, COUNT(likes.target_id) AS likes
 	FROM likes
 		LEFT JOIN media 
 	ON likes.target_id = media.id
 		LEFT JOIN posts 
 	ON likes.target_id = posts.id
 		LEFT JOIN messages 
 	ON likes.target_id = messages.id 
 		RIGHT JOIN profiles 
 	ON (likes.target_id=profiles.user_id AND likes.target_type_id=2) 
 		OR (media.user_id=profiles.user_id AND target_type_id=3)
 			OR (posts.user_id=profiles.user_id AND target_type_id=4)
 				OR (messages.from_user_id=profiles.user_id AND target_type_id=1)
 	GROUP BY user_id 
 	ORDER BY profiles.birthday DESC 
 	LIMIT 10;

-- 2. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender,
	COUNT(*) AS total
    FROM likes
    GROUP BY gender
    ORDER BY total DESC
    LIMIT 1;  
    
SELECT p.gender, COUNT(l.user_id) AS total
	FROM likes l
		JOIN  profiles p
	ON l.user_id = p.user_id
	GROUP BY p.gender
	ORDER BY total DESC
  LIMIT 1;
	
-- 3. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
 
SELECT 
  CONCAT(first_name, ' ', last_name, ' - ', id) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	  ;
	  
SELECT CONCAT(users.first_name, ' ', users.last_name, ' - ', users.id) AS `user`, 
(COUNT(likes.user_id) + COUNT(media.user_id) + COUNT(messages.from_user_id)) AS overall_activity
	FROM users
		LEFT JOIN likes
	ON likes.user_id = users.id
		LEFT JOIN media 
	ON media.user_id = users.id
		LEFT JOIN messages 
	ON messages.from_user_id = users.id
	GROUP BY `user`
	ORDER BY overall_activity
	LIMIT 10;

