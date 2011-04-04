component extends="plugins.cron.inc.resource.base.cron" {
	public void function execute(struct options = {}) {
		if(!structKeyExists(arguments.options, 'email') || !isValid('email', arguments.options.email)) {
			throw(message="No valid email provided", detail="The email was not provided or is invalid");
		}
		
		local.viewReport = getView('admin', 'report');
		local.app = variables.transport.theApplication.managers.singleton.getApplication();
		local.plugin = variables.transport.theApplication.managers.plugin.getAdmin();
		local.observer = getPluginObserver('admin', 'report');
		local.report = getModel('admin', 'report');
		
		// Create the URL component
		local.webRoot =  app.getPath();
		local.requestRoot =  plugin.getPath();
		
		local.urlOptions = { start = 'http' & ( variables.transport.theCgi.server_port_secure eq true ? 's' : '' ) & '://' & variables.transport.theCgi.http_host & local.webRoot & local.requestRoot };
		
		local.rewrite = local.plugin.getRewrite();
		
		if(local.rewrite.isEnabled) {
			local.urlOptions.rewriteBase = local.rewrite.base;
			
			arguments.options.theUrl = variables.transport.theApplication.factories.transient.getUrlRewrite(variables.transport.theUrl, local.urlOptions);
		} else {
			arguments.options.theUrl = variables.transport.theApplication.factories.transient.getUrl(variables.transport.theUrl, local.urlOptions);
		}
		
		// Get the application title
		local.report.setSubject('Report: ' & local.app.getName());
		local.report.setTitle(local.app.getName());
		
		transaction {
			// Generate the email message
			local.observer.generate(variables.transport, variables.task, arguments.options, local.report);
			
			// Send the completed email
			if(!local.report.isBlank()) {
				mail from="#arguments.options.email#" to="#arguments.options.email#" subject="#local.report.getSubject()#" type="html" {
					writeOutput( local.viewReport.generateReport(local.report) );
				};
			}
		}
	}
}
