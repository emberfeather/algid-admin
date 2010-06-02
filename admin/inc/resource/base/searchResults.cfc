<cfcomponent extends="cf-compendium.inc.resource.base.object" output="false">
	<cffunction name="init" access="public" returnType="component" output="false">
		<cfset super.init() />
		
		<cfset set__properties({
				results = []
			}) />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="toHTML" access="public" returntype="string" output="false">
		<cfset var html = '' />
		<cfset var result = '' />
		<cfset var category = '' />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<cfloop array="#this.getResults()#" index="result">
					<cfif category neq result.getCategory()>
						<cfset category = result.getCategory() />
						
						<h3>#category#</h3>
					</cfif>
					
					#result.toHTML()#
				</cfloop>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
</cfcomponent>
