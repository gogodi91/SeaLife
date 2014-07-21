CREATE TABLE (
	Area_ID	VARCHAR(32) PRIMARY KEY,
	Start_Latitude CHAR(9),
	/*CONSTRAINT chk_stlat CHECK (Start_Latitude LIKE '__°__.___')
	*/
	Start_Longitude CHAR(9),
	End_Latitude CHAR(9),
	End_Longitude CHAR(9),
	Start_Date DATE,
	Start_Time TIME,
	End_Date DATE,
	End_Time TIME
	);