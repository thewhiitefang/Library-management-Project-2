Select * From books;
Select * From branch;
Select * From employees;
Select * From issued_status;
Select * From members;
Select * From return_status;




------------

-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2. Update an Existing Member's Address.


UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101'  ;


-- Task3. Delete the record with issued_id = 'IS121' from the issued_status table.

Delete From issued_status 
Where issued_id = 'IS121'

-- Task 4. Select all books issued by the employee with emp_id = 'E101'.

Select * From Issued_status
where Issued_emp_id = 'E101'

-- Task 5: : Use GROUP BY to find members who have issued more than one book.

Select issued_emp_id, Count (*) From issued_status Group By issued_emp_id HAVING Count(*) >1


----
-- Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

	CREATE TAble Book_counts AS 	(
	Select b.isbn,b.book_title, Count(ist.issued_id)  FROM Books as b
	JOIN	
	issued_status as ist 
	On ist.issued_book_isbn = b.isbn	
	Group By 1 , 2
	)
SELECT * From Book_counts


-- All books from specific category : Classic

SELECT * from Books 
Where Category = 'Classic'


-- Total Income By Category 

Select B.category ,  Sum(b.rental_price) As Total_rental_income, Count(*) 
FROM Books as b
	JOIN	
	issued_status as ist 
	On ist.issued_book_isbn = b.isbn
	Group By b.Category


	Select * FROM Books as b
	JOIN	
	issued_status as ist 
	On ist.issued_book_isbn = b.isbn


-- List Members Who Registered in the Last 180 Days:

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';


Insert Into members



-- List Employees with Their Branch Manager's Name and their branch details:

 SELECT 
 e1.*,
 b.manager_id,
 e2.emp_name as manager
 From Employees As E1
 Join 
 Branch as B 
 ON B.branch_id = E1.branch_id
 JOIN employees as e2
 ON b.manager_id = e2.emp_id


 --Task 11. Create a Table of Books with Rental Price Above a Certain Threshold above 10S :

 CREATE TABLE Exp_books As (
	Select * from Books	
	Where rental_price > 7
 );
 Select * from Exp_books

 -- Task 12: Retrieve the List of Books Not Yet Returned
	SELECT DISTINCT ist.issued_book_name
	From Issued_status as Ist
	Left Join return_status as rs
	On rs.issued_id = Ist.issued_id
	WHERE rs.return_id is NULL
 