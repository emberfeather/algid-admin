<cfcomponent extends="algid.inc.resource.application.configure" output="false">
	<cffunction name="configure" access="public" returntype="void" output="false">
		<cfargument name="newApplication" type="struct" required="true" />
		
		<cfset var bundleName = '' />
		<cfset var contentDirectory = '' />
		<cfset var files = '' />
		<cfset var i = '' />
		<cfset var i18n = '' />
		<cfset var i18nDirectory = '' />
		<cfset var navDirectory = '' />
		<cfset var navigation = '' />
		<cfset var search = '' />
		
		<!--- Get the i18n object --->
		<cfset i18n = arguments.newApplication.managers.singleton.getI18N() />
		
		<!--- Create the admin navigation singleton --->
		<cfset navigation = createObject('component', 'cf-compendium.inc.resource.structure.navigationFile').init(i18n) />
		
		<cfloop array="#arguments.newApplication.plugins#" index="i">
			<cfset contentDirectory =  '/plugins/' & i.key & '/extend/admin/content/' />
			<cfset i18nDirectory =  '/plugins/' & i.key & '/i18n/extend/admin/navigation/' />
			<cfset navDirectory =  variables.appBaseDirectory & 'plugins/' & i.key & '/extend/admin/navigation/' />
			
			<!--- Search for admin directory in the plugin extension point --->
			<cfif directoryExists(navDirectory)>
				<cfdirectory action="list" directory="#navDirectory#" name="files" filter="*.json.cfm|*.xml.cfm" />
				
				<cfloop query="files">
					<!--- Get the bundle name from the filename --->
					<cfset search = reFind('^(.*).(json|xml).cfm$', files.name, 1, true) />
					<cfset bundleName = mid(files.name, search.pos[2], search.len[2]) />
					
					<!--- Apply Navigation Masks --->
					<cfset navigation.applyMask( files.directory & '/' & files.name, contentDirectory, i18nDirectory, bundleName, arrayToList(i.i18n.locales) ) />
				</cfloop>
			</cfif>
		</cfloop>
		
		<!--- Verify the content files exist --->
		<cfset navigation.validate('proc,cont') />
		
		<cfset arguments.newApplication.managers.singleton.setAdminNavigation(navigation) />
	</cffunction>
</cfcomponent>