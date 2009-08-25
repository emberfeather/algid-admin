<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMLTitle()#</cfoutput></title>
		
		<cfoutput>#template.getStyles()#</cfoutput>
	</head>
	<body>
		<div class="container_12">
			<div class="grid_3">
				<div class="block">
					<a href="?"><img src="../plugins/admin/extend/admin/theme/default/algid-admin.png" alt="Admin" /></a>
				</div>
			</div>
			
			<div class="grid_9">
				<div class="block">
					<p>
						<cfset theURL.setAccount('_base', '.account') />
						<cfset theURL.setLogout('_base', '.account.logout') />
						<cfoutput>
							<a href="#theURL.getAccount()#">Username</a> | <a href="#theURL.getLogout()#">Logout</a>
						</cfoutput>
					</p>
					<p>
						<!--- Output the user stats --->
						<cfoutput>#template.getStats()#</cfoutput>
					</p>
				</div>
			</div>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="grid_12">
				<cfset options = {
						depth = 2,
						navClasses = ['nav main', 'submenu'],
						selectedOnly = false
					} />
				<cfoutput>#template.getNavigation(1, ['main', 'secondary'], options)#</cfoutput>
			</div>
			
			<div class="grid_12">
				<div class="float-right">
					<cfoutput>#template.getBreadcrumb()#</cfoutput>
				</div>
				
				<h2 id="page-heading"><cfoutput>#template.getPageTitle()#</cfoutput></h2>
			</div>
			
			<div class="clear"><!-- clear --></div>
			
			<cfset options = {
					depth = 2,
					navClasses = ['section menu', 'submenu'],
					selectedOnly = false
				} />
			
			<cfset secondaryNav = template.getNavigation(2, 'secondary', options) />
			
			<cfset options = {
					navClasses = ['section menu']
				} />
			
			<cfset actionNav = template.getNavigation(template.getLevel(), 'action', options) />
			
			<cfif actionNav EQ ''>
				<cfset actionNav = template.getNavigation(template.getLevel() + 1, 'action', options) />
			</cfif>
			
			<cfset sideContent = trim(template.getSide()) />
			
			<!--- Determine if we are using the sidebar --->
			<cfset isSideBar = secondaryNav NEQ '' OR actionNav NEQ '' OR sideContent NEQ '' />
			
			<!--- Test if we need the side column --->
			<cfif isSideBar>
				<div class="grid_3">
					<cfif secondaryNav NEQ ''>
						<div class="box menu">
							<h2><cfoutput>#template.getPageTitle(1)#</cfoutput></h2>
							
							<div class="block">
								<cfoutput>#secondaryNav#</cfoutput>
							</div>
						</div>
					</cfif>
					
					<cfif actionNav NEQ ''>
						<div class="box menu">
							<div class="block">
								<cfoutput>#actionNav#</cfoutput>
							</div>
						</div>
					</cfif>
					
					<cfif sideContent NEQ ''>
						<div class="box">
							<cfoutput>#sideContent#</cfoutput>
						</div>
					</cfif>
				</div>
			
				<div class="grid_9">
			<cfelse>
				<div class="grid_12">
			</cfif>
				<!--- Output the main content --->
				<cfoutput>#template.getContent()#</cfoutput>
			</div>
			
			<div class="clear"><!-- clear --></div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>