<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMltitle()#</cfoutput></title>
		
		<!--- Include minified files for production --->
		<cfset midfix = (transport.theApplication.managers.singleton.getApplication().isProduction() ? '-min' : '') />
		
		<cfset template.addStyles('http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/smoothness/jquery-ui.css', '../plugins/admin/style/960/reset#midfix#.css', '../plugins/admin/style/960/960#midfix#.css"', '../plugins/admin/extend/admin/theme/admin/style/styles#midfix#.css') />
		<cfset template.addStyle('../plugins/admin/extend/admin/theme/admin/style/print#midfix#.css', 'print') />
		
		<cfset template.addScripts('../plugins/admin/extend/admin/theme/admin/script/admin#midfix#.js') />
		
		<!--- Setup admin search settings --->
		<cfset adminPlugin = transport.theApplication.managers.plugin.getAdmin() />
		<cfset searchSettings = adminPlugin.getSearch() />
		
		<cfsavecontent variable="adminSearch">
			<cfoutput>
				;(function($){
					$.algid.admin.options.base.url = '#transport.theApplication.managers.singleton.getApplication().getPath()#';
					$.algid.admin.options.search.threshold = #searchSettings.threshold#;
				})(jQuery);
			</cfoutput>
		</cfsavecontent>
		
		<cfset template.addScripts(adminSearch) />
		
		<cfoutput>#template.getStyles()#</cfoutput>
	</head>
	<body>
		<div class="container_12">
			<div id="header" class="no-print">
				<div class="grid_3">
					<a href="?"><img src="../plugins/admin/extend/admin/theme/admin/img/algid-admin.png" alt="Admin" /></a>
				</div>
				
				<cfif not template.getIsSimple()>
					<div class="grid_9">
						<cfif transport.theSession.managers.singleton.hasUser()>
							<div class="float-right">
								<p>
									<cfset theURL.cleanAccount() />
									<cfset theURL.setAccount('_base', '/account') />
									
									<cfset theURL.cleanLogout() />
									<cfset theURL.setLogout('_base', '/account/logout') />
									
									<cfoutput>
										<a href="#theURL.getAccount()#">#session.managers.singleton.getUser().getDisplayName()#</a> | <a href="#theURL.getLogout()#">Logout</a>
									</cfoutput>
								</p>
							</div>
						</cfif>
						
						<div>
							<cfset theURL.cleanSearch() />
							<cfset theURL.setSearch('_base', '/search') />
							
							<cfoutput>
								<form action="#theUrl.getSearch()#" method="post" id="adminSearch">
									<input type="text" name="term" placeholder="Search..." />
									<input type="submit" value="Search" />
								</form>
							</cfoutput>
						</div>
					</div>
				</cfif>
				
				<div class="clear"><!-- clear --></div>
			</div>
			
			<cfif not template.getIsSimple()>
				<div class="grid_12 no-print">
					<cfset options = {
							navClasses = ['menu horizontal float-right']
						} />
					
					<cfif transport.theSession.managers.singleton.hasUser()>
						<cfoutput>#template.getNavigation(2, 'action', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
					<cfelse>
						<cfoutput>#template.getNavigation(2, 'action', options)#</cfoutput>
					</cfif>
					
					<cfset options = {
							navClasses = ['menu horizontal']
						} />
					
					<cfif transport.theSession.managers.singleton.hasUser()>
						<cfoutput>#template.getNavigation(1, 'main', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
					<cfelse>
						<cfoutput>#template.getNavigation(1, 'main', options)#</cfoutput>
					</cfif>
					
					<div class="clear"><!-- clear --></div>
				</div>
			</cfif>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="content">
				<div id="breadcrumb" class="grid_12 no-print">
					<cfoutput>#template.getBreadcrumb({ topLevel = 2 })#</cfoutput>
					
					<div class="clear"><!-- clear --></div>
				</div>
				
				<cfif not template.getIsSimple()>
					<div class="grid_12 no-print">
						<cfset showingNavigation = false />
						<cfset navLevel = template.getLevel() />
						
						<cfif navLevel gt 1>
							<cfset options = {
									navClasses = ['submenu horizontal float-right']
								} />
							
							<cfif transport.theSession.managers.singleton.hasUser()>
								<cfset subNav = template.getNavigation( navLevel + 1, 'action', options, transport.theSession.managers.singleton.getUser()) />
							<cfelse>
								<cfset subNav = template.getNavigation( navLevel + 1, 'action', options) />
							</cfif>
							
							<cfset showingNavigation = showingNavigation or trim(subNav) neq '' />
							
							<cfoutput>#subNav#</cfoutput>
						</cfif>
						
						<cfset options = {
								navClasses = ['submenu horizontal']
							} />
						
						<cfif transport.theSession.managers.singleton.hasUser()>
							<cfset subNav = (template.getNavigation(navLevel + 1, 'main', options, transport.theSession.managers.singleton.getUser())) />
						<cfelse>
							<cfset subNav = (template.getNavigation(navLevel + 1, 'main', options)) />
						</cfif>
						
						<cfset showingNavigation = showingNavigation or trim(subNav) neq '' />
						
						<cfoutput>#subNav#</cfoutput>
						
						<!--- If there is not any navigation showing then show the actions for the current level --->
						<cfif navLevel gt 1 and not showingNavigation>
							<cfif navLevel gt 2>
								<cfset options = {
										navClasses = ['submenu horizontal float-right']
									} />
								
								<cfif transport.theSession.managers.singleton.hasUser()>
									<cfoutput>#template.getNavigation( navLevel, 'action', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
								<cfelse>
									<cfoutput>#template.getNavigation( navLevel, 'action', options)#</cfoutput>
								</cfif>
							</cfif>
							
							<cfset options = {
									navClasses = ['submenu horizontal']
								} />
							
							<cfif transport.theSession.managers.singleton.hasUser()>
								<cfoutput>#template.getNavigation( navLevel, 'main', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
							<cfelse>
								<cfoutput>#template.getNavigation( navLevel, 'main', options)#</cfoutput>
							</cfif>
						</cfif>
						
						<div class="clear"><!-- clear --></div>
					</div>
				</cfif>
				
				<cfinclude template="partial.cfm" />
			</div>
			
			<div class="grid_12 align-center">
				Powered by <a href="http://github.com/emberfeather/algid" title="Algid CFML Framework">Algid</a>.
			</div>
			
			<div class="clear"><!-- clear --></div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>