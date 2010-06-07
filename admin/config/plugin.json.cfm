{
	"applicationSingletons": {
		"viewMasterForAdmin": "plugins.admin.inc.view.viewMaster"
	},
	"applicationTransients": {
		"apiSearchForAdmin": "plugins.admin.inc.api.apiSearch",
		"modSearchResultForAdmin": "plugins.admin.inc.model.modSearchResult",
		"navigationForAdmin": "algid.inc.resource.structure.navigationFile",
		"profiler": "cf-compendium.inc.resource.utility.profiler",
		"searchResultsForAdmin": "plugins.admin.inc.resource.base.searchResults",
		"templateForAdmin": "algid.inc.resource.structure.template",
		"servAppForAdmin": "plugins.admin.inc.service.servApp",
		"servSearchForAdmin": "plugins.admin.inc.service.servSearch",
		"urlForAdmin": "cf-compendium.inc.resource.utility.url",
		"viewAppForAdmin": "plugins.admin.inc.view.viewApp",
		"viewSearchForAdmin": "plugins.admin.inc.view.viewSearch"
	},
	"i18n": {
		"locales": [
			"en_PI",
			"en_US"
		]
	},
	"key": "admin",
	"path": "admin/",
	"prerequisites": {
		"algid": "0.1.1",
		"api": "0.1.0",
		"user": "0.1.1"
	},
	"requestSingletons": {
	},
	"requestTransients": {
	},
	"sessionSingletons": {
	},
	"sessionTransients": {
	},
	"theme": "admin/extend/admin/theme/admin",
	"version": "0.1.1"
}