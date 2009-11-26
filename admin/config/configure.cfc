<cfcomponent extends="algid.inc.resource.plugin.configure" output="false">
	<cffunction name="onApplicationStart" access="public" returntype="void" output="false">
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
	
	<cffunction name="onSessionStart" access="public" returntype="void" output="false">
		<cfargument name="theApplication" type="struct" required="true" />
		<cfargument name="newSession" type="struct" required="true" />
		
		<cfset var filter = '' />
		<cfset var options = '' />
		
		<!--- Set the number per page --->
		<cfif structKeyExists(cookie, 'numPerPage')>
			<cfset SESSION.numPerPage = cookie.numPerPage />
		<cfelse>
			<cfset SESSION.numPerPage = 25 />
		</cfif>
		
		<cfset filter = arguments.theApplication.factories.transient.getFilter(arguments.theApplication.managers.singleton.getI18N()) />
		
		<!--- Add the resource bundle for the view --->
		<cfset filter.addBundle('plugins/admin/i18n/', 'admin') />
		
		<!--- Number Per Page --->
		<cfset options = arguments.theApplication.factories.transient.getOptions() />
		
		<cfset options.addOption(25, 25) />
		<cfset options.addOption(50, 50) />
		<cfset options.addOption(75, 75) />
		<cfset options.addOption(100, 100) />
		<cfset options.addOption(250, 250) />
		
		<cfset filter.addFilter('numPerPage', options) />
		
		<cfset arguments.newSession.managers.singleton.setAdminDatagridFilter( filter ) />
	</cffunction>
</cfcomponent>