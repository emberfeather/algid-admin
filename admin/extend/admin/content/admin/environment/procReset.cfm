<!--- Only on non production systems --->
<cfif not transport.theApplication.managers.singleton.getApplication().isProduction()>
	<!--- Check for confirmation --->
	<cfif theUrl.search('doReset') eq true>
		<!--- Uninstall all the plugins --->
		<!--- Go in reverse order --->
		<cfset plugins = transport.theApplication.managers.singleton.getApplication().getPrecedence() />
		<cfloop from="#arrayLen(plugins)#" to="1" index="i" step="-1">
			<cfset versionFile = '/plugins/#plugins[i]#/config/version.json.cfm' />
			
			<cfif fileExists(versionFile)>
				<cffile action="delete" file="#versionFile#" />
			</cfif>
		</cfloop>
		
		<cfset theUrl.cleanRedirect() />
		
		<cfset theUrl.setRedirect('reinit', 'true') />
		
		<cfset theUrl.redirectRedirect() />
	</cfif>
</cfif>