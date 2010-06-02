component extends="algid.inc.resource.base.service" {
	/* required currUser */
	/* required term */
	public component function search(component currUser, string term) {
		var observer = '';
		var results = '';
		
		// Get the event observer
		observer = getPluginObserver('admin', 'search');
		
		// Create a results object
		results = variables.transport.theApplication.factories.transient.getSearchResultsForAdmin();
		
		// On Search Event
		observer.onSearch(variables.transport, arguments.currUser, results, arguments.term);
		
		return results;
	}
}
