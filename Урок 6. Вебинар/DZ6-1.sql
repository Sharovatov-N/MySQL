-- Исправляем столбец 'status_id' в таблице 'users'.

ALTER TABLE users MODIFY COLUMN status_id INT UNSIGNED;

-- Связываем таблицу 'users' с таблицей 'user_statuses' внешним ключем.

ALTER TABLE users 
	ADD CONSTRAINT users_status_id_fk
	FOREIGN KEY (status_id) REFERENCES user_statuses(id)
		ON DELETE SET NULL;

-- Связываем таблицу 'profiles' с таблицей 'users' и таблицей 'media' внешними ключами.

ALTER TABLE profiles 
	ADD CONSTRAINT profiles_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT profiles_photo_id_fk
	FOREIGN KEY (photo_id) REFERENCES media(id)
		ON DELETE CASCADE;
	
-- Связываем таблицу 'media' с таблицей 'users' и таблицей 'media_types' внешними ключами.

ALTER TABLE media 
	ADD CONSTRAINT media_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE, 
	ADD CONSTRAINT media_media_type_id_fk
	FOREIGN KEY (media_type_id) REFERENCES media_types(id)
		ON DELETE SET NULL;
	
-- Связываем таблицу 'communities_users' с таблицей 'users' и таблицей 'communities' внешними ключами.

ALTER TABLE communities_users 
	ADD CONSTRAINT communities_users_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT communities_users_community_id_fk
	FOREIGN KEY (community_id) REFERENCES communities(id);

-- Связываем таблицу 'friendship' с таблицей 'users' и таблицей 'friendship_statuses' внешними ключами.

ALTER TABLE friendship 
	ADD CONSTRAINT friendship_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT friendship_friend_id_fk
	FOREIGN KEY (friend_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT friendship_status_id_fk
	FOREIGN KEY (status_id) REFERENCES friendship_statuses(id)
		ON DELETE SET NULL;
	
-- Связываем таблицу 'messages' с таблицей 'users' внешним ключем.
	
ALTER TABLE messages 
	ADD CONSTRAINT messages_from_user_id_fk
	FOREIGN KEY (from_user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT messages_to_user_id_fk
	FOREIGN KEY (to_user_id) REFERENCES users(id)
		ON DELETE CASCADE;

-- Связываем таблицу 'likes' с таблицей 'users', таблицей 'posts' и таблицей 'target_types' внешними ключами.
	
ALTER TABLE likes 
	ADD CONSTRAINT likes_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT likes_target_id_fk
	FOREIGN KEY (target_id) REFERENCES posts(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT likes_target_type_id_fk
	FOREIGN KEY (target_type_id) REFERENCES target_types(id)
		ON DELETE SET NULL;
		
-- Связываем таблицу 'posts' с таблицей 'users', таблицей 'communities' и таблицей 'media' внешними ключами.
	
ALTER TABLE posts 
	ADD CONSTRAINT posts_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT posts_community_id_fk
	FOREIGN KEY (community_id) REFERENCES communities(id)
		ON DELETE SET NULL,
	ADD CONSTRAINT posts_media_id_fk
	FOREIGN KEY (media_id) REFERENCES media(id)
		ON DELETE SET NULL;