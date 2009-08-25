<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMLTitle()#</cfoutput></title>
		
		<cfset template.addStyles('../plugins/admin/style/960/reset#midfix#.css', '../plugins/admin/style/960/960#midfix#.css"', '../plugins/admin/extend/admin/theme/default/styles#midfix#.css') />
		
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
				<div class="float-right">
					<cfset theURL.setAccount('_base', '.account') />
					<cfset theURL.setLogout('_base', '.account.logout') />
					<cfoutput>
						<a href="#theURL.getAccount()#">Username</a> | <a href="#theURL.getLogout()#">Logout</a>
					</cfoutput>
				</div>
				
				<div>
					<!--- Output the user stats --->
					<cfoutput>#template.getStats()#</cfoutput>
				</div>
			</div>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="grid_12">
				<div class="menuHolder main">
					<cfset hasNavigation = true />
					<cfset navLevel = 1 />
					
					<cfloop condition="hasNavigation">
						<cfset options = {
								navClasses = ['menu horizontal right']
							} />
						
						<cfoutput>#template.getNavigation(navLevel + 1, 'action', options)#</cfoutput>
						
						<cfset options = {
								navClasses = ['menu horizontal']
							} />
						
						<cfset mainNav = trim(template.getNavigation(navLevel, 'main', options)) />
						
						<cfoutput>#mainNav#</cfoutput>
						
						<cfset hasNavigation = mainNav NEQ '' />
						<cfset navLevel++ />
						
						<div class="clear"><!-- clear --></div>
					</cfloop>
				</div>
			</div>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="content">
				<div class="grid_3">
					<div class="box">
						<cfoutput>#template.getSide()#</cfoutput>
					</div>
				</div>
			
				<div class="grid_9">
					<h2><cfoutput>#template.getPageTitle()#</cfoutput></h2>
					
					<div>
						<cfoutput>#template.getBreadcrumb()#</cfoutput>
					</div>
					
					<!--- Output the main content --->
					<cfoutput>#template.getContent()#</cfoutput>
				</div>
				<div class="clear"><!-- clear --></div>
			</div>
			
			<div class="clear"><!-- clear --></div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>