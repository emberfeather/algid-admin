<cfset viewSearch = views.get('admin', 'search') />

<cfset searchResults = servSearch.search( transport.theSession.managers.singleton.getUser(), theUrl.search('term')) />

<cfoutput>
	#viewSearch.search( searchResults )#
</cfoutput>
