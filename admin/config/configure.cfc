<cfcomponent extends="cf-compendium.inc.resource.application.configure" output="false">
	<cffunction name="configure" access="public" returntype="void" output="false">
		<cfargument name="newApplication" type="struct" required="true" />
		
		<cfset var baseDirectory = '' />
		<cfset var files = '' />
		<cfset var temp = '' />
		
		<!--- Create the admin navigation singleton --->
		<cfset temp = createObject('component', 'cf-compendium.inc.resource.structure.navigationJSON').init() />
		
		<cfloop array="#arguments.newApplication.plugins#" index="i">
			<cfset baseDirectory = variables.appBaseDirectory & 'plugins/' & i.key & '/extend/admin/' />
			
			<!--- Search for admin directory in the plugin extension point --->
			<cfif directoryExists(baseDirectory)>
				<cfdirectory action="list" directory="#baseDirectory#navigation/" name="files" filter="*.json.cfm" />
				
				<cfloop query="files">
					<!--- Apply Navigation Masks --->
					<!--- TODO Get the masks working correctly --->
					<!---
					<cfset temp.applyMask( files.directory & '/' & files.name ) />
					--->
				</cfloop>
			</cfif>
		</cfloop>
		
		<cfset arguments.newApplication.managers.singleton.setAdminNavigation(temp) />
	</cffunction>
</cfcomponent>