<cfcomponent extends="algid.inc.resource.base.view" output="false">
	<cffunction name="generateReport" access="public" returntype="string" output="false">
		<cfargument name="report" type="component" required="true" />
		
		<cfset local.sections = arguments.report.getSections() />
		
		<cfsavecontent variable="local.html">
			<cfoutput>
				<!doctype html>
				<html lang="en">
					<head>
						<title>#arguments.report.getTitle()#</title>
					</head>
					
					<body>
						<h1>#arguments.report.getTitle()#</h1>
						
						<cfloop from="1" to="#arrayLen(local.sections)#" index="local.i">
							<cfset local.section = local.sections[local.i] />
							
							<h2>#local.section.getTitle()#</h2>
							
							#local.section.getContent()#
						</cfloop>
					</body>
				</html>
			</cfoutput>
		</cfsavecontent>
		
		<cfreturn local.html />
	</cffunction>
</cfcomponent>
