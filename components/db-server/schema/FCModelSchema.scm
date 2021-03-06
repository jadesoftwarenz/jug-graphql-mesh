/* JADE COMMAND FILE NAME C:\development\Devops\jade-data-fabric\components\db-server\schema\FCModelSchema.jcf */
jadeVersionNumber "20.0.02";
schemaDefinition
FCModelSchema subschemaOf RootSchema completeDefinition, patchVersioningEnabled = false;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:00:34.351;
importedPackageDefinitions
constantDefinitions
	categoryDefinition ModelErrorCodes
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:33:20.877;
		InvalidDirectoryPath:          Integer = 150019;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:34:17.013;
localeDefinitions
	5129 "English (New Zealand)" schemaDefaultLocale;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:00:34.288;
	1033 "English (United States)" _cloneOf 5129;
		setModifiedTimeStamp "<unknown>" "" 2021:09:29:16:59:18;
libraryDefinitions
typeHeaders
	FCModelSchema subclassOf RootSchemaApp transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, highestOrdinal = 1, number = 2048;
	DataLoader subclassOf Object highestOrdinal = 2, number = 2096;
	FCEntity subclassOf Object number = 2051;
	FCAccount subclassOf FCEntity highestOrdinal = 5, number = 2076;
	FCCard subclassOf FCEntity number = 2080;
	FCClient subclassOf FCEntity highestOrdinal = 16, number = 2078;
	FCDistrict subclassOf FCEntity number = 2095;
	FCInstitute subclassOf FCEntity number = 2065;
	FCLoan subclassOf FCEntity number = 2081;
	FCOrder subclassOf FCEntity number = 2082;
	FCRoot subclassOf FCEntity highestSubId = 2, highestOrdinal = 2, number = 2103;
	GFCModelSchema subclassOf RootSchemaGlobal transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, number = 2049;
	SFCModelSchema subclassOf RootSchemaSession transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, number = 2050;
	AccountByIdDict subclassOf MemberKeyDictionary loadFactor = 66, number = 2104;
	ClientByIdDict subclassOf MemberKeyDictionary loadFactor = 66, number = 2110;
 
membershipDefinitions
	AccountByIdDict of FCAccount ;
	ClientByIdDict of FCClient ;
 
