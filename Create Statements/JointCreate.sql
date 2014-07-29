--Database: "Monitoring"

--DROP DATABASE "Monitoring";
/*
CREATE DATABASE "Monitoring"
  WITH OWNER = lev3_13_1003626d
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Bulgarian_Bulgaria.1251'
       LC_CTYPE = 'Bulgarian_Bulgaria.1251'
       CONNECTION LIMIT = -1;

COMMENT ON DATABASE "Monitoring"
  IS 'Sea life monitoring database';
*/

/*------------------------
	Area
--------------------------*/
DROP TABLE IF EXISTS Area CASCADE;
CREATE SEQUENCE Area_ID_seq;
CREATE TABLE Area (
	Area_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
	Start_Latitude CHAR(9),
	Start_Longitude CHAR(9),
	End_Latitude CHAR(9),
	End_Longitude CHAR(9),
	Start_Date DATE,
	Start_Time TIME,
	End_Date DATE,
	End_Time TIME
	);
ALTER SEQUENCE Area_ID_seq OWNED BY Area.Area_ID;

/*------------------------
	Cruise
--------------------------*/
DROP TABLE IF EXISTS Cruise CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE Cruise (
	Cruise_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Cruise_ID_seq'),
	Start_Date	DATE,
	End_Date	DATE,
	Objectives	VARCHAR(64),
	Vessel_ID	VARCHAR (64),/*nova tablica s cruisi*/
	CSR_Code VARCHAR (32)
	);
ALTER SEQUENCE Cruise_ID_seq OWNED BY Cruise.Cruise_ID;

/*------------------------
	Vessel
--------------------------*/

/*------------------------
	Stations
--------------------------*/
DROP TABLE IF EXISTS Stations CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE Stations (
	Station_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
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

/*------------------------
	TypeSpec
--------------------------*/
DROP TABLE IF EXISTS TypeSpec CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE TypeSpec (
	Type_Spec_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
	CONSTRAINT chk_Type_Spec CHECK (Type_Spec_ID IN ('FISH','PHY_PL','ZOO_PL','ZOO_BEN','PHY_BEN')),
	BSID		INTEGER
	);

/*------------------------
	TAXA
--------------------------*/
DROP TABLE IF EXISTS TAXA CASCADE;
CREATE SEQUENCE Cruise_ID_seq;	
CREATE TABLE TAXA (
	Taxa_ID		SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
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

/*------------------------
	ChemParam
--------------------------*/
DROP TABLE IF EXISTS ChemParam CASCADE;
CREATE SEQUENCE Cruise_ID_seq;	
CREATE TABLE ChemParam (
	Param_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),/*not null, autoincr, unique*/
	Parameter	VARCHAR(10),
	Dimention	VARCHAR(10)
	);

/*------------------------
	Event
--------------------------*/
DROP TABLE IF EXISTS Event CASCADE;
CREATE SEQUENCE Cruise_ID_seq;	
CREATE TABLE Event (
	Event_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
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

/*------------------------
	Chemistry
--------------------------*/
DROP TABLE IF EXISTS Chemistry CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE Chemistry (
	Chem_ID		SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
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

/*------------------------
	DataAB
--------------------------*/
DROP TABLE IF EXISTS DataAB CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE DataAB (
	A_B_ID		SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
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

/*------------------------
	SizeAgeFish
--------------------------*/
DROP TABLE IF EXISTS SizeAgeFish CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE SizeAgeFish (
	Size_Age_ID	SMALLINT PRIMARY KEY NOT NULL DEFAULT nextval('Area_ID_seq'),
	A_B_ID		VARCHAR(10) NOT NULL,
	FOREIGN KEY (A_B_ID) REFERENCES DataAB(A_B_ID)
	);

/*------------------------
	Age
--------------------------*/
DROP TABLE IF EXISTS Age CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE Age (
	Size_Age_ID	SMALLINT NOT NULL DEFAULT nextval('Area_ID_seq'),
	Age		FLOAT,
	Weight		FLOAT,
	FOREIGN KEY (Size_Age_ID) REFERENCES SizeAgeFish(Size_Age_ID)
	);

/*------------------------
	Size
--------------------------*/
DROP TABLE IF EXISTS Size CASCADE;
CREATE SEQUENCE Cruise_ID_seq;
CREATE TABLE Size (
	Size_Age_ID	SMALLINT NOT NULL DEFAULT nextval('Area_ID_seq'),
	Size_From	FLOAT,
	Size_To		FLOAT,
	Weight		FLOAT,
	FOREIGN KEY (Size_Age_ID) REFERENCES SizeAgeFish(Size_Age_ID)
	);
