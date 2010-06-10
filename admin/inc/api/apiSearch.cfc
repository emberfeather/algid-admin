component extends="plugins.api.inc.resource.base.api" {
	public component function search() {
		var i = '';
		var servSearch = '';
		var results = '';
		
		// Validate required arguments
		if( !structKeyExists(variables.apiRequestBody, 'term') || !len(trim(variables.apiRequestBody.term)) ) {
			throw('validation', 'Missing search term', 'The search requires a non-blank search term');
		}
		
		servSearch = variables.transport.theApplication.factories.transient.getServSearchForAdmin(variables.transport.theApplication.managers.singleton.getApplication().getDSUpdate(), variables.transport);
		
		// Retrieve the search results
		results = servSearch.search( variables.transport.theSession.managers.singleton.getUser(), variables.apiRequestBody.term);
		
		// Get the array of results from the search results
		variables.apiResponseBody = results.getResults();
		
		// TODO Remove once the _toJSON is recognized by Railo
		for (i = 1; i <= arrayLen(variables.apiResponseBody); i++) {
			variables.apiResponseBody[i] = deserializeJSON(variables.apiResponseBody[i]._toJSON());
		}
		
		// Send back some of the request
		variables.apiResponseHead['term'] = variables.apiRequestBody.term;
		
		return getApiResponse();
	}
}
