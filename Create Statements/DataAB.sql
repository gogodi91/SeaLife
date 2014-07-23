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