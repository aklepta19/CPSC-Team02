-- Create a table for market endpoints
CREATE TABLE CATALOG (
	CATALOG_ID		-- Unique identifier for the catalog
		INT
		PRIMARY KEY
		IDENTITY(1,1),
	CATALOG_NAME		-- Name of the catalog (Etsy, Amazon, etc.)
		NVARCHAR(32)
		NOT NULL
		UNIQUE,
	CATALOG_ENDPOINT	-- Endpoint data for connecting to the market's API
		NVARCHAR(512)
		NOT NULL
		UNIQUE
	);

-- Create a table for the Companies that work with the site
CREATE TABLE COMPANY (
	COMPANY_ID		-- Unique identifier for the company
		INT
		PRIMARY KEY
		IDENTITY(1,1),
	COMPANY_NAME		-- Name of the company
		NVARCHAR(64)
		NOT NULL
		UNIQUE,
	COMPANY_DESC		-- Company bio, used in the 'about us' page for each company
		NVARCHAR(512),
	CATALOG_ID		-- ID of the catalog the company displays to the drivers
		INT
		FOREIGN KEY REFERENCES CATALOG(CATALOG_ID)
		NOT NULL,
	CATALOG_ITEMS		-- JSON string containing specific items displayed for the catalog
		NVARCHAR(4096)
		NOT NULL
	);


