/* 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы 
приложения и добавить необходимые индексы.*/
	
-- 	Нет опыта работы с базами и нет опыта анализа возможных запросов. Поэтому я по простому, по "рабоче-крестьянски", извените как могу.

CREATE INDEX profiles_user_id_city_idx ON profiles(user_id, city);
CREATE INDEX users_last_name_idx ON users(last_name);
CREATE INDEX messages_from_user_id_idx ON messages(from_user_id);
CREATE INDEX communities_name_idx ON communities(name);
CREATE INDEX posts_user_id_idx ON posts(user_id);
CREATE INDEX posts_head_idx ON posts(head);
CREATE INDEX media_filename_idx ON media(filename);
CREATE INDEX media_media_type_id_idx ON media(media_type_id);

/* 2. Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый старший пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100*/

SELECT DISTINCT communities.name,
	ROUND(MAX(profiles.user_id) OVER() / MAX(communities.id) OVER()) AS avg_communities_users,
	MAX(profiles.birthday) OVER w AS young_user,
	MIN(profiles.birthday) OVER w AS old_user,
	COUNT(communities_users.user_id) OVER w AS communities_users,
	MAX(profiles.user_id) OVER() AS total_user,
	COUNT(communities_users.user_id) OVER w / MAX(profiles.user_id) OVER() * 100 AS "%%"
	FROM communities
		JOIN communities_users 
	ON communities_users.community_id = communities.id
		JOIN profiles 
	ON communities_users.user_id = profiles.user_id
WINDOW w AS (PARTITION BY communities_users.community_id);
