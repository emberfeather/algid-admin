/**
 * Admin JavaScript
 * 
 * Used to unobtrusively enhance the admin experience for the user.
 */
;(function($) {
	$( function() {
		// Init any datagrids
		$('.datagrid').datagrid();
		
		// Focus on the first input in the content.
		$('.content input[type=text]').focus();
		
		// Use the timeago plugin
		$('abbr.timeago').timeago();
	});
})(jQuery);