typeDefinitions
	Object completeDefinition
	(
	)
	Application completeDefinition
	(
	)
	RootSchemaApp completeDefinition
	(
	)
	FCModelSchema completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:00:34.335;
	referenceDefinitions
		myRoot:                        FCRoot  number = 1, ordinal = 1;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:31:07.020;
 
	jadeMethodDefinitions
		initialize() updating, number = 1002;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:31:27.724;
		loadData(args: HugeStringArray) number = 1003;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:13:53:00.335;
		raiseModelException(errorNo: Integer) number = 1001;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:30:31.483;
	)
	DataLoader completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:54:15.300;
	attributeDefinitions
		dataDirectory:                 String[301] protected, number = 1, ordinal = 1;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:41:21.023;
	referenceDefinitions
		myRoot:                        FCRoot  protected, number = 2, ordinal = 2;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:42:31.401;
 
	jadeMethodDefinitions
		getElapsedTimeString(startClock: Integer): String protected, number = 1005;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:18:22.242;
		loadAccounts() protected, number = 1004;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:51:34.181;
		loadData(directoryPath: String) updating, number = 1002;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:56:26.943;
		validateDirectoryPath(directoryPath: String): String protected, number = 1003;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:18:29.738;
	)
	FCEntity completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:01:02.990;
	)
	FCAccount completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:16.359;
	attributeDefinitions
		date:                          Date number = 4, ordinal = 4;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:11:34.149;
		district:                      Integer number = 2, ordinal = 2;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:10:34.845;
		frequency:                     String[31] number = 3, ordinal = 3;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:11:05.460;
		id:                            String[31] number = 1, ordinal = 1;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:23:02.060;
	referenceDefinitions
		myRoot:                        FCRoot   explicitEmbeddedInverse, number = 5, ordinal = 5;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:05:52.574;
 
	jadeMethodDefinitions
		create(
			id: String; 
			district: Integer; 
			frequency: String; 
			date: Date; 
			parent: FCRoot) updating, number = 1001;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:10:46.392;
	)
	FCCard completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:23.814;
	)
	FCClient completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:33.713;
	attributeDefinitions
		address_1:                     String[31] number = 10, ordinal = 10;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:16:54.444;
		asdress_2:                     String[31] number = 11, ordinal = 11;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:17:07.534;
		city:                          String[31] number = 12, ordinal = 12;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:17:25.028;
		dateOfBirth:                   Date number = 4, ordinal = 4;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:14:18.028;
		district_id:                   Integer number = 15, ordinal = 15;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:18:59.323;
		email:                         String[31] number = 9, ordinal = 9;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:16:33.717;
		firstName:                     String[31] number = 5, ordinal = 5;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:15:05.980;
		gender:                        String[13] number = 2, ordinal = 2;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:12:59.276;
		id:                            String[13] number = 1, ordinal = 1;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:12:18.263;
		lastName:                      String[31] number = 7, ordinal = 7;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:15:43.620;
		middleName:                    String[31] number = 6, ordinal = 6;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:15:16.707;
		phoneNumber:                   String[16] number = 8, ordinal = 8;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:16:20.444;
		ssn:                           String[13] number = 3, ordinal = 3;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:13:47.819;
		state:                         String[31] number = 13, ordinal = 13;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:17:40.668;
		zipCode:                       String[13] number = 14, ordinal = 14;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:18:34.826;
	referenceDefinitions
		myRoot:                        FCRoot   explicitEmbeddedInverse, number = 16, ordinal = 16;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:06:03.325;
	)
	FCDistrict completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:40.222;
	)
	FCInstitute completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:47.598;
	)
	FCLoan completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:54.527;
	)
	FCOrder completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:05:00.926;
	)
	FCRoot completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:05:07.774;
	referenceDefinitions
		allAccounts:                   AccountByIdDict   explicitInverse, subId = 1, number = 1, ordinal = 1;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:05:52.511;
		allClients:                    ClientByIdDict   explicitInverse, subId = 2, number = 2, ordinal = 2;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:06:03.309;
 
	jadeMethodDefinitions
		createAccount(
			id: String; 
			district: Integer; 
			frequency: String; 
			date: Date): FCAccount number = 1001;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:10:54.676;
		createClient() number = 1002;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:36:14.749;
	)
	Global completeDefinition
	(
	)
	RootSchemaGlobal completeDefinition
	(
	)
	GFCModelSchema completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:00:34.351;
	)
	JadeRestService completeDefinition
	(
		setModifiedTimeStamp "cnwta3" "99.0.00" 2020:07:19:19:05:33.286;
	)
	JadeScript completeDefinition
	(
 
	jadeMethodDefinitions
		loadData() number = 1001;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:22:03.799;
		purgeData() number = 1002;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:06:15.868;
	)
	WebSession completeDefinition
	(
	)
	RootSchemaSession completeDefinition
	(
		setModifiedTimeStamp "<unknown>" "6.1.00" 20031119 2003:12:01:13:54:02.270;
	)
	SFCModelSchema completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:00:34.351;
	)
	Collection completeDefinition
	(
	)
	Btree completeDefinition
	(
	)
	Dictionary completeDefinition
	(
	)
	MemberKeyDictionary completeDefinition
	(
	)
	AccountByIdDict completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:07:07.566;
	)
	ClientByIdDict completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:22:07:44.878;
	)
 
memberKeyDefinitions
	AccountByIdDict completeDefinition
	(
		id;
	)
	ClientByIdDict completeDefinition
	(
		id;
	)
 
inverseDefinitions
	allAccounts of FCRoot automatic parentOf myRoot of FCAccount manual;
	allClients of FCRoot automatic parentOf myRoot of FCClient manual;
