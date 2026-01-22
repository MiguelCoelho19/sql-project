-- Made by Google Gemini
-- Use the database created by the schema
USE LibraryDB;
GO

--------------------------------------------------------------------------------
-- 1. Static/Lookup Tables (Order matters for Foreign Keys)
--------------------------------------------------------------------------------

-- Branches (3 branches minimum)
INSERT INTO branches (name) VALUES
('Central Library'), ('North Branch'), ('South Branch'), ('West Branch');

-- Languages
INSERT INTO languages (name) VALUES
('English'), ('Spanish'), ('French'), ('German');

-- Genres
INSERT INTO genres (name) VALUES
('Science Fiction'), ('Fantasy'), ('Thriller'), ('Romance'), ('Non-Fiction'),
('Historical Fiction'), ('Mystery'), ('Biography'), ('Young Adult');

-- Tags
INSERT INTO tags (name) VALUES
('Dystopian'), ('Magic'), ('Serial Killer'), ('Love Triangle'), ('Self-Help'),
('World War II'), ('Detective'), ('Memoir');

-- Formats
INSERT INTO formats (name) VALUES
('Hardcover'), ('Paperback'), ('Ebook'), ('Audiobook');

-- Publishers
INSERT INTO publishers (name) VALUES
('Epic Books Inc.'), ('Global Press'), ('Scholastic Tales'), ('The Science House');

-- AgeRatings
INSERT INTO ageRatings (rating) VALUES
('G - General'), ('PG - Parental Guidance'), ('R - Restricted');

-- Roles
INSERT INTO roles (name) VALUES
('Author'), ('Translator'), ('Editor'), ('Illustrator'), ('Narrator');

-- MembershipTier
INSERT INTO membershipTier (name, dailyFine, maxLoans, maxRenewals, maxLoanLenght) VALUES
('Standard', 0.50, 5, 2, 14), ('Premium', 0.25, 10, 5, 21);

-- Causes
INSERT INTO causes (name) VALUES
('Policy Violation'), ('Lost'), ('Damaged');

-- Suppliers
INSERT INTO suppliers (name) VALUES
('Acme Book Wholesalers'), ('Global Distributor Group');

--------------------------------------------------------------------------------
-- 2. Works and Editions
--------------------------------------------------------------------------------

-- Works (21 works)
INSERT INTO works (title) VALUES
('The Obsidian Star'), ('A Whisper in the Wind'), ('Zen and the Art of Coding'),
('The Lost City of Eldoria'), ('Beneath a Scarlet Sky'), ('The French Connection'),
('The Art of Not Giving Up'), ('Echoes of the Past'), ('Midnight Express'),
('Symphony of Chaos'), ('How to Master SQL'), ('The Silent Witness'),
('A Brief History of Time'), ('Galactic Empires Vol. 1'), ('The Alchemist'),
('The Ultimate Cookbook'), ('The Martian Chronicles'), ('Code Red: A Cyber Thriller'),
('Lessons in Chemistry'), ('The Giver'), ('Harry Potter and the Sorcerer''s Stone');

-- Contributors (17 contributors)
INSERT INTO contributors (name) VALUES
('A. B. Johnson'), ('C. D. Miller'), ('E. F. Williams'), ('G. H. Brown'), ('I. J. Davis'),
('K. L. Smith'), ('M. N. Wilson'), ('O. P. Taylor'), ('Q. R. Jones'), ('S. T. Hall'),
('U. V. Clark'), ('W. X. King'), ('Y. Z. Baker'), ('Z. A. Scott'), ('B. C. Adams'),
('D. E. Chen'), ('F. G. Garcia');

