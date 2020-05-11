-- Удаляем столбец created_at (метка создания файла) из таблицы profiles
ALTER TABLE profiles DROP COLUMN created_at;

-- Добавляем столбец photo_id в таблицу profiles (фото пользователя)
ALTER TABLE profiles ADD photo_id INT UNSIGNED AFTER user_id;

-- Создаем таблицу со статусами user_statuses
CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- Заполняем таблицу user_statuses
INSERT user_statuses
VALUES
  (1, 'active'),
  (2, 'blocked'),
  (3, 'deleted');
 
-- Добавляем столбец status_id в таблицу users (связываем таблицу users с таблицей user_statuses) 
ALTER TABLE users ADD status_id INT UNSIGNED NOT NULL DEFAULT 1 AFTER phone;

-- Добавляем столбец is_private в таблицу profiles (профиль пользователя открытый или закрытый)
ALTER TABLE profiles ADD is_private BOOLEAN DEFAULT FALSE AFTER country;

-- Анализируем данные пользователей (таблица users)
SELECT * FROM users LIMIT 10;

-- Обновляем ссылки на статус (столбец status_id) в таблице users
UPDATE users SET status_id = FLOOR(1 + RAND() * 3);

-- Обнавляем временные метки в таблице users
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;

-- Анализируем данные пользователей (таблица profiles)
SELECT * FROM profiles LIMIT 10;

-- Добавляем ссылки на фото пользователя
UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 150);

-- Обнавляем приватность
UPDATE profiles SET is_private = TRUE WHERE user_id > FLOOR(1 + RAND() * 150);

-- Анализ данных таблицы messages (таблица сообщений)
SELECT * FROM messages LIMIT 10;

-- Все нормально, править ничего не надо

-- Анализируем данные таблицы media (медиаконтент)
SELECT * FROM media LIMIT 10;

/* Необходимо изменить данные таблицы media_types, обновить столбец filename, столбец size (размер файла не может быть равен "0"), 
столбец metadata, столбец media_type_id, временные метки (столбцы created_at и updated_at)*/

-- Анализируем типы медиаконтента
SELECT * FROM media_types;

-- Удаляем все типы и обнуляем счетчик
TRUNCATE media_types;

-- Добавляем нужные типы
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');
 
 -- Обновляем данные для ссылки на тип
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

-- Меняем данные столбца filename

-- Создаём временную таблицу форматов медиафайлов
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- Заполняем значениями
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

-- Смотрим что получилось
SELECT * FROM extensions;

-- Обновляем ссылку на файл (столбец filename)
UPDATE media SET filename = CONCAT('https://dropbox/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- Обновляем размер файлов
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- Обновляем метаданные
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}'
  );  

-- Возвращаем столбцу метеданных правильный тип
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- Анализируем данные таблицы friendship (дружба)
SELECT * FROM friendship LIMIT 10;

-- Обнавляем временные метки в таблице friendship
UPDATE friendship SET confirmed_at = CURRENT_TIMESTAMP WHERE requested_at > confirmed_at;

-- Анализируем данные таблицы communities (сообщества)
SELECT * FROM communities;

-- Все нормально, править ничего не надо
