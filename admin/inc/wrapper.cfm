<cfsilent>
	<cfset profiler = application.factories.transient.getProfiler(application.app.getEnvironment() NEQ 'production') />
	
	<cfset profiler.start('startup') />
	
	<!--- Setup a transport object --->
	<cfset transport = {
			theApplication = application,
			theSession = SESSION,
			theRequest = {
				managers = {
					singleton = application.factories.transient.getManagerSingleton(application.app.getEnvironment() NEQ 'production')
				},
				factories = {
					transient = application.factories.transient.getFactoryTransient(application.app.getEnvironment() NEQ 'production')
				}
			},
			locale = SESSION.locale
		} />
	
	<!--- Retrieve the admin objects --->
	<cfset i18n = transport.theApplication.managers.singleton.getI18N() />
	<cfset navigation = transport.theApplication.managers.singleton.getAdminNavigation() />
	<cfset viewMaster = transport.theApplication.managers.singleton.getViewMasterForAdmin() />
	
	<!--- Create URL object --->
	<cfset theURL = transport.theApplication.factories.transient.getURLForAdmin(URL) />
	
	<!--- Store the request singletons --->
	<cfset transport.theRequest.managers.singleton.setProfiler(profiler) />
	<cfset transport.theRequest.managers.singleton.setUrl(theURL) />
	
	<!--- Check for a change to the number of records per page --->
	<cfif theURL.searchID('numPerPage')>
		<cfset SESSION.numPerPage = theURL.searchID('numPerPage') />
		
		<cfcookie name="numPerPage" value="#SESSION.numPerPage#" />
		
		<cfset theURL.remove('numPerPage') />
	</cfif>
	
	<!--- Check for a valid user or send to the login page --->
	<cfif (NOT transport.theSession.managers.singleton.hasUser() OR transport.theSession.managers.singleton.getUser().getUserID() EQ 0) AND theURL.search('_base') NEQ '.account.login'>
		<!--- Store the original page requested --->
		<cfset SESSION.redirect = theURL.get( false ) />
		
		<!--- Redirect to the login page --->
		<cfset theURL.setRedirect('_base', '.account.login') />
		<cflocation url="#theURL.getRedirect(false)#" addtoken="false" />
	</cfif>
	
	<cfset profiler.stop('startup') />
	
	<cfset profiler.start('template') />
	
	<!--- Create template object --->
	<cfset options = {
			scripts = [
				'https://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'
			]
		} />
	
	<cfset template = transport.theApplication.factories.transient.getTemplateForAdmin(navigation, theURL, SESSION.locale, options) />
	
	<!--- Include minified files for production --->
	<cfif application.app.getEnvironment() EQ 'production'>
		<cfset midfix = '-min' />
	<cfelse>
		<cfset midfix = '' />
	</cfif>
	
	<!--- Add the scripts and styles --->
	<cfset template.addScripts('../cf-compendium/script/form#midfix#.js', '../cf-compendium/script/list#midfix#.js', '../cf-compendium/script/datagrid#midfix#.js', '../plugins/admin/script/admin#midfix#.js') />
	<cfset template.addStyles('../cf-compendium/style/styles#midfix#.css', '../cf-compendium/style/form#midfix#.css', '../cf-compendium/style/list#midfix#.css', '../cf-compendium/style/datagrid#midfix#.css') />
	
	<cfset profiler.stop('template') />
	
	<cfset profiler.start('process') />
	
	<!--- Capture any validation errors --->
	<cftry>
		<!--- Include Processing --->
		<cfinclude template="#template.getContentPath('proc')#" />
		
		<cfcatch type="validation">
			<!--- Add the errors that happened from validations to errors --->
			<cfloop list="#cfcatch.message#" index="i" delimiters="|">
				<cfset SESSION.notification.error.addMessages(i) />
			</cfloop>
		</cfcatch>
	</cftry>
	
	<cfset profiler.stop('process') />
	
	<cfset profiler.start('stats') />
	
	<!--- Retrieve and generate the User Stats --->
	<cfset userStats = SESSION.managers.singleton.getUserStat() />
	
	<cfset viewUserStats = application.factories.transient.getViewUserStatForUser( transport ) />
	
	<cfset template.setStats(viewUserStats.stats(SESSION.managers.singleton.getUser())) />
	
	<cfset profiler.stop('stats') />
	
	<cfset profiler.start('side') />
	
	<!--- TODO Add in caching --->
	<cfsavecontent variable="side">
		<cfinclude template="#template.getContentPath('side')#" />
	</cfsavecontent>
	
	<cfset template.setSide(side) />
	
	<cfset profiler.stop('side') />
	
	<cfset profiler.start('content') />
	
	<!--- TODO Add in caching --->
	<cfsavecontent variable="content">
		<cfinclude template="#template.getContentPath('cont')#" />
	</cfsavecontent>
	
	<cfset template.setContent(content) />
	
	<cfset profiler.stop('content') />
	
	<cfset profiler.start('theme') />
</cfsilent>

<cfinclude template="/plugins/admin/extend/admin/theme/admin/index.cfm" />

<cfset profiler.stop('theme') />