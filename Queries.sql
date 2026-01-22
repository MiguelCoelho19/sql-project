USE LibraryDB;
GO

--1. Works, Editions, Authors (by role) - List each Work with its Editions (ISBN, year, language)
--and Authors grouped by role.

--Contribuitor can have a role in a work and/or in a edition
(select
w.title as 'Work Title', 
e.ISBN as 'Edition ISBN',
e.publishYear as 'Year of Publishing',
l.name as 'Language',
c.name as 'Contributor Name',
r.name as 'Role in Work',
null as 'Role in Edition'
from contributors as c
join contributorsWorks as cw on cw.contributorId = c.id
left join roles as r on cw.roleId = r.id
left join works as w on cw.workId = w.id
left join editions as e on w.id = e.workId
left join languages as l on e.languageId = l.id)
union
(select
w.title, e.ISBN, e.publishYear, l.name, c.name, null, r.name
from contributors as c
join contributorsEditions as ce on ce.contributorId = c.id
left join roles as r on ce.roleId = r.id
left join editions as e on ce.editionId = e.id
left join works as w on e.workId = w.id
left join languages as l on e.languageId = l.id)
order by e.ISBN, c.name;

--2. Branch Inventory - For each Branch, count Copies by Status.
select
b.name as 'Branch Name',
case
	when l.returnedDate is null then 'On Loan'
	else 'Returned'
end as 'Copies Status',
COUNT(c.id) as 'Amount of Copies'
from copies as c
join branches as b on c.branchId = b.id
left join loans as l on l.copyId = c.id
group by b.name, 
case
	when l.returnedDate is null then 'On Loan'
	else 'Returned'
end
order by b.name;

--3. Currently On Loan (with Member & Due Date) - Show Copy barcode, Edition (ISBN),
--Work title, Member name, Home branch, DueDate, and DaysOverdue (0 if not overdue).
select
c.barcode as 'Copy Barcode',
e.ISBN as 'Edition ISBN',
w.title as 'Work Title',
m.name as 'Member Name',
b.name as 'Home Branch',
l.dueDate as 'Due Date',
IIF(DATEDIFF(day, l.dueDate, GETDATE()) < 0,
	0,
	DATEDIFF(day, l.dueDate, GETDATE())) as 'Days Overdue'
from copies as c
join loans as l on l.copyId = c.id
left join editions as e on e.id = c.editionId
left join works as w on w.id = e.workId
left join reservations as r on l.id = r.id
left join members as m on r.memberId = m.id
left join branches as b on m.homeBranchId = b.id
where l.returnedDate is null;

--4. Overdue & Fines - For overdue loans, compute accrued overdue fine using the member's
--tier rate and days overdue, and compare to recorded Fine(s) for that Loan/Copy.

--Overdue fines aren't accounted for in fines table
--Last column represents the total of fines associated with that copy
select
c.barcode as 'Copy Barcode',
m.name as 'Member Name',
l.dueDate as 'Due Date',
mt.dailyFine as 'Daily Fine',
DATEDIFF(day, l.dueDate, GETDATE()) as 'Days Overdue',
DATEDIFF(day, l.dueDate, GETDATE())*mt.dailyFine as 'Overdue Fine',
cf.total as 'Sum of Fines of Copy Ever'
from loans as l
left join copies as c on l.copyId = c.id
left join reservations as r on l.id = r.id
left join members as m on r.memberId = m.id
left join membershipTier as mt on m.membershipTierId = mt.id
left join (
	select c.id, sum(isNUll(f.totalDue, 0) + DATEDIFF(day, l.dueDate, GETDATE())*mt.dailyFine) as total
	from copies as c
	join loans as l on l.copyId = c.id
	left join fines as f on f.loanId = l.id
	left join reservations as r on l.id = r.id
	left join members as m on r.memberId = m.id
	left join membershipTier as mt on m.membershipTierId = mt.id
	group by c.id
) as cf on cf.id = c.id
where DATEDIFF(day, l.dueDate, GETDATE()) > 0
order by c.barcode;

--5. Top Borrowers (Rolling 90 Days) - Find the top 5 members by number of loans in the last
--90 days, with a tie-breaker on the most recent return.

--Request Date was used for Loan Date
select top 5 
t.name as 'Member Name',
t.count as 'Loan Count',
RANK() over(order by t.count desc, t.lastLoan desc) as 'Rank'
from (
	select 
	m.name,
	COUNT(l.id) as count,
	max(l.returnedDate) as lastLoan
	from members as m
	join reservations as r on r.memberId = m.id 
	join loans as l on l.id = r.id
	where DATEDIFF(day, r.requestDate, GETDATE()) <= 90
	group by m.name
) as t;

--6. Loan Policy Compliance - List loans where the number of Renewals exceeded the
--MaxRenewals allowed by the member's tier at the time of loan.
select m.name as 'Member Name',
l.renewalCount as 'Renewal Count on Loan',
mt.maxRenewals as 'Max Renewals Allowed'
from loans as l
join reservations as r on r.id = l.id 
join members as m on r.memberId = m.id
join membershipTier as mt on m.membershipTierId = mt.id
where l.renewalCount > mt.maxRenewals;

