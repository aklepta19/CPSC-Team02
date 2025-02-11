-- Create a table to store application questions for sponsors
CREATE TABLE APPLICATION_QUESTION (
	APPQ_ID		-- Unique identifier for each question
		INT
		PRIMARY KEY
		AUTO_INCREMENT,
	COMPANY_ID	-- ID of the company this question is for, if null then it's a default question
		INT,
	FOREIGN KEY (COMPANY_ID)
		REFERENCES COMPANY(COMPANY_ID),
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
		AUTO_INCREMENT,
	COMPANY_ID	-- The ID of the company being applied to
		INT
		NOT NULL,
	FOREIGN KEY (COMPANY_ID)
		REFERENCES COMPANY(COMPANY_ID),
	USER_ID		-- The ID of the driver submitting the application
		INT
        NOT NULL,
	FOREIGN KEY (USER_ID)
		REFERENCES DRIVER_USER(USER_ID),
	DAPP_CONTENT	-- A JSON string mapping the IDs fro the APPLICATION_QUESTION table to the answers provided
		NVARCHAR(4096)
		NOT NULL
	);

