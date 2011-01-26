component extends="algid.inc.resource.base.model" {
	public component function init(required component i18n, required string locale) {
		super.init(arguments.i18n, arguments.locale);
		
		// Category
		add__attribute(
				attribute = 'category'
			);
		
		// Description
		add__attribute(
				attribute = 'description'
			);
		
		// Link
		add__attribute(
				attribute = 'link'
			);
		
		// Title
		add__attribute(
				attribute = 'title'
			);
		
		// Set the bundle information for translation
		add__bundle('plugins/admin/i18n/inc/model', 'modSearchResult');
		
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