databaseDefinitions
FCModelSchemaDb
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:21:00:34.351;
	databaseFileDefinitions
		"fcdata" number = 55;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:04:03.289;
		"fcdefault" number = 51;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:17:03:34.551;
	defaultFileDefinition "fcdefault";
	classMapDefinitions
		SFCModelSchema in "_environ";
		FCModelSchema in "_usergui";
		FCInstitute in "fcdata";
		FCAccount in "fcdata";
		FCClient in "fcdata";
		FCCard in "fcdata";
		FCLoan in "fcdata";
		FCOrder in "fcdata";
		FCDistrict in "fcdata";
		FCRoot in "fcdata";
		GFCModelSchema in "fcdefault";
		FCEntity in "fcdefault";
		DataLoader in "fcdefault";
		AccountByIdDict in "fcdefault";
		ClientByIdDict in "fcdefault";
	)
schemaViewDefinitions
exportedPackageDefinitions
typeSources
	FCModelSchema (
	jadeMethodSources
initialize
{
initialize() updating;

vars

begin
	self.myRoot := FCRoot.firstInstance;
end;

}

loadData
{
loadData(args : HugeStringArray);

// --------------------------------------------------------------------------------
// Method:      dataLoaderApp
//
// Purpose:     Method to initialize the database from CSV files.
//              This NON-Gui application initialize method takes the directory
//              as a command line arguement.
//
//              jadclient schema=FCModelSchema app=DataLoader endJade DataFiles
// --------------------------------------------------------------------------------
constants
	NumberOfArgs 	= 1;
	FirstArgIndex 	= 1;
vars
	dataLoader : DataLoader;
	fileFolder : FileFolder;
	dirPath    : String;

begin
	// Check the command line has arguments
	if args = null or args.size <> NumberOfArgs then
		write "Example: jadclient schema=FCModelSchema app=DataLoader end DataFiles";
		return;
	endif;
	
	// Get the directory containing the initial data files from the command line
	create fileFolder transient;
	dirPath := args[FirstArgIndex];
	if dirPath <> null then
		// Create our data loader and initialize the database
		create dataLoader transient;
		dataLoader.loadData(dirPath);
	endif;
	
epilog
	delete dataLoader; // does nothing if dataLoader is null
	delete fileFolder; // does nothing if fileFolder is null
	
	terminate;
end;
}

raiseModelException
{
raiseModelException(errorNo : Integer);
// --------------------------------------------------------------------------------
// Method:		raiseModelException
//
// Purpose:		Raises an exception of type ModelException.
//              The errorCode of the exception is set to the supplied error number.
// --------------------------------------------------------------------------------
vars
//	exceptionObject : ModelException;
	
exceptionObject : Exception;	

begin
	create exceptionObject transient;
	exceptionObject.errorCode := errorNo;
	exceptionObject.errorItem := errorNo.String;
	// FIXME
	// exceptionObject.errorItem := self.getErrorString(errorNo);
	raise exceptionObject;
end;
}

	)
	DataLoader (
	jadeMethodSources
getElapsedTimeString
{
getElapsedTimeString(startClock : Integer) : String protected;
vars
	elapsedTime : Integer;

begin
	elapsedTime := (app.clock - startClock) div 1000;
	if elapsedTime < 1 then
		return "less than 1 second";
	endif;
	return elapsedTime.String & " seconds";
end;
}

loadAccounts
{
loadAccounts() protected;
constants
	AccountsFileName : String = "accounts.csv";
	FirstIndexInLine : Integer = 1;
	LineSkipDelimiter : Character = '#';
vars
	inputFile		: File;
	line			: String;
	account_id		: String;
	district_id		: Integer;
	frequency		: String;
	date			: Date;
	pos				: Integer;
	startClock		: Integer;
    splits 			: JadeRegexResult;
begin
	startClock := app.clock;

	create inputFile transient;
	inputFile.allowCreate := false;
	inputFile.allowReplace := false;
	inputFile.endOfLine := "";
	inputFile.kind := File.Kind_Unknown_Text;	
	inputFile.openInput(self.dataDirectory & AccountsFileName);

	write "Loading " & inputFile.fileName & "...";
	// read and ignore header
	line := inputFile.readLine.trimBlanks;
	while not inputFile.endOfFile do
		line := inputFile.readLine.trimBlanks;

		// Empty lines  are skipped
		if line <> null then

			JadeRegex@split(line, ',', true, splits);
			
			account_id := splits.at(1).value;
			district_id := splits.at(2).value.Integer;
			frequency := splits.at(3).value;
			date   := splits.at(4).value.Date;

			self.myRoot.createAccount(account_id, district_id, frequency, date);

		endif;
	endwhile;

epilog
	delete inputFile;
	write self.myRoot.allAccounts.size.String & " accounts loaded in " & self.getElapsedTimeString(startClock);
end;
}

loadData
{
loadData(directoryPath : String) updating;
vars
	startTime             : Integer;
	closeTendersStartTime : Integer;
	total                 : Integer;
	currentDate           : Date; 		// Initialized to the current date

begin
	// Get the initial time
	startTime := app.clock;

	// Ensure the supplied directory path is valid
	self.dataDirectory := self.validateDirectoryPath(directoryPath);

	// Purge all existing data.
	beginTransaction;
	delete FCRoot.firstInstance;
	commitTransaction;

	beginTransaction;
	// Create our singleton persistent FCRoot
	create self.myRoot persistent;
	// Load the rest of the data
	self.loadAccounts();
	//self.zLoadLocations;
	//self.zLoadAgents;
	//self.zLoadClients;
	commitTransaction;

	write "Data loaded in " & self.getElapsedTimeString(startTime);
end;
}

validateDirectoryPath
{
validateDirectoryPath(directoryPath : String) : String protected;
// --------------------------------------------------------------------------------
// Method:		zValidateDirectoryPath
//
// Purpose:		Validates a directory path. Raises an InvalidDirectoryPath
//              ModelException if the path is not valid.
//
// Returns:     The directory path with a "/" suffix
// --------------------------------------------------------------------------------
vars
	returnDirPath : String;
	dir           : FileFolder;

begin
	returnDirPath := directoryPath.trimBlanks;

	if returnDirPath.length <= 0 then
		app.raiseModelException(InvalidDirectoryPath);
		return null;
	endif;

	if returnDirPath[returnDirPath.length] <> "/" and returnDirPath[returnDirPath.length] <> "\" then
		returnDirPath := returnDirPath & "/";
	endif;

	create dir transient;

	if not dir.isValidPathName(returnDirPath) then
		app.raiseModelException(InvalidDirectoryPath);
		return null;
	endif;

	dir.fileName := returnDirPath;
	if not dir.isAvailable then
		app.raiseModelException(InvalidDirectoryPath);
		return null;
	endif;

	return returnDirPath;

epilog
	delete dir; // does nothing if dir is null
end;
}

	)
	FCAccount (
	jadeMethodSources
create
{
create(id : String; district : Integer; frequency : String; date : Date; parent : FCRoot) updating;
begin
	self.id := id;
	self.district := district;
	self.frequency := frequency;
	self.date := date;
	self.myRoot := parent;
end;

}

	)
	FCRoot (
	jadeMethodSources
createAccount
{
createAccount(id : String; district : Integer; frequency : String; date : Date) : FCAccount;

vars
	account : FCAccount;
begin
	account := create FCAccount(id, district, frequency, date, self);
	return account;
end;

}

createClient
{
createClient();

vars

begin

end;

}

	)
	JadeScript (
	jadeMethodSources
loadData
{
loadData();

vars
	dataLoader : DataLoader;
	fileFolder : FileFolder;
	dirPath    : String;

begin
	// Ask for the directory containing the initial data files
	create fileFolder transient;
	// dirPath := fileFolder.browseForFolder("Select data file directory", app.dbPath);
	dirPath := "D:\Data Sets\banking-demo-data\new";
	if dirPath <> null then
		// Create our data loader and initialize the database
		create dataLoader transient;
		dataLoader.loadData(dirPath);
	endif;

epilog
	delete dataLoader; // does nothing if dataLoader is null
	delete fileFolder; // does nothing if fileFolder is null
end;

}

purgeData
{
purgeData();

vars

begin
	beginTransaction;
	delete FCRoot.firstInstance;
	commitTransaction;

end;

}

	)
