<cfset viewEnvironment = views.get('admin', 'environment') />

<cfoutput>
	#viewEnvironment.maintenance()#
</cfoutput>