-- Editions (26 editions)
INSERT INTO editions (workId, languageId, formatId, ageRatingId, publisherId, cost, ISBN, publishYear) VALUES
(1, 1, 1, 2, 1, 25.99, '978-0134446580', '2018-05-15'), (1, 2, 2, 2, 1, 15.99, '978-0134446581', '2019-01-20'),
(2, 1, 2, 1, 2, 12.50, '978-0134446582', '2021-03-01'), (3, 1, 3, 1, 4, 9.99, '978-0134446583', '2020-07-01'),
(4, 1, 1, 2, 3, 29.99, '978-0134446584', '2017-11-01'), (4, 3, 2, 2, 3, 18.99, '978-0134446585', '2019-06-10'),
(5, 1, 1, 2, 2, 22.00, '978-0134446586', '2022-09-01'), (6, 1, 2, 3, 1, 10.99, '978-0134446587', '2005-04-15'),
(7, 1, 4, 1, 4, 19.99, '978-0134446588', '2023-01-01'), (8, 1, 1, 2, 2, 27.50, '978-0134446589', '2016-02-29'),
(8, 4, 2, 2, 2, 17.50, '978-0134446590', '2018-09-01'), (9, 1, 2, 3, 3, 11.50, '978-0134446591', '2010-10-10'),
(10, 1, 1, 2, 1, 24.99, '978-0134446592', '2024-02-01'), (11, 1, 3, 1, 4, 14.99, '978-0134446593', '2020-05-01'),
(12, 1, 2, 2, 3, 13.00, '978-0134446594', '2021-11-20'), (13, 1, 1, 1, 4, 30.00, '978-0134446595', '1988-04-01'),
(14, 1, 2, 2, 1, 16.99, '978-0134446596', '2015-08-01'), (15, 2, 2, 1, 2, 14.00, '978-0134446597', '1993-01-01'),
(15, 1, 2, 1, 2, 14.00, '978-0134446598', '1995-01-01'), (16, 1, 1, 1, 4, 35.00, '978-0134446599', '2022-04-01'),
(17, 1, 2, 2, 3, 12.00, '978-0134446600', '1950-01-01'), (18, 1, 1, 3, 1, 26.50, '978-0134446601', '2023-10-15'),
(19, 1, 2, 2, 2, 13.50, '978-0134446602', '2023-03-01'), (20, 1, 2, 1, 3, 11.00, '978-0134446603', '1993-04-26'),
(21, 1, 1, 1, 3, 20.00, '978-0134446604', '1997-06-26'), (21, 1, 2, 1, 3, 15.00, '978-0134446605', '1999-09-01');

-- ContributorsWorks and contributorsEditions
INSERT INTO contributorsWorks (roleId, workId, contributorId) VALUES
(1, 1, 1), (1, 2, 2), (1, 3, 3), (1, 4, 4), (1, 5, 5), (1, 6, 6), (1, 7, 7),
(1, 8, 8), (1, 9, 9), (1, 10, 10), (1, 11, 11), (1, 12, 12), (1, 13, 13),
(1, 14, 14), (1, 15, 15), (3, 1, 17), (1, 16, 1), (1, 17, 12),
(1, 18, 9), (1, 19, 5), (1, 20, 10), (1, 21, 17), (3, 10, 17);

INSERT INTO contributorsEditions (roleId, editionId, contributorId) VALUES
(2, 2, 16), (3, 6, 17), (2, 11, 8);

-- GenresEditions and TagsEditions
INSERT INTO genresEditions (genreId, editionId) VALUES
(2, 1), (1, 1), (1, 2), (2, 2), (4, 3), (5, 4), (2, 5), (2, 6), (6, 7), (3, 8), (5, 9), (7, 10),
(7, 11), (3, 12), (1, 13), (5, 14), (7, 15), (8, 16), (1, 17), (5, 18), (5, 19),
(5, 20), (1, 21), (3, 22), (9, 23), (9, 24), (2, 25), (2, 26), (9, 25), (9, 26);
INSERT INTO tagsEditions (tagId, editionId) VALUES
(1, 1), (2, 5), (7, 10), (3, 12), (5, 7), (2, 25), (2, 26), (1, 2), (2, 6), (7, 11);

--------------------------------------------------------------------------------
-- 3. Inventory and Circulation Data
--------------------------------------------------------------------------------

