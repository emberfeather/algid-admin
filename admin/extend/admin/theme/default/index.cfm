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
					<a href="?"><img src="../plugins/admin/extend/admin/theme/default/algid-admin.png" title="<cfoutput>#application.information.title#</cfoutput>" alt="<cfoutput>#application.information.title#</cfoutput>" /></a>
				</div>
			</div>
			
			<div class="grid_9">
				<div class="block">
					<p>
						Username | Logout
					</p>
					<p>
						Stats and other information... maybe this area is a widget?!?
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
			
			<div class="grid_3">
				<div class="box menu">
					<h2><cfoutput>#template.getPageTitle(1)#</cfoutput> Navigation</h2>
					
					<div class="block">
						<cfset options = {
								depth = 2,
								navClasses = ['section menu', 'submenu'],
								selectedOnly = false
							} />
						<cfoutput>#template.getNavigation(2, 'secondary', options)#</cfoutput>
					</div>
				</div>
				
				<div class="box menu">
					<h2>Actions</h2>
					
					<div class="block">
						<cfset options = {
								navClasses = ['section menu']
							} />
						<cfoutput>#template.getNavigation(template.getLevel(), 'action', options)#</cfoutput>
					</div>
				</div>
				
				<!--- TODO Figure out a widget system --->
				<div class="box">
					<h2>Plugin Widget Title</h2>
					
					<div class="block">
						<p>
							Widgets about the plugin...how do we do widgets?!?
						</p>
					</div>
				</div>
			</div>
			
			<div class="grid_9">
				<cfoutput>#template.getContent()#</cfoutput>
			</div>
			
			<div class="clear"><!-- clear --></div>
		</div>
		
		<cfoutput>#template.getScripts()#</cfoutput>
	</body>
</html>