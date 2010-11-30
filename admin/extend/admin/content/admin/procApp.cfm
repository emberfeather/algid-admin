<!--- Show a message if the current environment is not production --->
<cfif not transport.theApplication.managers.singleton.getApplication().isProduction()>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('This environment is currently configured for <strong>' & transport.theApplication.managers.singleton.getApplication().getEnvironment() & '</strong> use.') />
</cfif>
