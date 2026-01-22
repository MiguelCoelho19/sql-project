CREATE DATABASE LibraryDB;
GO
USE LibraryDB;
GO

CREATE TABLE [branches] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [works] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [title] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [languages] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [genres] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [tags] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [formats] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [publishers] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [editions] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [workId] int NOT NULL,
  [languageId] int NOT NULL,
  [formatId] int NOT NULL,
  [ageRatingId] int NOT NULL,
  [publisherId] int NOT NULL,
  [cost] money,
  [ISBN] nvarchar(255) UNIQUE NOT NULL,
  [publishYear] date NOT NULL
)
GO

CREATE TABLE [tagsEditions] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [tagId] int NOT NULL,
  [editionId] int NOT NULL
)
GO

CREATE TABLE [genresEditions] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [genreId] int NOT NULL,
  [editionId] int NOT NULL
)
GO

CREATE TABLE [copies] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [editionId] int NOT NULL,
  [branchId] int NOT NULL,
  [barcode] int UNIQUE NOT NULL
)
GO

CREATE TABLE [orders] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [supplierId] int NOT NULL,
  [branchId] int NOT NULL,
  [date] date NOT NULL
)
GO

CREATE TABLE [orderDetails] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [orderId] int NOT NULL,
  [editionId] int NOT NULL,
  [quantity] int NOT NULL,
  [received] bit NOT NULL
)
GO

CREATE TABLE [roles] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [contributors] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [membershipTier] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL,
  [dailyFine] money NOT NULL,
  [maxLoans] int NOT NULL,
  [maxRenewals] int NOT NULL,
  [maxLoanLenght] int NOT NULL
)
GO

CREATE TABLE [staff] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [branchId] int NOT NULL,
  [name] nvarchar(255) NOT NULL
)
GO

CREATE TABLE [members] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [homeBranchId] int NOT NULL,
  [name] nvarchar(255) NOT NULL,
  [address] nvarchar(255) NOT NULL,
  [membershipTierId] int NOT NULL
)
GO

CREATE TABLE [ageRatings] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [rating] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [contributorsWorks] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [roleId] int NOT NULL,
  [workId] int NOT NULL,
  [contributorId] int NOT NULL
)
GO

CREATE TABLE [contributorsEditions] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [editionId] int NOT NULL,
  [roleId] int NOT NULL,
  [contributorId] int NOT NULL
)
GO

CREATE TABLE [reservations] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [editionId] int NOT NULL,
  [requestDate] date NOT NULL,
  [pickUpBranch] int,
  [memberId] int NOT NULL
)
GO

CREATE TABLE [loans] (
  [id] int PRIMARY KEY,
  [copyId] int NOT NULL,
  [renewalCount] int,
  [pickUpDate] date NOT NULL,
  [dueDate] date NOT NULL,
  [returnedDate] date
)
GO

CREATE TABLE [causes] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) UNIQUE NOT NULL
)
GO

CREATE TABLE [fines] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [causeId] int NOT NULL,
  [totalDue] money NOT NULL,
  [loanId] int NOT NULL
)
GO

CREATE TABLE [payments] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [fineId] int NOT NULL,
  [amount] money NOT NULL,
  [transferDate] date NOT NULL
)
GO

CREATE TABLE [suppliers] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255) NOT NULL
)
GO

ALTER TABLE [editions] ADD FOREIGN KEY ([workId]) REFERENCES [works] ([id])
GO

ALTER TABLE [editions] ADD FOREIGN KEY ([languageId]) REFERENCES [languages] ([id])
GO

ALTER TABLE [editions] ADD FOREIGN KEY ([formatId]) REFERENCES [formats] ([id])
GO

ALTER TABLE [editions] ADD FOREIGN KEY ([ageRatingId]) REFERENCES [ageRatings] ([id])
GO

ALTER TABLE [editions] ADD FOREIGN KEY ([publisherId]) REFERENCES [publishers] ([id])
GO

ALTER TABLE [tagsEditions] ADD FOREIGN KEY ([tagId]) REFERENCES [tags] ([id])
GO

ALTER TABLE [tagsEditions] ADD FOREIGN KEY ([editionId]) REFERENCES [editions] ([id])
GO

