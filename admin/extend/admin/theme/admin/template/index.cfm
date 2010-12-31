<cfsilent>
	<cfset hasUser = transport.theSession.managers.singleton.hasUser() />
	<cfset isLoggedIn = hasUser and transport.theSession.managers.singleton.getUser().isLoggedIn() />
	<cfset app = transport.theApplication.managers.singleton.getApplication() />
	<cfset plugin = transport.theApplication.managers.plugin.getAdmin() />
	
	<!--- Include minified files for production --->
	<cfset midfix = (app.isProduction() ? '-min' : '') />
	
	<cfset template.addStyles(
		'http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/smoothness/jquery-ui.css',
		'http://fonts.googleapis.com/css?family=Philosopher&subset=latin',
		transport.theRequest.webRoot & 'plugins/admin/style/960/reset#midfix#.css',
		transport.theRequest.webRoot & 'plugins/admin/style/960/960#midfix#.css',
		transport.theRequest.webRoot & 'plugins/admin/extend/admin/theme/admin/style/styles#midfix#.css'
	) />
	
	<cfset template.addStyle(transport.theRequest.webRoot & 'plugins/admin/extend/admin/theme/admin/style/print#midfix#.css', 'print') />
	
	<cfset template.addScripts(transport.theRequest.webRoot & 'plugins/admin/extend/admin/theme/admin/script/admin#midfix#.js') />
	
	<!--- Setup admin search settings --->
	<cfset searchSettings = plugin.getSearch() />
	
	<cfsavecontent variable="adminSearch">
		<cfoutput>
			;(function($){
				$.algid.admin.options.base.url = '#app.getPath()#';
				$.algid.admin.options.search.threshold = #searchSettings.threshold#;
			})(jQuery);
		</cfoutput>
	</cfsavecontent>
	
	<cfset template.addScripts(adminSearch) />
	
	<cfset template.addScripts('../plugins/api/script/jquery.api#midfix#.js') />
</cfsilent>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMltitle()#</cfoutput></title>
		
		<cfoutput>#template.getStyles()#</cfoutput>
	</head>
	<body>
		<div class="container-outer <cfoutput>#app.getEnvironment()#</cfoutput>">
			<div class="container_12 respect-float">
				<div id="header" class="no-print respect-float">
					<div class="grid_5">
						<h1><a href="?"><cfoutput>#app.getName()#</cfoutput></a></h1>
					</div>
					
					<cfif not template.getIsSimple()>
						<div class="grid_7">
							<cfif isLoggedIn>
								<div class="float-right">
									<p>
										<cfset theURL.cleanAccount() />
										<cfset theURL.setAccount('_base', '/account') />
										
										<cfset theURL.cleanLogout() />
										<cfset theURL.setLogout('_base', '/account/logout') />
										
										<cfoutput>
											<a href="#theURL.getAccount()#">#session.managers.singleton.getUser().getDisplayName()#</a> | <a href="#theURL.getLogout()#">#template.getLabel('logout')#</a>
										</cfoutput>
									</p>
								</div>
							</cfif>
							
							<div>
								<cfset theURL.cleanSearch() />
								<cfset theURL.setSearch('_base', '/search') />
								
								<cfoutput>
									<form action="#theUrl.getSearch()#" method="post" id="adminSearch">
										<input type="search" name="term" placeholder="Search..." />
										<input type="submit" value="Search" />
									</form>
								</cfoutput>
							</div>
						</div>
					</cfif>
				</div>
				
				<cfif not template.getIsSimple()>
					<div class="grid_12 no-print respect-float">
						<cfset options = {
								navClasses = ['menu horizontal float-right']
							} />
						
						<cfif isLoggedIn>
							<cfoutput>#template.getNavigation(2, 'action', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
						<cfelseif not hasUser>
							<cfoutput>#template.getNavigation(2, 'action', options)#</cfoutput>
						</cfif>
						
						<cfset options = {
								navClasses = ['menu horizontal']
							} />
						
						<cfif isLoggedIn>
							<cfoutput>#template.getNavigation(1, 'main', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
						<cfelseif not hasUser>
							<cfoutput>#template.getNavigation(1, 'main', options)#</cfoutput>
						</cfif>
					</div>
				</cfif>
				
				<div class="clear"><!-- clear --></div>
				
				<div class="content respect-float">
					<div id="breadcrumb" class="grid_12 no-print respect-float">
						<cfoutput>#template.getBreadcrumb({ topLevel = 2 })#</cfoutput>
					</div>
					
					<cfif not template.getIsSimple()>
						<div class="grid_12 no-print">
							<cfset showingNavigation = false />
							<cfset navLevel = template.getCurrentLevel() />
							
							<cfif navLevel gt 1>
								<cfset options = {
										navClasses = ['submenu horizontal float-right']
									} />
								
								<cfif isLoggedIn>
									<cfset subNav = template.getNavigation( navLevel + 1, 'action', options, transport.theSession.managers.singleton.getUser()) />
								<cfelseif not hasUser>
									<cfset subNav = template.getNavigation( navLevel + 1, 'action', options) />
								<cfelse>
									<cfset subNav = '' />
								</cfif>
								
								<cfset showingNavigation = showingNavigation or trim(subNav) neq '' />
								
								<cfoutput>#subNav#</cfoutput>
							</cfif>
							
							<cfset options = {
									navClasses = ['submenu horizontal']
								} />
							
							<cfif isLoggedIn>
								<cfset subNav = (template.getNavigation(navLevel + 1, 'main', options, transport.theSession.managers.singleton.getUser())) />
							<cfelseif not hasUser>
								<cfset subNav = (template.getNavigation(navLevel + 1, 'main', options)) />
							<cfelse>
								<cfset subNav = '' />
							</cfif>
							
							<cfset showingNavigation = showingNavigation or trim(subNav) neq '' />
							
							<cfoutput>#subNav#</cfoutput>
							
							<!--- If there is not any navigation showing then show the actions for the current level --->
							<cfif navLevel gt 1 and not showingNavigation>
								<cfif navLevel gt 2>
									<cfset options = {
											navClasses = ['submenu horizontal float-right']
										} />
									
									<cfif isLoggedIn>
										<cfoutput>#template.getNavigation( navLevel, 'action', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
									<cfelseif not hasUser>
										<cfoutput>#template.getNavigation( navLevel, 'action', options)#</cfoutput>
									</cfif>
								</cfif>
								
								<cfset options = {
										navClasses = ['submenu horizontal']
									} />
								
								<cfif isLoggedIn>
									<cfoutput>#template.getNavigation( navLevel, 'main', options, transport.theSession.managers.singleton.getUser())#</cfoutput>
								<cfelseif not hasUser>
									<cfoutput>#template.getNavigation( navLevel, 'main', options)#</cfoutput>
								</cfif>
							</cfif>
						</div>
					</cfif>
					
					<div class="grid_12 respect-float">
						<h2><cfoutput>#template.getPageTitle()#</cfoutput></h2>
						<!--- Show any messages, errors, warnings, or successes --->
						<cfset messages = session.managers.singleton.getError() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<cfset messages = session.managers.singleton.getWarning() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<cfset messages = session.managers.singleton.getSuccess() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
						
						<cfset messages = session.managers.singleton.getMessage() />
						
						<cfoutput>#messages.toHTML()#</cfoutput>
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
						<cfset useBox = not template.hasUseBox() or template.getUseBox() eq true />
						
						<div class="grid_3">
							<div class="<cfif useBox>box</cfif>">
								<cfoutput>#template.getSide()#</cfoutput>
							</div>
						</div>
					</cfif>
				</div>
			</div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>