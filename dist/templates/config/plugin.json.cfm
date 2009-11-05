{
	"applicationSingletons": {
		"viewMasterForAdmin": "plugins.admin.inc.view.viewMaster"
	},
	"applicationTransients": {
		"navigationForAdmin": "algid.inc.resource.structure.navigationFile",
		"profiler": "cf-compendium.inc.resource.utility.profiler",
		"templateForAdmin": "algid.inc.resource.structure.template",
		"urlForAdmin": "cf-compendium.inc.resource.utility.url"
	},
	"i18n": {
		"locales": [
			"en_PI",
			"en_US"
		]
	},
	"key": "@project.key@",
	"prerequisites": {
		"algid": "@prerequisites.algid@",
		"user": "@prerequisites.user@"
	},
	"sessionSingletons": {
	},
	"sessionTransients": {
	},
	"version": "@project.version.major@.@project.version.minor@.@project.version.build@"
}