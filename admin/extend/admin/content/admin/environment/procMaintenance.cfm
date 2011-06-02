<cfset servEnvironment = services.get('admin', 'environment') />

<cfif theUrl.searchBoolean('maintenance')>
	<!--- Process the form submission --->
	<cfset servEnvironment.setEnvironment( 'maintenance' ) />
	
	<!--- Redirect --->
	<cfset theURL.setRedirect('_base', '/admin/environment') />
	<cfset theURL.redirectRedirect() />
</cfif>
