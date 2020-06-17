

Современное общество всё чаще называют «информационным». Это связано с тем, что сегодня в любой среде человеческой деятельности одной из главных задач является 
организация хранения и обработки большого количества информации. В этом существенную помощь могут оказать компьютерные системы обработки данных. Основная цель 
подобных систем – повышение эффективности работы отдельной фирмы, предприятия или организации.
Многие существующие экономические, информационно-справочные, банковские программные комплексы реализованы с использованием инструментальных стредств систем 
управления базами данных. Системы управления базами данных предназначены для автоматизации процедур создания, хранения, извлечения, обработки и анализа 
электронных данных.

Целью мой работы стала автоматизация функций электронной библиотеки:
·     учет, хранение, поиск литературы;
·     оформление заказа читателя;



DROP DATABASE IF EXISTS lit_res;
CREATE DATABASE lit_res;

USE lit_res;

DROP TABLE IF EXISTS readers;
CREATE TABLE readers (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 

DROP TABLE IF EXISTS profile_readers;
CREATE TABLE profile_readers (
	readers_id INT UNSIGNED NOT NULL PRIMARY KEY, 
	gender CHAR(1) NOT NULL,
	birthday DATE,
	country VARCHAR(100),
	city VARCHAR(100),
	hobbies VARCHAR(256),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS author;
CREATE TABLE author (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	phone VARCHAR(10) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
); 

DROP TABLE IF EXISTS profile_author;
CREATE TABLE profile_author (
	author_id INT UNSIGNED NOT NULL PRIMARY KEY, 
	gender CHAR(1) NOT NULL,
	birthday DATE,
	role_author VARCHAR(256),
	house_number VARCHAR(10),
	street VARCHAR(100),
	city VARCHAR(100),
	country VARCHAR(100),
	about_the_author TEXT,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS publishing_company;
CREATE TABLE publishing_company (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_company VARCHAR(100) NOT NULL,
	email VARCHAR(50),
	phone VARCHAR(10),
	house_number VARCHAR(10),
	street VARCHAR(100),
	city VARCHAR(100),
	country VARCHAR(100),
	contact_person VARCHAR(100),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS literary_genre;
CREATE TABLE literary_genre (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_genre VARCHAR(100) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS books;
CREATE TABLE books (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_book VARCHAR(100),
	genre_id INT UNSIGNED,
	series_id INT UNSIGNED,
	publishing_company_id INT UNSIGNED DEFAULT 1,
	publication_date DATE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS authors_books;
CREATE TABLE authors_books (
	author_id INT UNSIGNED NOT NULL,
	book_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	number_order INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	reader_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS orders_books;
CREATE TABLE orders_books (
	order_id INT UNSIGNED NOT NULL,
	book_id INT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS series;
CREATE TABLE series (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_series VARCHAR(100),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);