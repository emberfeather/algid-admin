<!--- If we have the tracker plugin show the recent events --->
<cfif transport.theApplication.managers.singleton.getApplication().hasPlugin('tracker')>
	<cfset servEvent = transport.theApplication.factories.transient.getServEventForTracker(transport.theApplication.managers.singleton.getApplication().getDSUpdate(), transport) />
	
	<cfset viewEvent = transport.theApplication.factories.transient.getViewEventForTracker( transport ) />
	
	<cfset filter = {
			'limit' = 7,
			'userID' = session.managers.singleton.getUser().getUserID()
		} />
	
	<cfset events = servEvent.readEvents( filter ) />
	
	<cfoutput>#viewEvent.recent(events)#</cfoutput>
</cfif>