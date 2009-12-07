<cfcomponent output="false">
	<cffunction name="init" access="public" returnType="component" output="false">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="datagrid" access="public" returntype="string" output="false">
		<cfargument name="transport" type="struct" required="true" />
		<cfargument name="data" type="any" required="true" />
		<cfargument name="view" type="component" required="true" />
		<cfargument name="paginate" type="component" required="true" />
		<cfargument name="filter" type="struct" default="#{}#" />
		<cfargument name="options" type="struct" default="#{}#" />
		
		<cfset var datagridFilter = '' />
		<cfset var html = '' />
		<cfset var theURL = '' />
		
		<cfset datagridFilter = arguments.transport.theSession.managers.singleton.getAdminDatagridFilter() />
		<cfset theURL = arguments.transport.theRequest.managers.singleton.getURL() />
		
		<!--- Set the options for the pagination --->
		<cfset arguments.options.startRow = arguments.paginate.getStartRow() />
		<cfset arguments.options.numPerPage = arguments.paginate.getNumPerPage() />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<div class="float-right">
					#arguments.paginate.toHTML( theURL )#
				</div>
				
				<cfif structKeyExists(arguments.view, 'filterActive')>
					#arguments.view.filterActive( arguments.filter )#
				</cfif>
				
				#arguments.view.datagrid( arguments.data, arguments.options )#
				
				#datagridFilter.toHTML( theURL, { submit = 'update' } )#
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
</cfcomponent>