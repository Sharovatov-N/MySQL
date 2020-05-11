-- ������� ������� created_at (����� �������� �����) �� ������� profiles
ALTER TABLE profiles DROP COLUMN created_at;

-- ��������� ������� photo_id � ������� profiles (���� ������������)
ALTER TABLE profiles ADD photo_id INT UNSIGNED AFTER user_id;

-- ������� ������� �� ��������� user_statuses
CREATE TABLE user_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);

-- ��������� ������� user_statuses
INSERT user_statuses
VALUES
  (1, 'active'),
  (2, 'blocked'),
  (3, 'deleted');
 
-- ��������� ������� status_id � ������� users (��������� ������� users � �������� user_statuses) 
ALTER TABLE users ADD status_id INT UNSIGNED NOT NULL DEFAULT 1 AFTER phone;

-- ��������� ������� is_private � ������� profiles (������� ������������ �������� ��� ��������)
ALTER TABLE profiles ADD is_private BOOLEAN DEFAULT FALSE AFTER country;

-- ����������� ������ ������������� (������� users)
SELECT * FROM users LIMIT 10;

-- ��������� ������ �� ������ (������� status_id) � ������� users
UPDATE users SET status_id = FLOOR(1 + RAND() * 3);

-- ��������� ��������� ����� � ������� users
UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;

-- ����������� ������ ������������� (������� profiles)
SELECT * FROM profiles LIMIT 10;

-- ��������� ������ �� ���� ������������
UPDATE profiles SET photo_id = FLOOR(1 + RAND() * 150);

-- ��������� �����������
UPDATE profiles SET is_private = TRUE WHERE user_id > FLOOR(1 + RAND() * 150);

-- ������ ������ ������� messages (������� ���������)
SELECT * FROM messages LIMIT 10;

-- ��� ���������, ������� ������ �� ����

-- ����������� ������ ������� media (������������)
SELECT * FROM media LIMIT 10;

/* ���������� �������� ������ ������� media_types, �������� ������� filename, ������� size (������ ����� �� ����� ���� ����� "0"), 
������� metadata, ������� media_type_id, ��������� ����� (������� created_at � updated_at)*/

-- ����������� ���� �������������
SELECT * FROM media_types;

-- ������� ��� ���� � �������� �������
TRUNCATE media_types;

-- ��������� ������ ����
INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');
 
 -- ��������� ������ ��� ������ �� ���
UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

-- ������ ������ ������� filename

-- ������ ��������� ������� �������� �����������
CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

-- ��������� ����������
INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

-- ������� ��� ����������
SELECT * FROM extensions;

-- ��������� ������ �� ���� (������� filename)
UPDATE media SET filename = CONCAT('https://dropbox/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
);

-- ��������� ������ ������
UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

-- ��������� ����������
UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
  '"}'
  );  

-- ���������� ������� ���������� ���������� ���
ALTER TABLE media MODIFY COLUMN metadata JSON;

-- ����������� ������ ������� friendship (������)
SELECT * FROM friendship LIMIT 10;

-- ��������� ��������� ����� � ������� friendship
UPDATE friendship SET confirmed_at = CURRENT_TIMESTAMP WHERE requested_at > confirmed_at;

-- ����������� ������ ������� communities (����������)
SELECT * FROM communities;

-- ��� ���������, ������� ������ �� ����
