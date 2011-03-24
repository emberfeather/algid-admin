component extends="plugins.cron.inc.resource.base.cron" {
	public void function execute(struct options = {}) {
		if(!structKeyExists(arguments.options, 'email') || !isValid('email', arguments.options.email)) {
			throw(message="No valid email provided", detail="The email was not provided or is invalid");
		}
		
		local.viewReport = getView('admin', 'report');
		local.app = variables.transport.theApplication.managers.singleton.getApplication();
		local.observer = getPluginObserver('admin', 'report');
		local.report = getModel('admin', 'report');
		
		// Get the application title
		local.report.setSubject('Report: ' & local.app.getName());
		local.report.setTitle(local.app.getName());
		
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