-- Copies (67 copies)
INSERT INTO copies (editionId, branchId, barcode) VALUES
(1, 1, 100001), (1, 1, 100002), (1, 1, 100003), (1, 1, 100004), (1, 2, 100005),
(1, 2, 100006), (3, 1, 100007), (3, 1, 100008), (3, 1, 100009), (3, 1, 100010),
(3, 1, 100011), (3, 3, 100012), (3, 3, 100013), (3, 3, 100014), (5, 1, 100015),
(5, 1, 100016), (5, 1, 100017), (5, 2, 100018), (5, 2, 100019), (5, 4, 100020),
(7, 2, 100021), (7, 2, 100022), (7, 2, 100023), (7, 2, 100024), (7, 2, 100025),
(7, 2, 100026), (7, 3, 100027), (7, 3, 100028), (7, 3, 100029), (7, 3, 100030),
(13, 1, 100031), (13, 1, 100032), (13, 2, 100033), (13, 2, 100034), (13, 3, 100035),
(13, 3, 100036), (13, 4, 100037), (13, 4, 100038), (19, 1, 100039), (19, 1, 100040),
(19, 1, 100041), (19, 1, 100042), (19, 1, 100043), (19, 1, 100044), (19, 1, 100045),
(19, 2, 100046), (19, 2, 100047), (19, 2, 100048), (19, 3, 100049), (19, 3, 100050),
(25, 1, 100051), (25, 1, 100052), (25, 1, 100053), (25, 1, 100054), (25, 1, 100055),
(25, 2, 100056), (25, 2, 100057), (25, 2, 100058), (25, 4, 100059), (25, 4, 100060),
(26, 1, 100061), (26, 1, 100062), (26, 1, 100063), (26, 3, 100064), (26, 3, 100065),
(26, 4, 100066), (26, 4, 100067);

-- Staff
INSERT INTO staff (branchId, name) VALUES
(1, 'Manager A'), (2, 'Librarian B'), (3, 'Assistant C');

-- Members (26 members)
INSERT INTO members (homeBranchId, name, address, membershipTierId) VALUES
(1, 'Alice Johnson', '123 Central St', 2), (1, 'Bob Williams', '456 Central Ave', 2),
(2, 'Charlie Davis', '789 North Blvd', 1), (3, 'Diana Miller', '101 South Ln', 1),
(4, 'Eve Taylor', '202 West Rd', 2), (1, 'Frank Brown', '303 Central Pkwy', 1),
(2, 'Grace Wilson', '404 North Dr', 1), (3, 'Henry Moore', '505 South Ct', 2),
(4, 'Ivy Hall', '606 West Loop', 1), (1, 'Jack King', '707 Central Terr', 2),
(2, 'Kelly Wright', '808 North Cir', 1), (3, 'Leo Scott', '909 South Way', 2),
(1, 'Mia Green', '111 Central Place', 1), (2, 'Noah Adams', '222 North Gate', 2),
(3, 'Olivia Baker', '333 South Bend', 1), (4, 'Peter Clark', '444 West Fork', 2),
(1, 'Quinn Evans', '555 Central Hill', 1), (2, 'Ryan Young', '666 North Peak', 2),
(3, 'Sara Rodriguez', '777 South Point', 1), (4, 'Tom White', '888 West Bay', 2),
(1, 'Uma Lee', '999 Central Mews', 1), (2, 'Victor Harris', '112 North St', 2),
(3, 'Wendy Martin', '223 South Ave', 1), (4, 'Xavier Perez', '334 West Ln', 2),
(1, 'Yara Lopez', '445 Central Dr', 1), (2, 'Zane Foster', '556 North Pkwy', 2);

-- Reservations (40 fulfilled reservations for loans + 15 active/waiting = 55 total)
-- IDs 1 through 40 are fulfilled loans
DECLARE @LoanReservationCounter INT = 1;
WHILE @LoanReservationCounter <= 40
BEGIN
    DECLARE @MemIdLoan INT = (@LoanReservationCounter % 15) + 1;
    DECLARE @EdIdLoan INT = (@LoanReservationCounter % 26) + 1;
    DECLARE @BranchIdLoan INT = (@LoanReservationCounter % 4) + 1;

    INSERT INTO reservations (editionId, requestDate, pickUpBranch, memberId)
    VALUES (@EdIdLoan, DATEADD(DAY, -45, '2025-11-24'), @BranchIdLoan, @MemIdLoan);
    
    SET @LoanReservationCounter = @LoanReservationCounter + 1;
END

