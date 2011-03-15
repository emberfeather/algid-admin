<!--- If we have the tracker plugin show the recent events --->
<cfif transport.theApplication.managers.singleton.getApplication().hasPlugin('tracker')>
	<cfset servEvent = services.get('tracker', 'event') />
	<cfset viewEvent = views.get('tracker', 'event') />
	
	<cfset filter = {
			'limit' = 7,
			'userID' = transport.theSession.managers.singleton.getUser().getUserID()
		} />
	
	<cfset events = servEvent.getEvents( filter ) />
	
	<cfoutput>#viewEvent.recent(events)#</cfoutput>
</cfif>