component extends="algid.inc.resource.base.service" {
	public component function search(required string term) {
		var observer = '';
		var results = '';
		
		// Get the event observer
		observer = getPluginObserver('admin', 'search');
		
		// Create a results object
		results = variables.transport.theApplication.factories.transient.getSearchResultsForAdmin();
		
		// On Search Event
		observer.onSearch(variables.transport, results, arguments.term);
		
		return results;
	}
}
