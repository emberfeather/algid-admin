<cfsilent>
	<cfset profiler = request.managers.singleton.getProfiler() />
	
	<cfset profiler.start('startup') />
	
	<!--- Setup a transport object to transport scopes --->
	<cfset transport = {
			theApplication = application,
			theCGI = cgi,
			theCookie = cookie,
			theForm = form,
			theRequest = request,
			theServer = server,
			theSession = session,
			theUrl = url
		} />
	
	<!--- Create the URL object for all the admin requests --->
	<cfset theURL = transport.theApplication.factories.transient.getUrlForAdmin(URL) />
	
	<cfset transport.theRequest.managers.singleton.setUrl( theURL ) />\
	
	<!--- Retrieve the admin objects --->
	<cfset i18n = transport.theApplication.managers.singleton.getI18N() />
	<cfset navigation = transport.theApplication.managers.singleton.getAdminNavigation() />
	<cfset viewMaster = transport.theApplication.managers.singleton.getViewMasterForAdmin() />
	
	<!--- Check for a change to the number of records per page --->
	<cfif theURL.searchID('numPerPage')>
		<cfset session.numPerPage = theURL.searchID('numPerPage') />
		
		<cfcookie name="numPerPage" value="#session.numPerPage#" />
		
		<cfset theURL.remove('numPerPage') />
	</cfif>
	
	<!--- Check for a valid user or send to the login page --->
	<cfif (not transport.theSession.managers.singleton.hasUser() or transport.theSession.managers.singleton.getUser().getUserID() eq 0) and theURL.search('_base') neq '.account.login'>
		<!--- Store the original page requested --->
		<cfset session.redirect = theURL.get( false ) />
		
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
	
	<cfset template = transport.theApplication.factories.transient.getTemplateForAdmin(navigation, theURL, session.locale, options) />
	
	<!--- Include minified files for production --->
	<cfset midfix = (transport.theApplication.app.getEnvironment() eq 'production' ? '-min' : '') />
	
	<!--- Add the scripts and styles --->
	<cfset template.addScripts('../cf-compendium/script/form#midfix#.js', '../cf-compendium/script/list#midfix#.js', '../cf-compendium/script/jquery.datagrid#midfix#.js', '../cf-compendium/script/jquery.timeago#midfix#.js') />
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
				<cfset session.notification.error.addMessages(i) />
			</cfloop>
		</cfcatch>
	</cftry>
	
	<cfset profiler.stop('process') />
	
	<cfset profiler.start('stats') />
	
	<!--- Retrieve and generate the User Stats --->
	<cfset userStats = session.managers.singleton.getUserStat() />
	
	<cfset viewUserStats = transport.theApplication.factories.transient.getViewUserStatForUser( transport ) />
	
	<cfset template.setStats(viewUserStats.stats(session.managers.singleton.getUser())) />
	
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