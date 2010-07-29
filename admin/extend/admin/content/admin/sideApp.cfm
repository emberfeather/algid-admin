<cfset viewApp = views.get('admin', 'app') />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewApp.filter( filter )#
</cfoutput>