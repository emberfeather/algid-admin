component extends="algid.inc.resource.base.model" {
	/* required i18n */
	/* required locale */
	public component function init(component i18n, string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Category
		addAttribute(
				attribute = 'category'
			);
		
		// Description
		addAttribute(
				attribute = 'description'
			);
		
		// Link
		addAttribute(
				attribute = 'link'
			);
		
		// Title
		addAttribute(
				attribute = 'title'
			);
		
		// Set the bundle information for translation
		setI18NBundle('plugins/admin/i18n/inc/model', 'modSearchResult');
		
		return this;
	}
	
	public string function toHTML() {
		var html = '';
		var hasLink = this.getLink() neq '';
		
		html = '<dt>';
		
		if( hasLink ) {
			html = '<a href="' & htmlEditFormat(this.getLink()) & '">';
		}
		
		html &= this.getTitle();
		
		if( hasLink ) {
			html &= '</a>';
		}
		
		html &= '</dt>';
		
		html &= '<dd>' & this.getDescription() & '</dd>';
		
		return html;
	}
}
