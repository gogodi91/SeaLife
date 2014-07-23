CREATE TABLE Chemistry (
	Chem_ID		INTEGER PRIMARY KEY,
	Event_ID	VARCHAR(15) NOT NULL,
	Param_ID	VARCHAR(11) NOT NULL,
	Param_Value	FLOAT,
	Sample_Validated	BOOLEAN,
	Sample_Number	INTEGER,
	Protocol_Number	INTEGER,
	Notes		VARCHAR(128),
	FOREIGN KEY (Event_ID) REFERENCES Event(Event_ID),
	FOREIGN KEY (Param_ID) REFERENCES ChemParam(Param_ID)
	);