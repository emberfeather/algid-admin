<cfif transport.theApplication.managers.singleton.getApplication().isProduction()>
	<p>
		This action is only available to non-production systems.
	</p>
<cfelse>
	<p>
		<strong>WARNING!</strong> This page is designed for development environments to reset 
		the environment to a fresh state.
	</p>
	
	<p>
		The reset is done by removing all version information causing the install/upgrade
		script to run on reinitialization.
	</p>
	
	<cfset theUrl.setReset('doReset', 'true') />
	
	<p>
		<cfoutput><a href="#theUrl.getReset()#">Permanently Reset Environment</a></cfoutput>
	</p>
</cfif>
