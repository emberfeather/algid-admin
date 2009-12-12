<!--- Output a listing of all the plugins --->
<cfset plugins = servApp.readPlugins( filter ) />

<cfset paginate = variables.transport.theApplication.factories.transient.getPaginate(plugins.recordcount, session.numPerPage, theURL.searchID('onPage')) />

<cfoutput>#viewMaster.datagrid(transport, plugins, viewApp, paginate, filter)#</cfoutput>
