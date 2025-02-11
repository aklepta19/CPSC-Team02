-- Create a table to store predefined actions and their point values
CREATE TABLE POINT_ACTION (
	PACT_ID		-- The ID of the action
		INT
		PRIMARY_KEY
		IDENTITY(1,1),
	COMPANY_ID	-- The company that created/uses the action definition
		INT
		FOREIGN KEY REFERENCES COMPANY(COMPANY_ID)
		NOT NULL,
	PACT_DESC	-- Description of the action
		NVARCHAR(512)
		NOT NULL,
	PACT_POINT_VALUE	-- The action's point value, positive or negative
		INT
		NOT NULL
	);


-- Create a history table for point changes
CREATE TABLE POINT_CHANGE (
	HST_ID		-- The ID of the history entry this matches
		INT
		PRIMARY KEY
		FOREIGN KEY REFERENCES HISTORY(HST_ID),
	USER_ID		-- The ID of the driver recipient of this point change
		INT
		FOREIGN KEY REFERENCES DRIVER_USER(USER_ID)
		NOT NULL,
	CHANGE_AMOUNT	-- The amount of the change, positive or negative
		INT
		NOT NULL,
	CHANGE_REASON	-- Reason for the change, can match a POINT_ACTION table entry
		NVARCHAR(512)
		NOT NULL
	);

-- Create a table to hold requests for point changes
CREATE TABLE POINT_REQ (
	REQ_ID		-- ID of the request that references the main request table
		INT
		PRIMARY KEY
		FOREIGN KEY REFERENCES REQUEST(REQ_ID),
	USER_ID		-- ID of the driver making the request
		INT
		FOREIGN KEY REFERENCES DRIVER_USER(USER_ID)
		NOT NULL,
	PREQ_AMOUNT	-- The amount of points being requested (positive or negative)
		INT
		NOT NULL
	);

-- Create a view to gather all the point change info together
CREATE VIEW POINT_HISTORY AS SELECT
	HISTORY.HST_ID,
	HISTORY.SACT_ID,
	HISTORY.USER_ID AS ACTOR,
	HISTORY.HST_DATE,
	POINT_CHANGE.USER_ID AS DRIVER,
	POINT_CHANGE.CHANGE_AMOUNT,
	POINT_CHANGE.CHANGE_REASON
FROM HISTORY
RIGHT JOIN POINT_CHANGE ON
	POINT_CHANGE.HST_ID = HISTORY.HST_ID;
GO

-- Create a trigger to automatically update the affected driver when a point change entry is created
CREATE TRIGGER UPDATE_USER_POINTS ON POINT_HISTORY AFTER INSERT AS
BEGIN
	DECLARE @POINT_CHANGE AS INT = (SELECT I.POINT_CHANGE FROM INSERTED I);
	DECLARE @DRIVER_ID AS INT = (SELECT I.USER_ID FROM INSERTED I);

	UPDATE DRIVER_USER SET DRIVER_POINTS = (
		SELECT DRIVER_POINTS FROM DRIVER_USER WHERE USER_ID = @DRIVER_ID
		) + @POINT_CHANGE
		WHERE USER_ID = @DRIVER_ID;
END;
GO