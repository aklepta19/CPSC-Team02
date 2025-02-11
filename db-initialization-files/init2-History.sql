-- Create the table for site actions, to be used with the Audit Logs
CREATE TABLE SITE_ACTION (
	SACT_ID			-- Unique identifier for the site action
		INT
		PRIMARY KEY
		AUTO_INCREMENT,
	SACT_NAME		-- Name of the action (sign-in, pswd-change, etc.)
		NVARCHAR(32)
		NOT NULL
		UNIQUE,
	SACT_DESC		-- Description of the action if the name isn't sufficient
		NVARCHAR(64)	--  not necessary, since most names are descriptive enough
		UNIQUE
	);

-- Create a general history table for all actions on the site
CREATE TABLE HISTORY (
	HST_ID
		INT
		PRIMARY KEY
		AUTO_INCREMENT,
	SACT_ID
		INT
        NOT NULL,
	FOREIGN KEY (SACT_ID)
		REFERENCES SITE_ACTION(SACT_ID),
	USER_ID
		INT
        NOT NULL,
	FOREIGN KEY (USER_ID)
		REFERENCES GEN_USER(USER_ID),
	HST_DATE
		DATETIME
		NOT NULL
	);

