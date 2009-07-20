<cfsilent>
	<!--- Create URL object from the factory --->
	<cfset theURL = application.managers.factory.getURL(CGI.QUERY_STRING) />
	
	<!--- TODO Find actual location --->
	
	<!--- TODO Process request --->
	
	<!--- TODO Create  template object --->
	
	<!--- TODO Include Template File --->
</cfsilent>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		
		<title>Administration</title>
		
		<!--- TODO include minified css file in production --->
		<link rel="stylesheet" href="../plugins/admin/style/960/reset.css" type="text/css"/>
		<link rel="stylesheet" href="../plugins/admin/style/960/text.css" type="text/css"/>
		<link rel="stylesheet" href="../plugins/admin/style/960/960.css" type="text/css"/>
		<link rel="stylesheet" href="../plugins/admin/style/admin.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/styles.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/form.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/list.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/datagrid.css" type="text/css"/>
	</head>
	<body>
		<div id="admin-container" class="container_12">
			<div id="admin-header">
				<div id="admin-logo">
					Logo Here
				</div>
				
				<div id="admin-info">
					<div>
						Username | Logout
					</div>
					<div>
						Stats and other information
					</div>
				</div>
				
				<div id="admin-plugins">
					<!--- TODO Use the template --->
					<ul class="horizontalNav">
						<li><a href="#">Navigation</a></li>
						<li><a href="#">For</a></li>
						<li><a href="#">Plugins</a></li>
						<li><a href="#">Here</a></li>
					</ul>
				</div>
			</div>
			
			<div id="admin-content">
				<cfinclude template="/cf-compendium/inc/resource/structure/markupGuide.cfm" />
			</div>
		</div>
		
		<!--- TODO Include minified js file for production --->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
		<script type="text/javascript" src="../plugins/admin/script/admin.js"></script>
		<script type="text/javascript" src="../cf-compendium/script/form.js"></script>
		<script type="text/javascript" src="../cf-compendium/script/list.js"></script>
		<script type="text/javascript" src="../cf-compendium/script/datagrid.js"></script>
	</body>
</html>