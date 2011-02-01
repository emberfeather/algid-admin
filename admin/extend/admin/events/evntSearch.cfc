<cfcomponent extends="algid.inc.resource.base.event" output="false">
	<cffunction name="onSearch" access="public" returntype="void" output="false">
		<cfargument name="transport" type="struct" required="true" />
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="results" type="component" required="true" />
		<cfargument name="term" type="string" required="true" />
		
		<cfset var app = '' />
		<cfset var i = 0 />
		<cfset var i18n = arguments.transport.theApplication.managers.singleton.getI18N() />
		<cfset var locale = arguments.transport.theSession.managers.singleton.getSession().getLocale() />
		<cfset var models = arguments.transport.theRequest.managers.singleton.getManagerModel() />
		<cfset var navigation = '' />
		<cfset var options = '' />
		<cfset var plugin = '' />
		<cfset var result = '' />
		<cfset var results = '' />
		<cfset var rewrite = '' />
		<cfset var theURL = '' />
		
		<cfset app = arguments.transport.theApplication.managers.singleton.getApplication() />
		<cfset plugin = arguments.transport.theApplication.managers.plugin.getAdmin() />
		
		<cfset options = { start = app.getPath() & plugin.getPath() } />
		
		<cfset rewrite = plugin.getRewrite() />
		
		<cfif rewrite.isEnabled>
			<cfset options.rewriteBase = rewrite.base />
			
			<cfset theUrl = arguments.transport.theApplication.factories.transient.getUrlRewrite(arguments.transport.theUrl, options) />
		<cfelse>
			<cfset theUrl = arguments.transport.theApplication.factories.transient.getUrl(arguments.transport.theUrl, options) />
		</cfif>
		
		<!--- Retrieve the navigation query --->
		<cfset navigation = arguments.transport.theApplication.managers.singleton.getAdminNavigation().getNavigation() />
		
		<!--- Use the search term to find the matches --->
		<cfquery name="results" dbtype="query">
			SELECT title, path, description
			FROM navigation
			WHERE locale = <cfqueryparam cfsqltype="cf_sql_varchar" value="#locale#" />
				AND (
					title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%" />
					OR description LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%" />
				)
		</cfquery>
		
		<!--- Add the found results to the main search results --->
		<cfloop query="results">
			<cfset theUrl.setSearch('_base', results.path) />
			
			<cfset result = models.get('admin', 'searchResult') />
			
			<cfset result.setTitle(results['title']) />
			<cfset result.setCategory('Navigation') />
			<cfset result.setDescription(results['description']) />
			<cfset result.setLink(theUrl.getSearch(false)) />
			
			<cfset arguments.results.addResults(result) />
		</cfloop>
		
		<!--- Use the search term to find the matches --->
		<cfquery name="results" dbtype="query">
			SELECT title, path, description
			FROM navigation
			WHERE locale = <cfqueryparam cfsqltype="cf_sql_varchar" value="#locale#" />
				AND path LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.term#%" />
				AND navTitle <> <cfqueryparam cfsqltype="cf_sql_varchar" value="" />
		</cfquery>
		
		<!--- Add the found results to the main search results --->
		<cfloop query="results">
			<cfset theUrl.setSearch('_base', results.path) />
			
			<cfset result = models.get('admin', 'searchResult') />
			
			<cfset result.setTitle(results['path']) />
			<cfset result.setCategory('Navigation Paths') />
			<cfset result.setDescription(results['description']) />
			<cfset result.setLink(theUrl.getSearch(false)) />
			
			<cfset arguments.results.addResults(result) />
		</cfloop>
	</cffunction>
</cfcomponent>
