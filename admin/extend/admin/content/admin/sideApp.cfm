<cfset viewApp = transport.theApplication.factories.transient.getViewAppForAdmin( transport ) />

<cfset filter = {
		'search' = theURL.search('search')
	} />

<cfoutput>
	#viewApp.filter( filter )#
</cfoutput>