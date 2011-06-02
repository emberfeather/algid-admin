component extends="algid.inc.resource.base.service" {
	public string function getEnvironment() {
		local.app = variables.transport.theApplication.managers.singleton.getApplication();
		
		return local.app.getEnvironment();
	}
	
	public void function setEnvironment(required string environment) {
		local.observer = getPluginObserver('admin', 'environment');
		
		observer.beforeUpdate(variables.transport, arguments.environment);
		
		// Only changes the environment temporarily, is reset on reinit
		local.app = variables.transport.theApplication.managers.singleton.getApplication();
		local.app.setEnvironment(arguments.environment);
		
		observer.afterUpdate(variables.transport, arguments.environment);
	}
}
