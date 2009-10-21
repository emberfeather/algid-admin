<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMLTitle()#</cfoutput></title>
		
		<cfset template.addStyles('../plugins/admin/style/960/reset#midfix#.css', '../plugins/admin/style/960/960#midfix#.css"', '../plugins/admin/extend/admin/theme/admin/style/styles#midfix#.css') />
		<cfset template.addStyle('../plugins/admin/extend/admin/theme/admin/style/print#midfix#.css', 'print') />
		
		<cfset template.addScripts('../cf-compendium/script/jquery.datagrid#midfix#.js') />
		<cfset template.addScripts('../plugins/admin/extend/admin/theme/admin/script/admin#midfix#.js') />
		
		<cfoutput>#template.getStyles()#</cfoutput>
	</head>
	<body>
		<div class="container_12">
			<div id="header" class="no-print">
				<div class="grid_3">
					<a href="?"><img src="../plugins/admin/extend/admin/theme/admin/img/algid-admin.png" alt="Admin" /></a>
				</div>
				
				<cfif SESSION.managers.singleton.getUser().getUserID() NEQ 0>
					<div class="grid_9">
						<div class="float-right">
							<p>
								<cfset theURL.setAccount('_base', '.account') />
								<cfset theURL.setLogout('_base', '.account.logout') />
								<cfoutput>
									<a href="#theURL.getAccount()#">Username</a> | <a href="#theURL.getLogout()#">Logout</a>
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
			<cfif SESSION.managers.singleton.getUser().getUserID() NEQ 0>
				<div class="grid_12 no-print">
					<cfset hasNavigation = true />
					<cfset navLevel = 1 />
					
					<cfloop condition="hasNavigation">
						<cfset options = {
								navClasses = ['menu horizontal float-right']
							} />
						
						<cfoutput>#template.getNavigation(navLevel + 1, 'action', options, SESSION.managers.singleton.getUser())#</cfoutput>
						
						<cfset options = {
								navClasses = ['menu horizontal']
							} />
						
						<cfset mainNav = trim(template.getNavigation(navLevel, 'main', options, SESSION.managers.singleton.getUser())) />
						
						<cfoutput>#mainNav#</cfoutput>
						
						<cfset hasNavigation = mainNav NEQ '' />
						<cfset navLevel++ />
						
						<div class="clear"><!-- clear --></div>
					</cfloop>
				</div>
			</cfif>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="content">
				<cfif trim(template.getSide()) EQ ''>
					<cfset mainGrid = 12 />
				<cfelse>
					<cfset mainGrid = 9 />
					<div class="grid_3">
						<div class="box">
							<cfoutput>#template.getSide()#</cfoutput>
						</div>
					</div>
				</cfif>
			
				<div class="grid_<cfoutput>#mainGrid#</cfoutput>">
					<div id="breadcrumb" class="float-right">
						<cfoutput>#template.getBreadcrumb()#</cfoutput>
					</div>
					
					<h2><cfoutput>#template.getPageTitle()#</cfoutput></h2>
					
					<!--- Output the main content --->
					<cfoutput>#template.getContent()#</cfoutput>
				</div>
				
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