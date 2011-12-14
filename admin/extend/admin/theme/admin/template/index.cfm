<cfsilent>
	<cfset hasUser = transport.theSession.managers.singleton.hasUser() />
	<cfset app = transport.theApplication.managers.singleton.getApplication() />
	<cfset admin = transport.theApplication.managers.plugin.getAdmin() />
	<cfset api = transport.theApplication.managers.plugin.getApi() />
	<cfset isProduction = app.isProduction() />
	
	<cfif hasUser>
		<cfset user = transport.theSession.managers.singleton.getUser() />
	</cfif>
	
	<cfset isLoggedIn = hasUser and user.isLoggedIn() />
	<cfset minFix = isProduction ? '-min' : '' />
	
	<!--- Setup admin search settings --->
	<cfset searchSettings = admin.getSearch() />
	
	<cfsavecontent variable="settings">
		<cfoutput>
			require([
				'jquery',
				'plugins/admin/extend/admin/theme/admin/script/theme',
				'plugins/api/script/api'
			], function($) {
				$.algid.admin.options.base.url = '#app.getPath()#';
				$.algid.admin.options.search.threshold = #searchSettings.threshold#;
				$.api.defaults.url = '#app.getPath()##api.getPath()#';
			});
		</cfoutput>
	</cfsavecontent>
	
	<cfset template.addScripts(settings) />
</cfsilent>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title><cfoutput>#template.getHTMltitle()#</cfoutput></title>
		
		<cfoutput>
			<cfif isProduction>
				<link rel="stylesheet" href="/cf-compendium/style/cf-compendium-min.css" />
				<link rel="stylesheet" href="/algid/style/algid-min.css" />
			<cfelse>
				<link rel="stylesheet" href="/cf-compendium/style/base.css" />
				<link rel="stylesheet" href="/cf-compendium/style/form.css" />
				<link rel="stylesheet" href="/cf-compendium/style/datagrid.css" />
				<link rel="stylesheet" href="/cf-compendium/style/detail.css" />
				<link rel="stylesheet" href="/cf-compendium/style/code.css" />
				<link rel="stylesheet" href="/algid/style/base.css" />
			</cfif>
			
			<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1/themes/smoothness/jquery-ui.css" />
			<link rel="stylesheet" href="//fonts.googleapis.com/css?family=Philosopher&subset=latin" />
			<link rel="stylesheet" href="/algid/style/960/reset-min.css" />
			<link rel="stylesheet" href="/algid/style/960/960-min.css" />
			<link rel="stylesheet" href="#transport.theRequest.webRoot#plugins/admin/extend/admin/theme/admin/style/admin#minFix#.css" />
			<link rel="stylesheet" href="#transport.theRequest.webRoot#plugins/editor/script/markitup/skins/markitup/style#minFix#.css" />
			<link rel="stylesheet" href="#transport.theRequest.webRoot#plugins/editor/style/editor#minFix#.css" />
			
			<link rel="stylesheet" href="#transport.theRequest.webRoot#plugins/admin/extend/admin/theme/admin/style/print#minFix#.css" media="print" />
			
			<cfif not isProduction>
				<link rel="stylesheet" href="#transport.theRequest.webRoot#plugins/admin/extend/admin/theme/admin/style/#(app.isMaintenance() ? "maintenance" : "development")#-min.css" />
			</cfif>
			
			#template.getStyles()#
		</cfoutput>
	</head>
	<body>
		<div class="container-outer <cfoutput>#app.getEnvironment()#</cfoutput>">
			<div class="container_12 respect-float">
				<div id="header" class="no-print respect-float">
					<div class="grid_5">
						<h1><a href="<cfoutput>#transport.theRequest.webRoot & transport.theRequest.requestRoot#</cfoutput>"><cfoutput>#app.getName()#</cfoutput></a></h1>
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
											<a href="#theURL.getAccount()#">#user.getDisplayName()#</a> | <a href="#theURL.getLogout()#">#template.getLabel('logout')#</a>
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
							<cfoutput>#template.getNavigation(2, 'action', options, user)#</cfoutput>
						<cfelseif not hasUser>
							<cfoutput>#template.getNavigation(2, 'action', options)#</cfoutput>
						</cfif>
						
						<cfset options = {
							navClasses = ['menu horizontal']
						} />
						
						<cfif isLoggedIn>
							<cfoutput>#template.getNavigation(1, 'main', options, user)#</cfoutput>
						<cfelseif not hasUser>
							<cfoutput>#template.getNavigation(1, 'main', options)#</cfoutput>
						</cfif>
					</div>
				</cfif>
				
				<div class="clear"><!-- clear --></div>
				
				<div class="container-content respect-float">
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
									<cfset subNav = template.getNavigation( navLevel + 1, 'action', options, user) />
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
							
							<cfif navLevel gt 0>
								<cfif isLoggedIn>
									<cfset subNav = (template.getNavigation(navLevel + 1, 'main', options, user)) />
								<cfelseif not hasUser>
									<cfset subNav = (template.getNavigation(navLevel + 1, 'main', options)) />
								<cfelse>
									<cfset subNav = '' />
								</cfif>
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
										<cfoutput>#template.getNavigation( navLevel, 'action', options, user)#</cfoutput>
									<cfelseif not hasUser>
										<cfoutput>#template.getNavigation( navLevel, 'action', options)#</cfoutput>
									</cfif>
								</cfif>
								
								<cfset options = {
									navClasses = ['submenu horizontal']
								} />
								
								<cfif isLoggedIn>
									<cfoutput>#template.getNavigation( navLevel, 'main', options, user)#</cfoutput>
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
		
		<cfoutput>
			<script src="/cf-compendium/script/require-min.js"></script>
			<script>
				require.config({
					baseUrl: '#transport.theRequest.webRoot#',
					paths: {
						'async': '/cf-compendium/script/plugin/async',
						'goog': '/cf-compendium/script/plugin/goog',
						'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min',
						'jqueryui': '//ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min'
					}
				});
			</script>
			#template.getScripts()#
		</cfoutput>
	</body>
</html>