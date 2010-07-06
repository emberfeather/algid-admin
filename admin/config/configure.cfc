<cfcomponent extends="algid.inc.resource.plugin.configure" output="false">
	<cffunction name="inAdmin" access="public" returntype="boolean" output="false">
		<cfargument name="theApplication" type="struct" required="true" />
		<cfargument name="targetPage" type="string" required="true" />
		
		<cfset var path = '' />
		
		<!--- Get the path to the base --->
		<cfset path = arguments.theApplication.managers.singleton.getApplication().getPath()
			& arguments.theApplication.managers.plugin.getAdmin().getPath() />
		
		<!--- Only pages in the root of the path qualify --->
		<cfreturn reFind('^' & path & '[a-zA-Z0-9-\.]*.cfm$', arguments.targetPage) GT 0 />
	</cffunction>
	
	<cffunction name="onApplicationStart" access="public" returntype="void" output="false">
		<cfargument name="theApplication" type="struct" required="true" />
		
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
		<cfset navigation = arguments.theApplication.factories.transient.getNavigationForAdmin(arguments.theApplication.managers.singleton.getI18N()) />
		
		<!--- Update the plugins and setup the transient and singleton information --->
		<cfloop array="#arguments.theApplication.managers.singleton.getApplication().getPrecedence()#" index="i">
			<cfset plugin = arguments.theApplication.managers.plugin.get(i) />
			
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
		
		<cfset arguments.theApplication.managers.singleton.setAdminNavigation(navigation) />
	</cffunction>
	
	<cffunction name="onSessionStart" access="public" returntype="void" output="false">
		<cfargument name="theApplication" type="struct" required="true" />
		<cfargument name="theSession" type="struct" required="true" />
		
		<cfset var filter = '' />
		<cfset var options = '' />
		
		<!--- Set the number per page --->
		<cfif structKeyExists(cookie, 'numPerPage')>
			<cfset session.numPerPage = cookie.numPerPage />
		<cfelse>
			<cfset session.numPerPage = 25 />
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
		
		<cfset arguments.theSession.managers.singleton.setDatagridFilterForAdmin( filter ) />
	</cffunction>
<cfscript>
	/* required theApplication */
	/* required theSession */
	/* required theRequest */
	/* required targetPage */
	public void function onRequestStart(struct theApplication, struct theSession, struct theRequest, string targetPage) {
		var app = '';
		var plugin = '';
		var temp = '';
		var theUrl = '';
		
		// Only do the following if in the admin area
		if (inAdmin( arguments.theApplication, arguments.targetPage )) {
			// Create a profiler object
			temp = arguments.theApplication.factories.transient.getProfiler(not arguments.theApplication.managers.singleton.getApplication().isProduction());
			
			arguments.theRequest.managers.singleton.setProfiler( temp );
			
			// Default base
			if ( !structKeyExists(url, '_base') ) {
				url['_base'] = '/index';
			}
			
			// Create the URL object for all the admin requests
			app = arguments.theApplication.managers.singleton.getApplication();
			plugin = arguments.theApplication.managers.plugin.getAdmin();
			
			theUrl = arguments.theApplication.factories.transient.getUrlForAdmin(arguments.theUrl, { start = app.getPath() & plugin.getPath() & '?' });
			
			arguments.theRequest.managers.singleton.setUrl( theUrl );
			
			// Check for a valid user or send to the login page
			if ( app.hasPlugin('user') and (not arguments.theSession.managers.singleton.hasUser() or arguments.theSession.managers.singleton.getUser().getUserID() eq '') and theURL.search('_base') neq '/account/login') {
				// Store the original page requested
				transport.theSession.redirect = theURL.get( false );
				
				// Redirect to the login page
				theURL.setRedirect('_base', '/account/login');
				
				theURL.redirectRedirect();
			}
		}
	}
</cfscript>
</cfcomponent>