component extends="algid.inc.resource.base.model" {
	public component function init(required component i18n, required string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Set the bundle information for translation
		add__bundle('plugins/admin/i18n/inc/model', 'modReportSection');
		
		// Content
		add__attribute(
			attribute = 'content'
		);
		
		// Title
		add__attribute(
			attribute = 'title',
			defaultValue = 'Admin Report'
		);
		
		return this;
	}
	
	public boolean function isBlank() {
		return !len(this.getContent());
	}
	
	public string function _toHTML() {
		local.html = '<h2>' & this.getTitle() & '</h2>';
		
		local.html &= this.getContent();
		
		return local.html;
	}
}