-- Active Reservations (IDs 41 through 55 - total 15 active reservations)
-- R41-43: Queue for Edition 1 (Obsidian Star) - Copy available at Central (1)
INSERT INTO reservations (editionId, requestDate, pickUpBranch, memberId) VALUES
(1, '2025-11-20', 1, 6), -- Position 1 (ID 41)
(1, '2025-11-21', 1, 7), -- Position 2 (ID 42)
(1, '2025-11-22', 1, 9); -- Position 3 (ID 43)
-- R44-46: Queue for Edition 25 (HP HC) - No copies available at North (2) due to loans
INSERT INTO reservations (editionId, requestDate, pickUpBranch, memberId) VALUES
(25, '2025-11-15', 2, 14), -- ID 44
(25, '2025-11-16', 2, 18), -- ID 45
(25, '2025-11-17', 2, 22); -- ID 46
-- R47: Cross-Branch Fulfillment (Query 13)
INSERT INTO reservations (editionId, requestDate, pickUpBranch, memberId) VALUES
(3, '2025-11-20', 2, 8); -- Henry (Home 3) reserving for pickup at North (2) (ID 47)
-- R48: Member with no loans but reservation (Query 11)
INSERT INTO reservations (editionId, requestDate, pickUpBranch, memberId) VALUES
(5, '2025-11-24', 4, 5); -- Eve Taylor (No loans, has reservation) (ID 48)
-- R49-55: Remaining reservations for the count
INSERT INTO reservations (editionId, requestDate, pickUpBranch, memberId) VALUES
(13, '2025-11-20', 1, 10), (13, '2025-11-21', 1, 11), (19, '2025-11-20', 1, 12),
(19, '2025-11-21', 3, 13), (26, '2025-11-22', 3, 15), (26, '2025-11-23', 4, 16),
(10, '2025-11-24', 4, 17); -- IDs 49 to 55


-- Loans (40 loans - IDs 1 through 40 must match the Reservation IDs for the FK)
-- Note: 'id' for loans table is NOT IDENTITY, it is a PRIMARY KEY AND an FK to reservations.
-- We can still use the generated Reservation IDs by querying the max ID and subtracting.
-- We will use the reservation IDs for the loan IDs.

DECLARE @MaxResId INT;
SELECT @MaxResId = MAX(id) FROM reservations;
DECLARE @StartLoanId INT = @MaxResId - 55 + 1; -- The first 40 reservations (IDs 1 to 40)

-- We use specific IDs from the original script to match the scenario logic (1-5)
DECLARE @CopiesUsed TABLE (CopyId INT);
INSERT INTO @CopiesUsed VALUES (21), (35), (7), (1), (15);

-- Loan 1 (ID @StartLoanId - Current Loan, Not Overdue, Premium, Copy 21, Due 21 days)
INSERT INTO loans (id, copyId, renewalCount, pickUpDate, dueDate, returnedDate) VALUES
(@StartLoanId, 21, 0, '2025-11-15', '2025-12-06', NULL); 

-- Loan 2 (ID @StartLoanId + 1 - Current Loan, Overdue, Premium, Copy 35, Due 21 days) - Fine Case
INSERT INTO loans (id, copyId, renewalCount, pickUpDate, dueDate, returnedDate) VALUES
(@StartLoanId + 1, 35, 0, '2025-10-20', '2025-11-10', NULL); -- Overdue by 14 days

-- Loan 3 (ID @StartLoanId + 2 - Current Loan, Very Overdue, Standard, Copy 7, Due 14 days) - Fine Case
INSERT INTO loans (id, copyId, renewalCount, pickUpDate, dueDate, returnedDate) VALUES
(@StartLoanId + 2, 7, 0, '2025-10-01', '2025-10-15', NULL); -- Overdue by 40 days

-- Loan 4 (ID @StartLoanId + 3 - Returned, Exceeded Renewals - Query 6)
INSERT INTO loans (id, copyId, renewalCount, pickUpDate, dueDate, returnedDate) VALUES
(@StartLoanId + 3, 1, 10, '2025-08-01', '2025-09-12', '2025-09-14'); -- Member 6 (Standard: max 2 renewals) - Exceeded

