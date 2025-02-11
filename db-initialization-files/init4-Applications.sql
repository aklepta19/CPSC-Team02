-- Create a table to store application questions for sponsors
CREATE TABLE APPLICATION_QUESTION (
	APPQ_ID		-- Unique identifier for each question
		INT
		PRIMARY KEY
		IDENTITY(1,1),
	COMPANY_ID	-- ID of the company this question is for, if null then it's a default question
		INT
		FOREIGN KEY REFERENCES COMPANY(COMPANY_ID),
	APPQ_TEXT	-- The question itself
		NVARCHAR(512)
		NOT NULL,
	APPQ_ANSWERS	-- JSON data representing possible multiple choice answers, not necessary
		NVARCHAR(1024)
	);

-- Create a table to store the drivers' applications
CREATE TABLE DRIVER_APPLICATION (
	DAPP_ID		-- The ID of the driver's application
		INT
		PRIMARY KEY
		IDENTITY(1,1),
	COMPANY_ID	-- The ID of the company being applied to
		INT
		FOREIGN KEY REFERENCES COMPANY(COMPANY_ID)
		NOT NULL,
	USER_ID		-- The ID of the driver submitting the application
		INT
		FOREIGN KEY REFERNECES DRIVER_USER(USER_ID)
		NOT NULL,
	DAPP_CONTENT	-- A JSON string mapping the IDs fro the APPLICATION_QUESTION table to the answers provided
		NVARCHAR(4096)
		NOT NULL
	);

