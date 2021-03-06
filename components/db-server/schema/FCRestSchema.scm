/* JADE COMMAND FILE NAME C:\development\Devops\jade-data-fabric\schema\FCRestSchema.jcf */
jadeVersionNumber "20.0.02";
schemaDefinition
FCRestSchema subschemaOf FCModelSchema completeDefinition, patchVersioningEnabled = false;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.606;
importedPackageDefinitions
constantDefinitions
localeDefinitions
	5129 "English (New Zealand)" schemaDefaultLocale;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.559;
libraryDefinitions
typeHeaders
	FCRestSchema subclassOf FCModelSchema transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, number = 2133;
	GFCRestSchema subclassOf GFCModelSchema transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, number = 2152;
	FinRestService subclassOf JadeRestService transient, transientAllowed, subclassTransientAllowed, number = 2154;
	SFCRestSchema subclassOf SFCModelSchema transient, sharedTransientAllowed, transientAllowed, subclassSharedTransientAllowed, subclassTransientAllowed, number = 2153;
 
membershipDefinitions
 
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
	)
	FCRestSchema completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.590;
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
	GFCRestSchema completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.590;
 
	jadeMethodDefinitions
		initialize() updating, number = 1001;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:31:48.932;
	)
	JadeRestService completeDefinition
	(
		setModifiedTimeStamp "cnwta3" "99.0.00" 2020:07:19:19:05:33.286;
	)
	FinRestService completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:16:42.771;
 
	jadeMethodDefinitions
		getAccount(id: String): FCAccount number = 1003;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:08:23:06.893;
		getAllAccounts(): AccountByIdDict number = 1001;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:34:08.003;
		getAllClients(): ClientByIdDict number = 1002;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:08:20:31.801;
		getClient(id: String): FCClient number = 1004;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:29:08:24:11.198;
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
	SFCRestSchema completeDefinition
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.606;
	)
 
inverseDefinitions
databaseDefinitions
FCRestSchemaDb
	(
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.606;
	databaseFileDefinitions
		"fcrestschema" number = 52;
		setModifiedTimeStamp "cnwhm5" "20.0.02" 2021:09:28:23:15:59.606;
	defaultFileDefinition "fcrestschema";
	classMapDefinitions
		SFCRestSchema in "_environ";
		FCRestSchema in "_usergui";
		GFCRestSchema in "fcrestschema";
		FinRestService in "fcrestschema";
	)
schemaViewDefinitions
exportedPackageDefinitions
typeSources
	GFCRestSchema (
	jadeMethodSources
initialize
{
initialize() updating;

vars

begin
	inheritMethod();
end;

}

	)
	FinRestService (
	jadeMethodSources
getAccount
{
getAccount(id : String) : FCAccount;

vars
	accounts : AccountByIdDict;
begin
	accounts := app.myRoot.allAccounts;
	if not accounts.includesKey(id) then
		return null;
	endif;
	
	return accounts[id].cloneSelf(true);
end;

}

getAllAccounts
{
getAllAccounts() : AccountByIdDict;

vars
	accounts : AccountByIdDict;
	account : FCAccount;
	clone : FCAccount;
	root : FCRoot;
begin
	root := app.myRoot;
	create accounts transient;
	foreach account in root.allAccounts do
		clone := account.cloneSelf(true);
		accounts.add(clone);
	endforeach;

	return accounts.cloneSelf(true);
end;

}

getAllClients
{
getAllClients() : ClientByIdDict;

vars
	clients : ClientByIdDict;
	client : FCClient;
	clone : FCClient;
	root : FCRoot;
begin
	root := app.myRoot;
	create clients transient;
	foreach client in root.allClients do
		clone := client.cloneSelf(true);
		clients.add(clone);
	endforeach;

	return clients.cloneSelf(true);
end;

}

getClient
{
getClient(id : String) : FCClient;

vars
	clients : ClientByIdDict;
begin
	clients := app.myRoot.allClients;
	if not clients.includesKey(id) then
		return null;
	endif;
	
	return clients[id].cloneSelf(true);
end;

}

	)
