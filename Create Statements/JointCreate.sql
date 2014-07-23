CREATE TABLE Area (
	Area_ID	VARCHAR(32) PRIMARY KEY,
	Start_Latitude CHAR(9),
	Start_Longitude CHAR(9),
	End_Latitude CHAR(9),
	End_Longitude CHAR(9),
	Start_Date DATE,
	Start_Time TIME,
	End_Date DATE,
	End_Time TIME
	);

CREATE TABLE Cruise (
	Cruise_ID	VARCHAR(32) PRIMARY KEY,
	Start_Date DATE,
	End_Date DATE,
	Objectives VARCHAR(64),
	Vessel_ID VARCHAR (64),
	CSR_Code VARCHAR (32)
	);

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

CREATE TABLE TypeSpec (
	Type_Spec_ID	VARCHAR(15) PRIMARY KEY
	CONSTRAINT chk_Type_Spec CHECK (Type_Spec_ID IN ('FISH','PHY_PL','ZOO_PL','ZOO_BEN','PHY_BEN')),
	BSID		INTEGER
	);

CREATE TABLE TAXA (
	Taxa_ID		INTEGER PRIMARY KEY,
	Type_Spec	VARCHAR(15) 
	CONSTRAINT chk_Type_Spec CHECK (Type_Spec IN ('FISH','PHY_PL','ZOO_PL','ZOO_BEN','PHY_BEN'))
	NOT NULL,
	URL		VARCHAR(128),
	Scientific_Name	VARCHAR(64),
	Authority	VARCHAR(64),
	Rank		VARCHAR(64),
	Status		VARCHAR(64),
	Unaccept_reason	VARCHAR(64),
	Valid_APHIA_ID	INTEGER,
	Valid_Name	VARCHAR(64),
	Valid_Authority	VARCHAR(64),
	Kingdom		VARCHAR(64),
	Phylum		VARCHAR(64),
	Class		VARCHAR(64),
	Order_		VARCHAR(64),
	Family		VARCHAR(64),
	Genus		VARCHAR(64),
	Citation	VARCHAR(512),
	LSID		VARCHAR(128),
	Is_Marine	BOOLEAN,
	Is_Brackish	BOOLEAN,
	Is_Freshwater	BOOLEAN,
	Is_Terestrial	BOOLEAN,
	Is_Extinct	BOOLEAN,
	Match_Type	VARCHAR(32),
	Modified	CHAR(20),
	FOREIGN KEY (Type_Spec)	REFERENCES TypeSpec(Type_Spec_ID)
	);

CREATE TABLE ChemParam (
	Param_ID	VARCHAR(11) PRIMARY KEY,
	Parameter	VARCHAR(10),
	Dimention	VARCHAR(10)
	);

CREATE TABLE Event (
	Event_ID	VARCHAR(15) PRIMARY KEY,
	Station_ID	VARCHAR(32) NOT NULL,
	Area_ID		VARCHAR(32) NOT NULL,
	Cruise_ID	VARCHAR(32) NOT NULL,
	Institute_Code	VARCHAR(15),
	Collect_Code	VARCHAR(32),
	Gear_Equipment	VARCHAR(20),
	Sample_type	VARCHAR(8),
	Date_Local_Time	DATE,
	Date_UTC	VARCHAR(24),
	Start_Depth	FLOAT,
	End_Depth	FLOAT,
	Operator	VARCHAR(32),
	Post_Operator	VARCHAR(32),
	Notes		VARCHAR(128),
	FOREIGN KEY (Station_ID) REFERENCES Stations(Station_ID),
	FOREIGN KEY (Area_ID) REFERENCES Area(Area_ID),
	FOREIGN KEY (Cruise_ID) REFERENCES Cruise(Cruise_ID)
	);

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

CREATE TABLE DataAB (
	A_B_ID		VARCHAR(10) PRIMARY KEY,
	/*Event_ID	VARCHAR(15) NOT NULL,
	eventID becomes redundant as it is present in the table
	Cemistry and it`s eventID should corespond to the same 
	event as being described in dataAB sample.
	(One could add this field here for ease of access to 
	its data, but this way redundency is introduced.)
	*/
	Chem_ID		INTEGER NOT NULL,
	TAXA_ID		INTEGER NOT NULL,
	Type_Spec_ID	VARCHAR(15) NOT NULL,
	Abundance	INTEGER,
	Abundance_Unit	VARCHAR(15),
	Biomass		FLOAT,
	Biomass_Unit	VARCHAR(15),
	Replica_Unit	INTEGER,
	Notes		VARCHAR(128),
	/*FOREIGN KEY Event_ID REFERENCES Event(Event_ID),*/
	FOREIGN KEY (Chem_ID) REFERENCES Chemistry(Chem_ID),
	FOREIGN KEY (TAXA_ID) REFERENCES TAXA(TAXA_ID),
	FOREIGN KEY (Type_Spec_ID) REFERENCES TypeSpec(Type_Spec_ID)
	);

CREATE TABLE SizeAgeFish (
	Size_Age_ID	INTEGER PRIMARY KEY,
	A_B_ID		VARCHAR(10) NOT NULL,
	FOREIGN KEY (A_B_ID) REFERENCES DataAB(A_B_ID)
	);

CREATE TABLE Age (
	Size_Age_ID	INTEGER NOT NULL,
	Age		FLOAT,
	Weight		FLOAT,
	FOREIGN KEY (Size_Age_ID) REFERENCES SizeAgeFish(Size_Age_ID)
	);

CREATE TABLE Size (
	Size_Age_ID	INTEGER NOT NULL,
	Size		FLOAT,
	Weight		FLOAT,
	FOREIGN KEY (Size_Age_ID) REFERENCES SizeAgeFish(Size_Age_ID)
	);
