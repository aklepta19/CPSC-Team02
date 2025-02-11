-- Create a table to store tasks
CREATE TABLE TASK (
	TASK_NUM	-- Unique identifier of a task (will repeat if a task is assigned to multiple drivers)
		INT
		NOT NULL,
	TASK_NAME	-- Name/desc of the task
		NVARCHAR(512)
		NOT NULL,
		UNIQUE,
	ASSIGNER_ID	-- ID of the sponsor who assigned the task
		INT
		FOREIGN KEY REFERENCES SPONSOR_USER(USER_ID)
		NOT NULL,
	ASSIGNEE_ID	-- ID of the driver who is assigned the task
		INT
		FORIENG KEY REFERENCES DRIVER_USER(USER_ID)
		NOT NULL,
	PRIMARY KEY (TASK_NUM, ASIGNEE_ID),	-- Ensures that a driver can only be assigned a given task once
	TASK_POINT_VALUE
		INT
		NOT NULL,
	TASK_DEADLINE	-- Optional field storing the task's deadline
		DATETIME,
	TASK_IS_COMPLETE	-- Boolean storing whether the task is complete
		INT
		NOT NULL
		DEFAULT 0,
	CONSTRAINT COMPLETE_CHECK CHECK (	-- Forces the TASK_IS_COMPLETE value to be true or false
		TASK_IS_COMPLETE IN (1, 0)
		)
	);

-- Create a table for task deadline extension requests
CREATE TABLE TASK_EXTENSION_REQUEST (
	REQ_ID	-- ID that matches an entry in the request table
		INT
		PRIMARY KEY
		FOREIGN KEY REFERENCES REQUEST(REQ_ID),
	TASK_ID	-- ID that matches the task being extended
		INT
		FOREIGN KEY REFERENCES TASK(TASK_NUM)
		NOT NULL,
	USER_ID	-- ID that matches the user requesting the extension
		INT
		FOREIGN KEY REFERENCES DRIVER_USER(USER_ID)
		NOT NULL,
	EREQ_NEW_DEADLINE	-- The task's requested new deadline
		DATETIME
		NOT NULL
	);