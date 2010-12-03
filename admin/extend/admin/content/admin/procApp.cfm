<!--- Show a message about the environment mode --->
<cfset transport.theSession.managers.singleton.getMessage().addMessages('This environment is currently configured for <strong>' & transport.theApplication.managers.singleton.getApplication().getEnvironment() & '</strong> use.') />
