-- Create the item request table
CREATE TABLE ITEM_REQUEST (
	REQ_ID		-- ID that matches an entry in the request table
		INT
		PRIMARY KEY,
	FOREIGN KEY (REQ_ID)
		REFERENCES REQUEST(REQ_ID),
	IREQ_CATALOG	-- ID that matches the catalog that the item will be added to
		INT
        NOT NULL,
	FOREIGN KEY (IREQ_CATALOG)
		REFERENCES CATALOG(CATALOG_ID),
	IREQ_ITEM	-- JSON particle containing the requested item's identifier
		NVARCHAR(32)
		NOT NULL
	);

-- Create a table for bug fix requests
CREATE TABLE BUG_REQUEST (
	REQ_ID		-- ID that matches an entry in the request table
		INT
		PRIMARY KEY,
	FOREIGN KEY (REQ_ID)
		REFERENCES REQUEST(REQ_ID),
	BREQ_REXT	-- Description of the bug being reported
		NVARCHAR(4096)
		NOT NULL
	);

-- Create a table for time off requests
CREATE TABLE TIME_OFF_REQUESTS (
	REQ_ID		-- ID that matches an entry in the request table
		INT
		PRIMARY KEY,
	FOREIGN KEY (REQ_ID)
		REFERENCES REQUEST(REQ_ID),
	TREQ_START	-- The start date of the time-off request
		DATETIME
		NOT NULL,
	TREQ_END	-- The end date of the time-off request
		DATETIME
		NOT NULL
	);