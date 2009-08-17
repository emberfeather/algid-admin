<cfsilent>
	<cfset profiler = application.managers.transient.getProfiler(application.settings.environment NEQ 'production') />
	
	<cfset profiler.start('startup') />
	
	<!--- Retrieve the admin navigation object --->
	<cfset navigation = application.managers.singleton.getAdminNavigation() />
	
	<!--- Create URL object --->
	<cfset theURL = application.managers.transient.getURL(CGI.QUERY_STRING) />
	
	<!--- Create template object --->
	<cfset options = {
			scripts = [
				'https://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'
			]
		} />
	
	<cfset template = application.managers.transient.getTemplate(navigation, theURL, SESSION.locale, options) />
	
	<!--- Include minified files for production --->
	<cfif application.settings.environment EQ 'production'>
		<cfset midfix = '-min' />
	<cfelse>
		<cfset midfix = '' />
	</cfif>
	
	<!--- Add the scripts and styles --->
	<cfset template.addScripts('../cf-compendium/script/form#midfix#.js', '../cf-compendium/script/list#midfix#.js', '../cf-compendium/script/datagrid#midfix#.js', '../plugins/admin/script/admin#midfix#.js') />
	<cfset template.addStyles('../plugins/admin/style/960/reset#midfix#.css', '../plugins/admin/style/960/960#midfix#.css"', '../cf-compendium/styles#midfix#.css', '../cf-compendium/form#midfix#.css', '../cf-compendium/list#midfix#.css', '../cf-compendium/datagrid#midfix#.css', '../plugins/admin/style/960/text#midfix#.css', '../plugins/admin/style/960/layout#midfix#.css', '../plugins/admin/style/960/nav#midfix#.css') />
	
	<cfset profiler.stop('startup') />
	
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
	
	<cfset profiler.start('content') />
	
	<!--- TODO Add in caching --->
	<cfsavecontent variable="content">
		<cfinclude template="#template.getContentPath('cont')#" />
	</cfsavecontent>
	
	<cfset template.setContent(content) />
	
	<cfset profiler.stop('content') />
	
	<cfset profiler.start('template') />
</cfsilent>

<cfinclude template="/plugins/admin/extend/admin/theme/default/index.cfm" />

<cfset profiler.stop('template') />