--7. Reservation Waitlist Snapshot - For each Reservation in waiting, show the queue length,
--the member at position 1, and whether a copy is currently available at the pickup branch.

--When pickup branch is null that means that copy isn't available
select 
w.title as 'Work Title',
ql.oldestRequest as 'Oldest Request Date', 
ql.memberCount as 'Queue Size',
m.name as 'Member Name',
ISNULL(b.name, 'Not available') as 'Pickup Branch'
from reservations as r
join (
	select r.editionId, count(r.memberId) as memberCount, min(r.requestDate) as oldestRequest
	from reservations as r
	left join loans as l on l.id = r.id
	where l.id is null
	group by r.editionId
) as ql on r.editionId = ql.editionId
join members as m on r.memberId = m.id
left join editions as e on r.editionId = e.id
left join works as w on e.workId = w.id
left join branches as b on r.pickUpBranch = b.id
where r.requestDate = ql.oldestRequest;

--8. Multi-Role Contributors - List Authors who have contributed to 3+ Works and have served
--in 2+ distinct roles across those works.

--Contribuitor that work in at least 3 works and had at least 2 roles in a single work
select c.name as 'Contributor Name'
from contributors as c
join contributorsWorks as cw on cw.contributorId = c.id
where c.id in (
	select cw.contributorId
	from contributorsWorks as cw
	group by cw.contributorId, cw.workId
	having count(distinct cw.roleId) >=2
)
group by c.name
having count(distinct cw.workId) >= 3;


--9. Acquisitions Cost per Branch - For the last calendar year, show total PO value (sum of
--Quantity*UnitPrice) and received quantity per branch.
select
b.name as 'Branch Name',
sum(isnull(od.quantity*e.cost, 0)) as 'Total PO',
sum(CASE WHEN od.received is null THEN 0 ELSE 1 END) as 'Amount Bought',
sum(CASE WHEN od.received is null or od.received = 0 THEN 0 ELSE 1 END) as 'Amount Received'
from branches as b
left join(
	select *
	from orders as o
	where o.date >= DATEADD(year, -1, GETDATE())
) as o on o.branchId = b.id
left join orderDetails as od on od.orderId = o.id
left join editions as e on od.editionId = e.id
group by b.name;

--10. Genre Circulation Ranking - Rank Genres by the number of loans in the last 12 months,
--breaking ties by the most recently returned loan.

--Request Date was used for Loan Date
select  
t.name as 'Genre',
t.count as 'Loan Count',
RANK() over(order by t.count desc, t.lastLoan desc) as 'Rank'
from (
	select
	g.name,
	COUNT(distinct l.id) as count,
	max(l.returnedDate) as lastLoan
	from genres as g
	left join genresEditions as ge on ge.genreId = g.id
	left join editions as e on ge.editionId = e.id
	left join reservations as r on r.editionId = e.id
	join loans as l on r.id = l.id
	where r.requestDate >= DATEADD(MONTH, -12, GETDATE())
	group by g.name
) as t;

--11. Members with No Loans but With Reservations - List members who never borrowed any
--copy but have at least one active reservation.
select m.name as 'Member Name',
count(r.id) as 'Amount of Reservations',
count(l.id) as 'Amount of Loans'
from reservations as r
left join loans as l on l.id = r.id
left join members as m on r.memberId = m.id
group by m.name
having count(l.id) = 0 and count(r.id) > 0;

--12. Lost or Damaged Settlement - For loans marked lost/damaged, show assessed amount,
--payments to date, and outstanding balance, with a flag if paid in full.

--Other causes for fine also included except for Overdue
select co.barcode as 'Copy Barcode',
sum(f.totalDue) as 'Total Due',
isNull(sum(p.amount),0) as 'Total Payed',
case 
	when sum(f.totalDue) = sum(p.amount) then 'Paid in Full'
	else CAST(sum(f.totalDue) - isNull(sum(p.amount),0) AS VARCHAR(20))
end as 'To Pay'
from fines as f
join loans as l on f.loanId = l.id
join causes as c on f.causeId = c.id
left join payments as p on p.fineId = f.id
left join copies as co on co.id = l.copyId
group by co.barcode;

--13. Cross-Branch Fulfillment - For reservations fulfilled at a branch different from the
--member's home branch, list details.
select w.title as 'Work Title',
m.name as 'Member Name',
hb.name as 'Home Branch',
r.requestDate as 'Request Date',
pb.name as 'Pickup Branch'
from reservations as r
join members as m on r.memberId = m.id
join editions as e on e.id = r.editionId
join works as w on e.workId = w.id
join branches as hb on hb.id = m.homeBranchId
join branches as pb on pb.id = r.pickUpBranch
where m.homeBranchId <> r.pickUpBranch;