-- Loan 5 (ID @StartLoanId + 4 - Lost/Damaged - Fine Case)
INSERT INTO loans (id, copyId, renewalCount, pickUpDate, dueDate, returnedDate) VALUES
(@StartLoanId + 4, 15, 0, '2025-07-01', '2025-07-15', NULL); -- Member 4 (Standard) - Lost/Damaged

-- Loans 6-40 (Past Loans to meet 40 count, 15 renewals, and top borrower)
DECLARE @LoanId INT = @StartLoanId + 5;
DECLARE @RenewalsCount INT = 0;
WHILE @LoanId <= @StartLoanId + 39 -- Loop runs from 6 to 40 (35 iterations)
BEGIN
    DECLARE @MemId_Loop INT = ((@LoanId - @StartLoanId + 5) % 15) + 1; -- Logic to cycle through members (starting at ID 6/Member 6)
    DECLARE @CopyId_Loop INT;
    
    SELECT TOP 1 @CopyId_Loop = c.id FROM copies c WHERE c.id NOT IN (SELECT CopyId FROM @CopiesUsed) ORDER BY NEWID();
    INSERT INTO @CopiesUsed VALUES (@CopyId_Loop);

    DECLARE @Pickup DATE;
    DECLARE @Returned DATE;
    DECLARE @Renewals INT;
    DECLARE @LoanLen INT = 14; -- Default 14 days for simplicity

    -- Top Borrower: Member 1 & 2 in the last 90 days
    IF @MemId_Loop IN (1, 2) AND @LoanId <= @StartLoanId + 14 -- First 15 loans of the loop (ID 6 to 20)
    BEGIN
        SET @Pickup = DATEADD(DAY, -((@LoanId - (@StartLoanId + 5)) * 3), '2025-11-20'); -- Recent loans
        SET @Returned = DATEADD(DAY, @LoanLen, @Pickup);
        SET @Renewals = 0;
    END
    ELSE
    BEGIN
        SET @Pickup = DATEADD(DAY, -((@LoanId - (@StartLoanId + 5)) * 7), '2025-09-01');
        SET @Renewals = (@RenewalsCount % 3);
        SET @Returned = DATEADD(DAY, @LoanLen + (@Renewals * 14), @Pickup); -- Returned after renewals
        SET @RenewalsCount = @RenewalsCount + 1;
    END
    
    INSERT INTO loans (id, copyId, renewalCount, pickUpDate, dueDate, returnedDate)
    VALUES (@LoanId, @CopyId_Loop, @Renewals, @Pickup, DATEADD(DAY, @LoanLen + (@Renewals * 14), @Pickup), @Returned);

    SET @LoanId = @LoanId + 1;
END

-- Fines (12 fines)
-- Fine 1 (Loan 3 - Policy Violation, $20)
INSERT INTO fines (causeId, totalDue, loanId) VALUES
(1, 20.00, @StartLoanId + 2); -- Loan 3
-- Fine 2 (Loan 5 - Lost, $29.99 cost of edition 5)
INSERT INTO fines (causeId, totalDue, loanId) VALUES
(2, 29.99, @StartLoanId + 4); -- Loan 5
-- Fine 3 (Loan 2 - Policy Violation, $3.50)
INSERT INTO fines (causeId, totalDue, loanId) VALUES
(1, 3.50, @StartLoanId + 1); -- Loan 2
-- Fine 4-12
INSERT INTO fines (causeId, totalDue, loanId) VALUES
(1, 1.00, @StartLoanId + 5), (3, 5.00, @StartLoanId + 6), (1, 0.50, @StartLoanId + 7), (1, 1.00, @StartLoanId + 8), (2, 12.50, @StartLoanId + 9),
(3, 5.00, @StartLoanId + 10), (1, 1.50, @StartLoanId + 11), (1, 0.75, @StartLoanId + 12), (1, 2.00, @StartLoanId + 13);
-- The original script used IDs 6-14, which correspond to Loans @StartLoanId + 5 through @StartLoanId + 13

-- Payments (Partial payments in some cases)
-- We assume Fine IDs 1 to 12 were generated in order
DECLARE @Fine1 INT = 1;
DECLARE @Fine2 INT = 2;
DECLARE @Fine4 INT = 4;
DECLARE @Fine5 INT = 5;


