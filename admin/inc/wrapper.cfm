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
	
	<!--- Retrieve the admin objects --->
	<cfset i18n = transport.theApplication.managers.singleton.getI18N() />
	<cfset locale = transport.theSession.managers.singleton.getSession().getLocale() />
	<cfset modelSerial = transport.theApplication.factories.transient.getModelSerial(transport) />
	<cfset theURL = transport.theRequest.managers.singleton.getURL() />
	<cfset navigation = transport.theApplication.managers.singleton.getAdminNavigation() />
	<cfset viewMaster = transport.theApplication.managers.singleton.getViewMasterForAdmin() />
	
	<!--- Create and store the services manager --->
	<cfset services = transport.theApplication.factories.transient.getManagerService(transport) />
	<cfset transport.theRequest.managers.singleton.setManagerService(services) />
	
	<!--- Create and store the views manager --->
	<cfset views = transport.theApplication.factories.transient.getManagerView(transport) />
	<cfset transport.theRequest.managers.singleton.setManagerView(views) />
	
	<!--- Create and store the model manager --->
	<cfset models = transport.theApplication.factories.transient.getManagerModel(transport, i18n, locale) />
	<cfset transport.theRequest.managers.singleton.setManagerModel(models) />
	
	<!--- Check for a change to the number of records per page --->
	<cfif theURL.searchID('numPerPage')>
		<cfset session.numPerPage = theURL.searchID('numPerPage') />
		
		<cfcookie name="numPerPage" value="#session.numPerPage#" />
		
		<cfset theURL.remove('numPerPage') />
	</cfif>
	
	<cfset profiler.stop('startup') />
	
	<cfset profiler.start('template') />
	
	<!--- Create template object --->
	<cfset template = transport.theApplication.factories.transient.getTemplateForAdmin(transport.theCGI.server_name, navigation, theURL, i18n, transport.theSession.managers.singleton.getSession().getLocale()) />
	
	<!--- Add the main jquery scripts with fallbacks --->
	<cfset template.addScript('https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js', { condition = '!window.jQuery', script = '/algid/script/jquery-min.js' }) />
	<cfset template.addScript('https://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js', { condition = '!window.jQuery.ui', script = '/algid/script/jquery-ui-min.js' }) />
	
	<!--- Include minified files for production --->
	<cfif transport.theApplication.managers.singleton.getApplication().isProduction()>
		<cfset template.addScripts('/cf-compendium/script/jquery.cf-compendium-min.js') />
		<cfset template.addScripts('/algid/script/markitup/jquery.markitup-min.js') />
		<cfset template.addScripts('/algid/script/jquery.algid-min.js') />
		<cfset template.addStyles('/cf-compendium/style/cf-compendium-min.css') />
		<cfset template.addStyles('/algid/style/markItUp/style-min.css') />
		<cfset template.addStyles('/algid/style/algid-min.css') />
	<cfelse>
		<cfset template.addScripts('/cf-compendium/script/jquery.base.js', '/cf-compendium/script/jquery.form.js', '/cf-compendium/script/jquery.list.js', '/cf-compendium/script/jquery.datagrid.js', '/cf-compendium/script/jquery.timeago.js', '/cf-compendium/script/jquery.cookie.js') />
		<cfset template.addScripts('/algid/script/markitup/jquery.markitup.js') />
		<cfset template.addScripts('/algid/script/jquery.base.js', '/algid/script/jquery.richtext.js') />
		<cfset template.addStyles('/cf-compendium/style/base.css', '/cf-compendium/style/form.css', '/cf-compendium/style/list.css', '/cf-compendium/style/datagrid.css', '/cf-compendium/style/detail.css', '/cf-compendium/style/code.css') />
		<cfset template.addStyles('/algid/style/markItUp/style.css') />
		<cfset template.addStyles('/algid/style/base.css', '/algid/style/richtext.css') />
	</cfif>
	
	<cfset template.setIsSimple(transport.theApplication.managers.singleton.getApplication().hasPlugin('user') and not transport.theSession.managers.singleton.getUser().isLoggedIn()) />
	
	<cfset profiler.stop('template') />
	
	<cfset profiler.start('process') />
	
	<cfset isBlocked = false />
	
	<!--- Capture any validation errors --->
	<cftry>
		<!--- Include Processing --->
		<cfinclude template="#template.getContentPath('proc')#" />
		
		<cfcatch type="validation">
			<!--- Add the errors that happened from validations to errors --->
			<cfset session.managers.singleton.getError().addMessages(argumentCollection = listToArray(cfcatch.message, '|')) />
		</cfcatch>
		
		<cfcatch type="forbidden">
			<!--- Add the errors that happened from validations to errors --->
			<cfset session.managers.singleton.getError().addMessages(argumentCollection = listToArray(cfcatch.message, '|')) />
			
			<cfset isBlocked = true />
		</cfcatch>
	</cftry>
	
	<cfset profiler.stop('process') />
	
	<cfset profiler.start('side') />
	
	<cfsavecontent variable="side">
		<cfif not isBlocked>
			<cfinclude template="#template.getContentPath('side')#" />
		</cfif>
	</cfsavecontent>
	
	<cfset template.setSide(side) />
	
	<cfset profiler.stop('side') />
	
	<cfset profiler.start('content') />
	
	<cfsavecontent variable="content">
		<cfif not isBlocked>
			<cfinclude template="#template.getContentPath('cont')#" />
		</cfif>
	</cfsavecontent>
	
	<cfset template.setContent(content) />
	
	<cfset profiler.stop('content') />
	
	<cfset profiler.start('theme') />
</cfsilent>

<!--- Include the theme --->
<cfinclude template="/plugins/#transport.theApplication.managers.plugin.getAdmin().getTheme()#/template/#template.getTemplate()#.cfm" />

<cfset profiler.stop('theme') />
