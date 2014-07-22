CREATE TABLE Stations (
	Station_ID	VARCHAR(32) PRIMARY KEY,
	Station_Type	VARCHAR(10),
	Station_Code	VARCHAR(20),
	Station_Name_BG	VARCHAR(32),
	Station_Name_LAT	VARCHAR(32),
	Station_Depth	FLOAT,
	Latitude	CHAR(9),
	Longitude	CHAR(9),
	Substrat	VARCHAR(20),
	Notes		VARCHAR(128)
	);