{
	"applicationSingletons": {
		"viewMasterForAdmin": "plugins.admin.inc.view.viewMaster"
	},
	"applicationTransients": {
		"navigationForAdmin": "algid.inc.resource.structure.navigationFile",
		"profiler": "cf-compendium.inc.resource.utility.profiler",
		"searchResultsForAdmin": "plugins.admin.inc.resource.base.searchResults",
		"templateForAdmin": "algid.inc.resource.structure.template"
	},
	"forceSSL": true,
	"i18n": {
		"locales": [
			"en_PI",
			"en_US"
		]
	},
	"key": "admin",
	"path": "admin/",
	"plugin": "Administration",
	"prerequisites": {
		"algid": "0.1.3",
		"api": "0.1.0",
		"editor": "0.1.0"
	},
	"requestSingletons": {
	},
	"requestTransients": {
	},
	"rewrite": {
		"isEnabled": false,
		"base": "_base"
	},
	"search": {
		"threshold": 3
	},
	"sessionSingletons": {
	},
	"sessionTransients": {
	},
	"theme": "admin/extend/admin/theme/admin",
	"version": "0.1.12"
}