<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="maintenance" access="public" returntype="string" output="false">
		<cfset local.theUrl = variables.transport.theRequest.managers.singleton.getUrl() />
		
		<cfset local.theUrl.setMaintenance('maintenance', 'true') />
		
		<cfreturn '<a href="' & local.theUrl.getMaintenance() & '">Switch temporarily to maintenance mode</a>' />
	</cffunction>
</cfcomponent>
