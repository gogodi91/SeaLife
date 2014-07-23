CREATE TABLE Size (
	Size_Age_ID	INTEGER NOT NULL,
	Size		FLOAT,
	Weight		FLOAT,
	FOREIGN KEY (Size_Age_ID) REFERENCES SizeAgeFish(Size_Age_ID)
	);