INSERT INTO payments (fineId, amount, transferDate) VALUES
(@Fine2, 10.00, '2025-09-01'), -- Partial on Lost (Fine 2)
(@Fine4, 1.00, '2025-10-01'), -- Full (Fine 4)
(@Fine5, 2.00, '2025-10-15'), -- Partial on Damaged (Fine 5)
(@Fine1, 5.00, '2025-11-01'), -- Partial on Policy Violation (Fine 1)
(@Fine1, 1.00, '2025-11-01'); -- Another Partial on Policy Violation (Fine 1)

--------------------------------------------------------------------------------
-- 4. Acquisition Data
--------------------------------------------------------------------------------

-- Orders (3 POs minimum)
INSERT INTO orders (supplierId, branchId, date) VALUES
(1, 1, '2025-10-05'), -- ID 1
(2, 2, '2024-03-01'), -- ID 2
(1, 3, '2024-11-15'); -- ID 3

-- OrderDetails (and receiving records)
INSERT INTO orderDetails (orderId, editionId, quantity, received) VALUES
(1, 13, 10, 1), -- Received 10 copies of Edition 13 (Branch 1, Order 1)
(1, 22, 5, 0),  -- Not yet received 5 copies of Edition 22 (Branch 1, Order 1)
(2, 1, 20, 1),  -- Received 20 copies (Branch 2, Order 2)
(2, 3, 10, 1),  -- Received 10 copies (Branch 2, Order 2)
(3, 7, 15, 1);  -- Received 15 copies (Branch 3, Order 3)

--------------------------------------------------------------------------------
-- 5. Checking for right amount of inserts
--------------------------------------------------------------------------------

-- At least 20 works spanning different genres and languages.
select count(*) as 'Amount of Works'
from works;

select
w.title, e.ISBN, g.name as 'genre'
from works as w
left join editions as e on e.workId=w.id
left join genresEditions as ge on e.id = ge.editionId
left join genres as g on g.id = ge.genreId;

select
w.title, e.ISBN, l.name as 'language'
from works as w
left join editions as e on e.workId=w.id
left join languages as l on e.languageId = l.id;

-- At least 25 editions (ISBNs across languages/publishers).
select count(e.ISBN) as 'Amount of Editions',
l.name as 'language'
from editions as e
left join languages as l on e.languageId = l.id
group by l.name;

select count(e.ISBN) as 'Amount of Editions',
p.name as 'publisher'
from editions as e
left join publishers as p on e.publisherId = p.id
group by p.name;

--At least 60 copies distributed across 3+ branches.
select branchId, COUNT(*) as 'Amount of Copies' 
from copies group by branchId;

--At least 15 authors with different roles (author/translator/editor).
select r.name as 'role', COUNT(c.id) as 'Amount of Contributors' 
from contributors as c
join contributorsEditions as ce on ce.contributorId = c.id
join roles as r on ce.roleId = r.id
group by r.name;

select r.name  as 'role', COUNT(c.id) as 'Amount of Contributors' 
from contributors as c
join contributorsWorks as cw on cw.contributorId = c.id
join roles as r on cw.roleId = r.id
group by r.name;

--At least 25 members with 2 membership tiers (e.g., Standard, Premium).
select mt.name, COUNT(m.id) as 'Amount of Members' 
from members as m
join membershipTier as mt on m.membershipTierId = mt.id
group by mt.name;

--At least 40 loans, 15 renewals, 15 reservations with queue positions.
select COUNT(l.id) as 'Amount of Loans'
from loans as l;

select sum(l.renewalCount) as 'Amount as Renewal'
from loans as l;

select COUNT(r.id) as 'Amount of Reservations in waiting'
from reservations as r
where r.id not in (
select l.id from loans as l
);

--At least 12 fines (mix of overdue/lost/damaged) with partial payments in some cases.
select f.id, f.totalDue, p.amount, c.name
from fines as f
left join payments as p on p.fineId = f.id
left join causes as c on f.causeId = c.id;

--At least 2 suppliers, 3 POs, and receiving records.
select *
from suppliers;

select *
from orders;

select Count(*) as 'Amount of Order Items', received
from orderDetails
group by received;
