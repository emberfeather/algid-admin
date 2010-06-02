<cfset viewSearch = transport.theApplication.factories.transient.getViewSearchForAdmin( transport ) />

<cfset searchResults = servSearch.search( transport.theSession.managers.singleton.getUser(), theUrl.search('term')) />

<cfoutput>
	#viewSearch.search( searchResults )#
</cfoutput>
