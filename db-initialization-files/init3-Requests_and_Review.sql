-- Create a table for requests, will be inherited by other kinds of requests later
CREATE TABLE REQUEST (
	REQ_ID		-- Unique identifier for each request
		INT
		PRIMARY KEY
		AUTO_INCREMENT,
	REQ_DATE	-- Date and time that the request was made
		DATETIME
		NOT NULL,
	USER_ID		-- Driver that made the request
		INT
        NOT NULL,
	FOREIGN KEY (USER_ID)
		REFERENCES DRIVER_USER(USER_ID),
	REQ_IS_RESOLVED	-- Boolean representing whether the request is still standing or is resolved
		INT
		NOT NULL
		DEFAULT 0
	CONSTRAINT RESOLVED_CHECK CHECK (	-- Force REQ_IS_RESOLVED to be either true or false
		REQ_IS_RESOLVED IN (1, 0)
		)
	);

-- Create a table for driver reviews of sponsors
CREATE TABLE REVIEW (
	SPONSOR_ID	-- The ID of the sponsor being reviewed
		INT
        NOT NULL,
	FOREIGN KEY (SPONSOR_ID)
		REFERENCES SPONSOR_USER(USER_ID),
	DRIVER_ID	-- The ID of the driver posting the review
		INT
        NOT NULL,
	FOREIGN KEY (DRIVER_ID)
		REFERENCES DRIVER_USER(USER_ID),
	PRIMARY KEY (SPONSOR_ID, DRIVER_ID),	-- Forces a single review of each sponsor per driver
	REVIEW_DATE	-- Date and time of the review being posted
		DATETIME
		NOT NULL,
	REVIEW_TEXT	-- The review's content
		NVARCHAR(4096)
		NOT NULL
	);