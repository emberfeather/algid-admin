<cfcomponent extends="algid.inc.resource.base.event" output="false">
	<cffunction name="onSearch" access="public" returntype="void" output="false">
		<cfargument name="transport" type="struct" required="true" />
		<cfargument name="currUser" type="component" required="true" />
		<cfargument name="results" type="component" required="true" />
		<cfargument name="term" type="string" required="true" />
		
		<cfset var admin = '' />
		<cfset var app = '' />
		<cfset var i = 0 />
		<cfset var i18n = arguments.transport.theApplication.managers.singleton.getI18N() />
		<cfset var locale = arguments.transport.theSession.managers.singleton.getSession().getLocale() />
		<cfset var navigation = '' />
		<cfset var result = '' />
		<cfset var results = '' />
		<cfset var theURL = '' />
		
		<cfset app = arguments.transport.theApplication.managers.singleton.getApplication() />
		<cfset admin = arguments.transport.theApplication.managers.plugin.getAdmin() />
		<cfset theUrl = arguments.transport.theApplication.factories.transient.getUrlForAdmin('', { start = app.getPath() & admin.getPath() & '?' } ) />
		
		<!--- Retrieve the navigation query --->
		<cfset navigation = transport.theApplication.managers.singleton.getAdminNavigation().getNavigation() />
		
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
			
			<cfset result = arguments.transport.theApplication.factories.transient.getModSearchResultForAdmin( i18n, locale ) />
			
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
			
			<cfset result = arguments.transport.theApplication.factories.transient.getModSearchResultForAdmin( i18n, locale ) />
			
			<cfset result.setTitle(results['path']) />
			<cfset result.setCategory('Navigation Paths') />
			<cfset result.setDescription(results['description']) />
			<cfset result.setLink(theUrl.getSearch(false)) />
			
			<cfset arguments.results.addResults(result) />
		</cfloop>
	</cffunction>
</cfcomponent>