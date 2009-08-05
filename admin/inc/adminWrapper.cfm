<cfsilent>
	<!--- Retrieve the admin navigation object --->
	<cfset navigation = application.managers.singleton.getAdminNavigation() />
	
	<!--- Create URL object --->
	<cfset theURL = application.managers.factory.getURL(CGI.QUERY_STRING) />
	
	<!--- Create template object --->
	<cfset options = {
			scripts = [
				'https://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js'
			]
		} />
	
	<cfset template = application.managers.factory.getTemplate(navigation, theURL, options) />
	
	<!--- Include minified files for production --->
	<cfif application.settings.environment EQ 'production'>
		<cfset midfix = '-min' />
	<cfelse>
		<cfset midfix = '' />
	</cfif>
	
	<!--- Add the scripts and styles --->
	<cfset template.addScripts('../cf-compendium/script/form#midfix#.js', '../cf-compendium/script/list#midfix#.js', '../cf-compendium/script/datagrid#midfix#.js', '../plugins/admin/script/admin#midfix#.js') />
	<cfset template.addStyles('../plugins/admin/style/960/reset#midfix#.css', '../plugins/admin/style/960/960#midfix#.css"', '../cf-compendium/styles#midfix#.css', '../cf-compendium/form#midfix#.css', '../cf-compendium/list#midfix#.css', '../cf-compendium/datagrid#midfix#.css', '../plugins/admin/style/960/text#midfix#.css', '../plugins/admin/style/960/layout#midfix#.css', '../plugins/admin/style/960/nav#midfix#.css') />
	
	<!--- TODO need to make this more dynamic for plugin based navigation --->
	<cfset templateBasePath = '/admin/inc/content/' />
	
	<!--- Capture any validation errors --->
	<!---
	<cftry>
		<!--- Include Processing --->
		<cfinclude template="#template.getPath(templateBasePath, 'proc')#" />
		
		<cfcatch type="validation">
			<!--- Add the errors that happened from validations to errors --->
			<cfloop list="#cfcatch.message#" index="i" delimiters="|">
				<cfset SESSION.notification.error.addMessages(i) />
			</cfloop>
		</cfcatch>
	</cftry>
	--->
	
	<cffile action="read" file="/cf-compendium/inc/resource/structure/markupGuide.cfm" variable="content" />
	
	<cfset template.setContent(content) />
</cfsilent>
<cfinclude template="/plugins/admin/extend/admin/theme/default/index.cfm" />