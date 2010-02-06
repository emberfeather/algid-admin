<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMltitle()#</cfoutput></title>
		
		<!--- Include minified files for production --->
		<cfset midfix = (transport.theApplication.managers.singleton.getApplication().isProduction() ? '-min' : '') />
		
		<cfset template.addStyles('../plugins/admin/style/960/reset#midfix#.css', '../plugins/admin/style/960/960#midfix#.css"', '../plugins/admin/extend/admin/theme/admin/style/styles#midfix#.css') />
		<cfset template.addStyle('../plugins/admin/extend/admin/theme/admin/style/print#midfix#.css', 'print') />
		
		<cfset template.addScripts('../plugins/admin/extend/admin/theme/admin/script/admin#midfix#.js') />
		
		<cfoutput>#template.getStyles()#</cfoutput>
	</head>
	<body>
		<div class="container_12">
			<div id="header" class="no-print">
				<div class="grid_3">
					<a href="?"><img src="../plugins/admin/extend/admin/theme/admin/img/algid-admin.png" alt="Admin" /></a>
				</div>
				
				<cfif session.managers.singleton.getUser().getUserID() neq 0>
					<div class="grid_9">
						<div class="float-right">
							<p>
								<cfset theURL.setAccount('_base', '.account') />
								<cfset theURL.setLogout('_base', '.account.logout') />
								<cfoutput>
									<a href="#theURL.getAccount()#">#session.managers.singleton.getUser().getUsername()#</a> | <a href="#theURL.getLogout()#">Logout</a>
								</cfoutput>
							</p>
						</div>
						
						<div>
							<p>
								<!--- Output the user stats --->
								<cfoutput>#template.getStats()#</cfoutput>
							</p>
						</div>
					</div>
				</cfif>
				
				<div class="clear"><!-- clear --></div>
			</div>
			
			<!--- TODO This should really be controlled by the navigation permissions...? --->
			<cfif session.managers.singleton.getUser().getUserID() neq 0>
				<div class="grid_12 no-print">
					<cfset options = {
							navClasses = ['menu horizontal float-right']
						} />
					
					<cfoutput>#template.getNavigation(2, 'action', options, session.managers.singleton.getUser())#</cfoutput>
					
					<cfset options = {
							navClasses = ['menu horizontal']
						} />
					
					<cfoutput>#template.getNavigation(1, 'main', options, session.managers.singleton.getUser())#</cfoutput>
					
					<div class="clear"><!-- clear --></div>
				</div>
			</cfif>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="content">
				<div id="breadcrumb" class="grid_12 no-print">
					<cfoutput>#template.getBreadcrumb({ topLevel = 2 })#</cfoutput>
					
					<div class="clear"><!-- clear --></div>
				</div>
				
				<div class="grid_12 no-print">
					<cfset showingNavigation = false />
					<cfset navLevel = template.getLevel() />
					
					<cfif navLevel gt 1>
						<cfset options = {
								navClasses = ['submenu horizontal float-right']
							} />
						
						<cfset subNav = trim(template.getNavigation( navLevel + 1, 'action', options, session.managers.singleton.getUser())) />
						
						<cfset showingNavigation = showingNavigation or subNav neq '' />
						
						<cfoutput>#subNav#</cfoutput>
					</cfif>
					
					<cfset options = {
							navClasses = ['submenu horizontal']
						} />
					
					<cfset subNav = trim(template.getNavigation(navLevel + 1, 'main', options, session.managers.singleton.getUser())) />
					
					<cfset showingNavigation = showingNavigation or subNav neq '' />
					
					<cfoutput>#subNav#</cfoutput>
					
					<!--- If there is not any navigation showing then show the actions for the current level --->
					<cfif navLevel gt 1 and not showingNavigation>
						<cfif navLevel gt 2>
							<cfset options = {
									navClasses = ['submenu horizontal float-right']
								} />
							
							<cfoutput>#template.getNavigation( navLevel, 'action', options, session.managers.singleton.getUser())#</cfoutput>
						</cfif>
						
						<cfset options = {
								navClasses = ['submenu horizontal']
							} />
						
						<cfoutput>#template.getNavigation( navLevel, 'main', options, session.managers.singleton.getUser())#</cfoutput>
					</cfif>
					
					<div class="clear"><!-- clear --></div>
				</div>
				
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
			</div>
			
			<div class="grid_12 align-center">
				Powered by <a href="http://code.google.com/p/algid/" title="Algid CFML Framework">Algid</a>.
			</div>
			
			<div class="clear"><!-- clear --></div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>