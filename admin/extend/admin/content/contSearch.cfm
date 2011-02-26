<cfset viewSearch = views.get('admin', 'search') />

<cfset searchResults = servSearch.search( theUrl.search('term')) />

<cfoutput>
	#viewSearch.search( searchResults )#
</cfoutput>
