<cfset servApp = transport.theApplication.factories.transient.getServAppForAdmin(transport.theApplication.managers.singleton.getApplication().getDSUpdate(), transport) />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cfset theURL.redirect() />
</cfif>

<!--- Show a message if the current environment is not production --->
<cfif transport.theApplication.managers.singleton.getApplication().getEnvironment() neq 'production'>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('This environment is currently configured for <strong>' & transport.theApplication.managers.singleton.getApplication().getEnvironment() & '</strong> use.') />
</cfif>
