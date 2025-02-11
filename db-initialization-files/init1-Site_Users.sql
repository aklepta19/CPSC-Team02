-- Create a table to store all kinds of users in the table
CREATE TABLE USER_TYPES (
	TYPE_NAME
		NVARCHAR(32)
		PRIMARY KEY
	);

-- Create the general users table, will be referenced by all others
CREATE TABLE GEN_USER (
	USER_ID			-- Unique identifier for the user
		INT
		PRIMARY KEY
		IDENTITY(1,1)
	USER_FNAME		-- User's first and last names, used for
		NVARCHAR(32)	--  personalized notifications and pages
		NOT NULL,
	USER_LNAME
		NVARCHAR(32)
		NOT NULL,
	USER_DISP_NAME		-- Unique display name for each user
		NVARCHAR(32)
		NOT NULL
		UNIQUE,
	USER_PSWD_HASH		-- Password, hashed and salted prior to insertion
		INT		--  for security reasons
		NOT NULL,
	USER_EMAIL		-- User's email address, to be verified prior to insertion
		NVARCHAR(64)
		NOT NULL
		UNIQUE,
	USER_PHONE		-- User's phone number. Stored as a large integer, optional.
		INT
		UNIQUE,
	USER_TYPE		-- Admin, Sponsor, or Driver
		NVARCHAR(32)
		NOT NULL
		FOREIGN KEY REFERENCES USER_TYPES(TYPE_NAME),
	USER_CREATION_DATE	-- Date and time of account creation
		DATETIME
		NOT NULL
	);


-- Create the particular types of users
CREATE TABLE ADMIN_USER (
	USER_ID		-- Unique ID, identifies this user in the general table.
		INT	--  Probably we'll need more info later but I couldn't think of anything for here
		PRIMARY KEY
		FORIEGN KEY REFERENCES GEN_USER(USER_ID),
	);

CREATE TABLE SPONSOR_USER (
	USER_ID		-- Unique ID, identifies this user in the general table.
		INT
		PRIMARY KEY
		FOREIGN KEY REFERENCES GEN_USER(USER_ID),
	COMPANY_ID	-- ID of the company this sponsor user represents
		INT
		FOREIGN KEY REFERENCES COMPANY(COMPANY_ID)
		NOT NULL
	);

CREATE TABLE DRIVER_USER (
	USER_ID		-- Unique ID, identified this user in the general table
		INT
		PRIMARY KEY
		FOREIGN KEY REFERENCES GEN_USER(USER_ID),
	COMPANY_ID	-- ID of the company this driver is a member of
		INT
		FOREIGN KEY REFERENCES COMPANY(COMPANY_ID)
		NOT NULL,
	DRIVER_LICENSE_VALID	-- A boolean representing whether a driver's lisence is valid, defaults to true
		INT
		NOT NULL
		DEFAULT 1,
	DRIVER_DOB		-- Driver's date of birth (the time part doesn't matter)
		DATETIME
		NOT NULL,
	DRIVER_POINTS		-- The total number of points a driver has, defaults to 0
		INT
		NOT NULL
		DEFAULT 0
	CONSTRAINT VALID_CHECK CHECK (	-- Ensures that the validity flag is either true or false
		DRIVER_LICENSE_VALID IN (1, 0)
		)
	);


-- Create a set of views to make gathering all information about a user easier
CREATE VIEW ADMIN AS SELECT
	GEN_USER.USER_ID,
	GEN_USER.USER_FNAME,
	GEN_USER.USER_LNAME,
	GEN_USER.USER_DISP_NAME,
	GEN_USER.USER_PSWD_HASH,
	GEN_USER.USER_EMAIL,
	GEN_USER.USER_PHONE,
	GEN_USER.USER_CREATION_DATE
FROM GEN_USER
RIGHT JOIN ADMIN_USER ON
	GEN_USER.USER_ID = ADMIN_USER.USER_ID;

CREATE VIEW SPONSOR AS SELECT
	GEN_USER.USER_ID,
	GEN_USER.USER_FNAME,
	GEN_USER.USER_LNAME,
	GEN_USER.USER_DISP_NAME,
	GEN_USER.USER_PSWD_HASH,
	GEN_USER.USER_EMAIL,
	GEN_USER.USER_PHONE,
	GEN_USER.USER_CREATION_DATE,
	SPONSOR_USER.COMPANY_ID
FROM GEN_USER
RIGHT JOIN SPONSOR_USER ON
	GEN_USER.USER_ID = SPONSOR_USER.USER_ID;

CREATE VIEW DRIVER AS SELECT
	GEN_USER.USER_ID,
	GEN_USER.USER_FNAME,
	GEN_USER.USER_LNAME,
	GEN_USER.USER_DISP_NAME,
	GEN_USER.USER_PSWD_HASH,
	GEN_USER.USER_EMAIL,
	GEN_USER.USER_PHONE,
	GEN_USER.USER_CREATION_DATE
	DRIVER_USER.COMPANY_ID,
	DRIVER_USER.DRIVER_LICENSE_VALID,
	DRIVER_USER.DRIVER_DOB,
	DRIVER_USER.DRIVER_POINTS
FROM GEN_USER
RIGHT JOIN DRIVER_USER ON
	GEN_USER.USER_ID = DRIVER_USER.USER_ID;