<cfsilent>
	<cfset profiler = application.factories.transient.getProfiler(application.settings.environment NEQ 'production') />
	
	<cfset profiler.start('startup') />
	
	<cfset i18n = application.managers.singleton.getI18N() />
	
	<!--- Retrieve the admin navigation object --->
	<cfset navigation = application.managers.singleton.getAdminNavigation() />
	
	<!--- Create URL object --->
	<cfset theURL = application.factories.transient.getURLForAdmin(URL) />
	
	<cfset profiler.stop('startup') />
	
	<cfset profiler.start('template') />
	
	<!--- Create template object --->
	<cfset options = {
			scripts = [
				'https://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'
			]
		} />
	
	<cfset template = application.factories.transient.getTemplateForAdmin(navigation, theURL, SESSION.locale, options) />
	
	<!--- Include minified files for production --->
	<cfif application.settings.environment EQ 'production'>
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
	
	<!--- TODO Add in caching --->
	<cfsavecontent variable="stats">
		<cfinclude template="/plugins/user/extend/admin/content/widgUsers.cfm" />
	</cfsavecontent>
	
	<cfset template.setStats(stats) />
	
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