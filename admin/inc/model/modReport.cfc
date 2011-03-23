component extends="algid.inc.resource.base.model" {
	public component function init(required component i18n, required string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Set the bundle information for translation
		add__bundle('plugins/admin/i18n/inc/model', 'modReport');
		
		// Subject
		add__attribute(
			attribute = 'subject',
			defaultValue = 'Admin Report'
		);
		
		// Title
		add__attribute(
			attribute = 'title',
			defaultValue = 'Admin Report'
		);
		
		// Sections
		add__attribute(
			attribute = 'sections',
			defaultValue = []
		);
		
		return this;
	}
	
	public boolean function isBlank() {
		return !arrayLen(this.getSections());
	}
	
	public string function _toHTML() {
		local.html = '<h1>' & this.getTitle() & '</h1>';
		
		local.sections = this.getSections();
		
		for(local.i = 1; local.i <= arrayLen(local.sections); local.i++) {
			local.html &= local.sections[local.i]._toHtml()
		}
		
		return local.html;
	}
}
