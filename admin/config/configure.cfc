<cfcomponent extends="algid.inc.resource.plugin.configure" output="false">
	<cffunction name="configureApplication" access="public" returntype="void" output="false">
		<cfargument name="newApplication" type="struct" required="true" />
		
		<cfset var bundleName = '' />
		<cfset var contentDirectory = '' />
		<cfset var files = '' />
		<cfset var i = '' />
		<cfset var i18n = '' />
		<cfset var i18nDirectory = '' />
		<cfset var navDirectory = '' />
		<cfset var navigation = '' />
		<cfset var plugin = '' />
		<cfset var search = '' />
		
		<!--- Create the admin navigation singleton --->
		<cfset navigation = arguments.newApplication.factories.transient.getNavigationForAdmin(arguments.newApplication.managers.singleton.getI18N()) />
		
		<!--- Update the plugins and setup the transient and singleton information --->
		<cfloop array="#arguments.newApplication.app.getPrecedence()#" index="i">
			<cfset plugin = arguments.newApplication.managers.plugins.get(i) />
			
			<cfset contentDirectory = '/plugins/' & i & '/extend/admin/content/' />
			<cfset i18nDirectory = '/plugins/' & i & '/i18n/extend/admin/navigation/' />
			<cfset navDirectory = variables.appBaseDirectory & 'plugins/' & i & '/extend/admin/navigation/' />
			
			<!--- Search for admin directory in the plugin extension point --->
			<cfif directoryExists(navDirectory)>
				<cfdirectory action="list" directory="#navDirectory#" name="files" filter="*.json.cfm|*.xml.cfm" />
				
				<cfloop query="files">
					<!--- Get the bundle name from the filename --->
					<cfset search = reFind('^(.*)\.(json|xml)\.cfm$', files.name, 1, true) />
					<cfset bundleName = mid(files.name, search.pos[2], search.len[2]) />
					
					<!--- Apply Navigation Masks --->
					<cfset navigation.applyMask( files.directory & '/' & files.name, contentDirectory, i18nDirectory, bundleName, arrayToList(plugin.getI18n().locales) ) />
				</cfloop>
			</cfif>
		</cfloop>
		
		<!--- Verify the content files exist --->
		<cfset navigation.validate('proc,cont,side') />
		
		<cfset arguments.newApplication.managers.singleton.setAdminNavigation(navigation) />
	</cffunction>
</cfcomponent>