<cfcomponent extends="cf-compendium.inc.resource.base.base" output="false">
	<cffunction name="init" access="public" returnType="component" output="false">
		<cfargument name="transport" type="struct" required="true" />
		
		<cfset super.init() />
		
		<cfset variables.transport = arguments.transport />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="datagrid" access="public" returntype="string" output="false">
		<cfargument name="data" type="any" required="true" />
		<cfargument name="view" type="component" required="true" />
		<cfargument name="paginate" type="component" required="true" />
		
		<cfset var datagridFilter = '' />
		<cfset var html = '' />
		<cfset var theURL = '' />
		
		<cfset datagridFilter = variables.transport.sessionSingletons.getAdminDatagridFilter() />
		<cfset theURL = variables.transport.requestSingletons.getURL() />
		
		<cfsavecontent variable="html">
			<cfoutput>
				<div class="float-right">
					#arguments.paginate.toHTML( theURL )#
				</div>
				
				<cfif structKeyExists(arguments.view, 'filterActive')>
					#arguments.view.filterActive( filter )#
				</cfif>
				
				#arguments.view.list( arguments.data, {
					startRow = arguments.paginate.getStartRow(),
					numPerPage = arguments.paginate.getNumPerPage()
				} )#
				
				#datagridFilter.toHTML( theURL, { submit = 'update' } )#
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn html />
	</cffunction>
</cfcomponent>