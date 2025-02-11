-- Create the table for discounts
CREATE TABLE DISCOUNT (
	DISCOUNT_ID	-- Unique identifier for the discount
		INT
		PRIMARY KEY
		AUTO_INCREMENT,
	USER_ID		-- ID of the driver the discount is granted to
		INT
        NOT NULL,
	FOREIGN KEY (USER_ID)
		REFERENCES DRIVER_USER(USER_ID),
	DISCOUNT_IS_PERCENT	-- Boolean about whether the value is a percent
		INT
		NOT NULL,
	DISCOUNT_AMOUNT		-- Percent/amount of discount. Ex. If the value is 15, then it will either
		INT		--  be 15% off, or 15 points off depending on the DISCOUNT_IS_PERCENT value
		NOT NULL,
	DISOCUNT_DEADLINE	-- Optional deadline for the discount to be used by
		DATETIME,
	CONSTRAINT PERCENT_CHECK CHECK (	-- Force the DISCOUNT_IS_PERCENT value to be true or false
		DISCOUNT_IS_PERCENT IN (1, 0)
		)
	);
	
-- Create a table for a purchase history
CREATE TABLE PURCHASE_HISTORY (
	HST_ID		-- ID that matches to an entry in the history table
		INT
		PRIMARY KEY,
	FOREIGN KEY (HST_ID)
		REFERENCES HISTORY(HST_ID),
	CATALOG_ID	-- The catalog the purchase was made from
		INT
        NOT NULL,
	FOREIGN KEY (CATALOG_ID)
		REFERENCES CATALOG(CATALOG_ID),
	PCH_HST_ITEM	-- The item that was purchased, must be in the JSON data of the sponsor's item list
		NVARCHAR(32)
		NOT NULL,
	DISCOUNT_ID	-- ID of the discount used on the item
		INT,
	FOREIGN KEY (DISCOUNT_ID)
		REFERENCES DISCOUNT(DISCOUNT_ID),
	USER_ID		-- ID of the driver that made the purchase
		INT
        NOT NULL,
	FOREIGN KEY (USER_ID)
		REFERENCES DRIVER_USER(USER_ID)
	);