ALTER TABLE profile_readers 
	ADD CONSTRAINT profile_readers_readers_id_fk
	FOREIGN KEY (readers_id) REFERENCES readers(id)
		ON DELETE CASCADE;
	
ALTER TABLE profile_author 
	ADD CONSTRAINT profile_author_author_id_fk
	FOREIGN KEY (author_id) REFERENCES author(id)
		ON DELETE CASCADE;
			
ALTER TABLE books 
	ADD CONSTRAINT books_genre_id_fk
	FOREIGN KEY (genre_id) REFERENCES literary_genre(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT books_series_id_fk
	FOREIGN KEY (series_id) REFERENCES series(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT books_publishing_company_id_fk
	FOREIGN KEY (publishing_company_id) REFERENCES publishing_company(id)
		ON DELETE CASCADE;
			
ALTER TABLE authors_books 
	ADD CONSTRAINT authors_books_author_id_fk
	FOREIGN KEY (author_id) REFERENCES author(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT authors_books_book_id_fk
	FOREIGN KEY (book_id) REFERENCES books(id)
		ON DELETE CASCADE;
		
ALTER TABLE orders 
	ADD CONSTRAINT orders_reader_id_fk
	FOREIGN KEY (reader_id) REFERENCES readers(id)
		ON DELETE CASCADE;
		
		
ALTER TABLE orders_books 
	ADD CONSTRAINT orders_books_order_id_fk
	FOREIGN KEY (order_id) REFERENCES orders(number_order)
		ON DELETE CASCADE,
	ADD CONSTRAINT orders_books_book_id_fk
	FOREIGN KEY (book_id) REFERENCES books(id)
		ON DELETE CASCADE;