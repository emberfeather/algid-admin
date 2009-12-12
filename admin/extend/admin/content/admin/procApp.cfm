<cfset servApp = transport.theApplication.factories.transient.getServAppForAdmin(application.app.getDSUpdate(), transport) />

<cfif cgi.request_method eq 'post'>
	<!--- Update the URL and redirect --->
	<cfloop list="#form.fieldnames#" index="field">
		<cfset theURL.set('', field, form[field]) />
	</cfloop>
	
	<cflocation url="#theURL.get('', false)#" addtoken="false" />
</cfif>

<!--- Show a message if the current environment is not production --->
<cfif transport.theApplication.app.getEnvironment() neq 'production'>
	<cfset transport.theSession.managers.singleton.getMessage().addMessages('This environment is currently configured for <strong>' & transport.theApplication.app.getEnvironment() & '</strong> use.') />
</cfif>
