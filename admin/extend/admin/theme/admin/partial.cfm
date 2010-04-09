<div class="grid_12">
	<h2><cfoutput>#template.getPageTitle()#</cfoutput></h2>
</div>

<div class="grid_12">
	<!--- Show any messages, errors, warnings, or successes --->
	<cfset messages = session.managers.singleton.getError() />
	
	<cfoutput>#messages.toHTML()#</cfoutput>
	
	<cfset messages = session.managers.singleton.getWarning() />
	
	<cfoutput>#messages.toHTML()#</cfoutput>
	
	<cfset messages = session.managers.singleton.getSuccess() />
	
	<cfoutput>#messages.toHTML()#</cfoutput>
	
	<cfset messages = session.managers.singleton.getMessage() />
	
	<cfoutput>#messages.toHTML()#</cfoutput>
	
	<div class="clear"><!-- clear --></div>
</div>

<cfif trim(template.getSide()) eq ''>
	<cfset mainGrid = 12 />
<cfelse>
	<cfset mainGrid = 9 />
</cfif>

<div class="grid_<cfoutput>#mainGrid#</cfoutput>">
	
	<!--- Output the main content --->
	<cfoutput>#template.getContent()#</cfoutput>
</div>

<!--- Display the side if it exists --->
<cfif mainGrid eq 9>
	<div class="grid_3">
		<div class="box">
			<cfoutput>#template.getSide()#</cfoutput>
		</div>
	</div>
</cfif>

<div class="clear"><!-- clear --></div>
