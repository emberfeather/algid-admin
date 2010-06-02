<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="search" access="public" returntype="string" output="false">
		<cfargument name="results" type="component" required="true" />
		
		<cfif not arguments.results.lengthResults()>
			<!--- TODO Use i18n --->
			<cfreturn 'No results found.' />
		</cfif>
		
		<cfreturn arguments.results.toHTML() />
	</cffunction>
</cfcomponent>
