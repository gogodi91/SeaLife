﻿CREATE TABLE Age (
	Size_Age_ID	INTEGER NOT NULL,
	Age		FLOAT,
	Weight		FLOAT,
	FOREIGN KEY (Size_Age_ID) REFERENCES SizeAgeFish(Size_Age_ID)
	);