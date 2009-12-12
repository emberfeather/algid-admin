<!--- If we have the tracker plugin show the recent events --->
<cfif application.app.hasPlugin('tracker')>
	<cfset servEvent = transport.theApplication.factories.transient.getServEventForTracker(application.app.getDSUpdate(), transport) />
	
	<cfset viewEvent = transport.theApplication.factories.transient.getViewEventForTracker( transport ) />
	
	<cfset filter = {
			'limit' = 7,
			'userID' = session.managers.singleton.getUser().getUserID()
		} />
	
	<cfset events = servEvent.readEvents( filter ) />
	
	<cfoutput>#viewEvent.recent(events)#</cfoutput>
</cfif>