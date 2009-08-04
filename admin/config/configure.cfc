<cfcomponent extends="cf-compendium.inc.resource.application.configure" output="false">
	<cffunction name="configure" access="public" returntype="void" output="false">
		<cfargument name="newApplication" type="struct" required="true" />
		
		<cfset var baseDirectory = '' />
		<cfset var files = '' />
		<cfset var i18n = '' />
		<cfset var navigation = '' />
		
		<!--- Get the i18n object --->
		<cfset i18n = arguments.newApplication.managers.singleton.getI18N() />
		
		<!--- Create the admin navigation singleton --->
		<cfset navigation = createObject('component', 'cf-compendium.inc.resource.structure.navigationFile').init(i18n) />
		
		<cfloop array="#arguments.newApplication.plugins#" index="i">
			<cfset baseDirectory = variables.appBaseDirectory & 'plugins/' & i.key & '/extend/admin/' />
			
			<!--- Search for admin directory in the plugin extension point --->
			<cfif directoryExists(baseDirectory)>
				<cfdirectory action="list" directory="#baseDirectory#navigation/" name="files" filter="*.json.cfm|*.xml.cfm" />
				
				<cfloop query="files">
					<!--- Apply Navigation Masks --->
					<cfset navigation.applyMask( files.directory & '/' & files.name ) />
				</cfloop>
			</cfif>
		</cfloop>
		
		<cfset arguments.newApplication.managers.singleton.setAdminNavigation(navigation) />
	</cffunction>
</cfcomponent>