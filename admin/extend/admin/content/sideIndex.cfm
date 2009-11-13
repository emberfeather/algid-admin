<!--- If we have the tracker plugin show the recent events --->
<cfif application.app.hasPlugin('tracker')>
	<cfset servEvent = application.factories.transient.getServEventForTracker(application.app.getDSUpdate(), transport) />
	
	<cfset viewEvent = application.factories.transient.getViewEventForTracker( transport ) />
	
	<cfset filter = {
			'limit' = 7,
			'userID' = SESSION.managers.singleton.getUser().getUserID()
		} />
	
	<cfset events = servEvent.readEvents( filter ) />
	
	<cfoutput>#viewEvent.recent(events)#</cfoutput>
</cfif>