ALTER TABLE [genresEditions] ADD FOREIGN KEY ([genreId]) REFERENCES [genres] ([id])
GO

ALTER TABLE [genresEditions] ADD FOREIGN KEY ([editionId]) REFERENCES [editions] ([id])
GO

ALTER TABLE [copies] ADD FOREIGN KEY ([editionId]) REFERENCES [editions] ([id])
GO

ALTER TABLE [copies] ADD FOREIGN KEY ([branchId]) REFERENCES [branches] ([id])
GO

ALTER TABLE [orders] ADD FOREIGN KEY ([supplierId]) REFERENCES [suppliers] ([id])
GO

ALTER TABLE [orders] ADD FOREIGN KEY ([branchId]) REFERENCES [branches] ([id])
GO

ALTER TABLE [orderDetails] ADD FOREIGN KEY ([orderId]) REFERENCES [orders] ([id])
GO

ALTER TABLE [orderDetails] ADD FOREIGN KEY ([editionId]) REFERENCES [editions] ([id])
GO

ALTER TABLE [staff] ADD FOREIGN KEY ([branchId]) REFERENCES [branches] ([id])
GO

ALTER TABLE [members] ADD FOREIGN KEY ([homeBranchId]) REFERENCES [branches] ([id])
GO

ALTER TABLE [members] ADD FOREIGN KEY ([membershipTierId]) REFERENCES [membershipTier] ([id])
GO

ALTER TABLE [contributorsWorks] ADD FOREIGN KEY ([roleId]) REFERENCES [roles] ([id])
GO

ALTER TABLE [contributorsWorks] ADD FOREIGN KEY ([workId]) REFERENCES [works] ([id])
GO

ALTER TABLE [contributorsWorks] ADD FOREIGN KEY ([contributorId]) REFERENCES [contributors] ([id])
GO

ALTER TABLE [contributorsEditions] ADD FOREIGN KEY ([editionId]) REFERENCES [editions] ([id])
GO

ALTER TABLE [contributorsEditions] ADD FOREIGN KEY ([roleId]) REFERENCES [roles] ([id])
GO

ALTER TABLE [contributorsEditions] ADD FOREIGN KEY ([contributorId]) REFERENCES [contributors] ([id])
GO

ALTER TABLE [reservations] ADD FOREIGN KEY ([editionId]) REFERENCES [editions] ([id])
GO

ALTER TABLE [reservations] ADD FOREIGN KEY ([pickUpBranch]) REFERENCES [branches] ([id])
GO

ALTER TABLE [reservations] ADD FOREIGN KEY ([memberId]) REFERENCES [members] ([id])
GO

ALTER TABLE [loans] ADD FOREIGN KEY ([id]) REFERENCES [reservations] ([id])
GO

ALTER TABLE [loans] ADD FOREIGN KEY ([copyId]) REFERENCES [copies] ([id])
GO

ALTER TABLE [fines] ADD FOREIGN KEY ([causeId]) REFERENCES [causes] ([id])
GO

ALTER TABLE [fines] ADD FOREIGN KEY ([loanId]) REFERENCES [loans] ([id])
GO

ALTER TABLE [payments] ADD FOREIGN KEY ([fineId]) REFERENCES [fines] ([id])
GO

ALTER TABLE [tagsEditions]
ADD CONSTRAINT C_TagsEditions UNIQUE ([tagId], [editionId]);
GO

ALTER TABLE [genresEditions]
ADD CONSTRAINT C_GenresEditions UNIQUE ([genreId], [editionId]);
GO

ALTER TABLE [orderDetails]
ADD CONSTRAINT C_OrderDetails UNIQUE ([orderId], [editionId]);
GO

ALTER TABLE [contributorsWorks]
ADD CONSTRAINT C_ContributorsWorks UNIQUE ([roleId], [workId], [contributorId]);
GO

ALTER TABLE [contributorsEditions]
ADD CONSTRAINT C_ContributorsEditions UNIQUE ([roleId], [editionId], [contributorId]);
GO

ALTER TABLE [reservations]
ADD CONSTRAINT C_Reservations UNIQUE ([editionId], [memberId], [requestDate]);
GO

CREATE INDEX IX_reservations_id
ON [reservations] ([id]);
GO

CREATE INDEX IX_loans_id
ON [loans] ([id]);
GO