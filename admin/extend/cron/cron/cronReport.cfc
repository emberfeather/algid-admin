component extends="plugins.cron.inc.resource.base.cron" {
	public void function execute(struct options = {}) {
		if(!structKeyExists(arguments.options, 'email') || !isValid('email', arguments.options.email)) {
			throw(message="No valid email provided", detail="The email was not provided or is invalid");
		}
		
		local.observer = getPluginObserver('admin', 'report');
		local.report = getModel('admin', 'report');
		
		// Generate the email message
		local.observer.generate(variables.transport, variables.datasource, variables.task, arguments.options, local.report);
		
		// Send the completed email
		if(!local.report.isBlank()) {
			mail from="#arguments.options.email#" to="#arguments.options.email#" subject="#local.report.getSubject()#" type="html" {
				writeOutput( local.report._toHtml() );
			};
		}
	}
}
