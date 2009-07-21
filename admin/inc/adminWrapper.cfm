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
		<link rel="stylesheet" href="../plugins/admin/style/960/layout.css" type="text/css"/>
		<link rel="stylesheet" href="../plugins/admin/style/960/nav.css" type="text/css"/>
		<link rel="stylesheet" href="../plugins/admin/style/admin.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/styles.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/form.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/list.css" type="text/css"/>
		<link rel="stylesheet" href="../cf-compendium/datagrid.css" type="text/css"/>
	</head>
	<body>
		<div class="container_12">
			<div class="grid_3">
				<div class="block">
					Logo Here
				</div>
			</div>
				
			<div class="grid_9">
				<div class="block">
					<p>
						Username | Logout
					</p>
					<p>
						Stats and other information
					</p>
				</div>
			</div>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="grid_12">
				<!--- TODO Use the template --->
				<ul class="nav main">
					<li>
						<a href="#">Plugin</a>
						<ul class="submenu">
							<li>
								<a>Submenu 1</a>
							</li>
							<li>
								<a>Submenu 2</a>
							</li>
							<li>
								<a>Submenu 3</a>
							</li>
							<li>
								<a>Submenu 4</a>
							</li>
							<li>
								<a>Submenu 5</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#">Navigation</a>
						<ul class="submenu">
							<li>
								<a>Submenu 1</a>
							</li>
							<li>
								<a>Submenu 2</a>
							</li>
							<li>
								<a>Submenu 3</a>
							</li>
							<li>
								<a>Submenu 4</a>
							</li>
							<li>
								<a>Submenu 5</a>
							</li>
						</ul>
					</li>
					<li>
						<a href="#">Here</a>
						<ul class="submenu">
							<li>
								<a>Submenu 1</a>
							</li>
							<li>
								<a>Submenu 2</a>
							</li>
							<li>
								<a>Submenu 3</a>
							</li>
							<li>
								<a>Submenu 4</a>
							</li>
							<li>
								<a>Submenu 5</a>
							</li>
						</ul>
					</li>
					<li class="secondary">
						<a href="#">Actions</a>
						<ul class="submenu">
							<li>
								<a>Submenu 1</a>
							</li>
							<li>
								<a>Submenu 2</a>
							</li>
							<li>
								<a>Submenu 3</a>
							</li>
							<li>
								<a>Submenu 4</a>
							</li>
							<li>
								<a>Submenu 5</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
			
			<div class="grid_12">
				<h2 id="page-heading">Page Title</h2>
				
				<p>
					Breadcrumb &raquo; goes &raquo; here!
				</p>
			</div>
			
			<div class="clear"><!-- clear --></div>
			
			<div class="grid_3">
				<div class="box menu">
					<h2>Plugin Navigation</h2>
					
					<div class="block">
						<!--- TODO Use the template --->
						<ul class="section menu">
							<li>
								<a href="#">Individual</a>
								<ul class="submenu">
									<li>
										<a>Submenu 1</a>
									</li>
									<li>
										<a class="active">Submenu 2</a>
									</li>
									<li>
										<a>Submenu 3</a>
									</li>
									<li>
										<a>Submenu 4</a>
									</li>
									<li>
										<a>Submenu 5</a>
									</li>
								</ul>
							</li>
							<li><a href="#">Plugin</a></li>
							<li><a href="#">Navigation</a></li>
							<li><a href="#">Here</a></li>
						</ul>
					</div>
				</div>
				
				<!--- TODO Figure out a widget system --->
				<div class="box">
					<h2>Plugin Widgets</h2>
					
					<div class="block">
						<p>
							Widgets about the plugin?
						</p>
					</div>
				</div>
			</div>
			
			<div class="grid_9">
				<cfinclude template="/cf-compendium/inc/resource/structure/markupGuide.cfm" />
			</div>
			
			<div class="clear"><!-- clear --></div>
		</div>
		
		<!--- TODO Include minified js file for production --->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script>
		<script type="text/javascript" src="../plugins/admin/script/admin.js"></script>
		<script type="text/javascript" src="../cf-compendium/script/form.js"></script>
		<script type="text/javascript" src="../cf-compendium/script/list.js"></script>
		<script type="text/javascript" src="../cf-compendium/script/datagrid.js"></script>
	</body>
</html>