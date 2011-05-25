/**
 * Admin JavaScript
 * 
 * Used to unobtrusively enhance the admin experience for the user.
 */
(function($) {
	$.algid = $.algid || {};
	
	$.algid.admin = {
		options: {
			base: {
				api: 'api/',
				url: '/'
			},
			search: {
				threshold: 5
			}
		}
	};
	
	$( function() {
		// Setup a cache for the search terms
		var searchCache = {};
		
		// Init any datagrids
		$('.datagrid').datagrid();
		
		// Focus on the first input in the content.
		$('.container-content :input:first').focus();
		
		// Disable submit buttons on submit
		$('form').submit(function(){
			$('input[type=submit]', this).attr('disabled', 'disabled');
		});
		
		// Use the timeago plugin
		$('.timeago').timeago();
		
		// Setup the admin search
		$('#adminSearch input[name=term]').searchComplete({
			source: function(request, response) {
				var i;
				
				// Check if the term has already been searched for
				if ( searchCache[ request.term ] !== undefined ) {
					response( searchCache[ request.term ] );
					
					return;
				}
				
				$.api({
					plugin: 'admin',
					service: 'search',
					action: 'search'
				}, {
					term: request.term
				}, {
					success: function( data ) {
						if(data.HEAD.result) {
							searchCache[ request.term ] = data.BODY;
							
							response( data.BODY );
						} else {
							response( [] );
						}
					}
				});
			},
			select: function(event, ui) {
				if (ui.item.link) {
					// Go to the search result link
					location.href = ui.item.link;
				}
			},
			minLength: 2
		});
		
		// Uses RFC 3339 Date Format
		$('.filter input[type="date"]').datepicker({ dateFormat: 'yy-mm-dd' });
		
		// Display any api messages triggered
		$('body').bind('api.errors api.warnings api.successes api.messages', function( event, type, alerts ) {
			var alert;
			
			for( alert in alerts ) {
				if(alerts.hasOwnProperty(alert)) {
					window.console.log(alerts[alert]);
				}
			}
		});
	});
	
	$.widget("custom.searchComplete", $.ui.autocomplete, {
		delay: 280,
		_renderMenu: function( ul, items ) {
			var self = this;
			var currentCategory = '';
			var currentCategoryCount = -1;
			
			$.each( items, function( index, item ) {
				var isDifferentCategory = item.category !== currentCategory;
				var isLastItem = index === items.length - 1;
				var isPastThreshold = currentCategoryCount >= $.algid.admin.options.search.threshold;
				
				// Check if the count is higher than the threshold and we are changing categories or ending
				if( isPastThreshold && isDifferentCategory ) {
					ul.append( "<li class='ui-autocomplete-more'>" + currentCategoryCount + " more...</li>" );
				}
				
				if ( isDifferentCategory ) {
					ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
					currentCategory = item.category;
					currentCategoryCount = -1;
				}
				
				currentCategoryCount++;
				
				if(currentCategoryCount < $.algid.admin.options.search.threshold) {
					item.label = item.title;
					item.value = item.title;
					
					self._renderItem( ul, item );
				}
				
				if( isPastThreshold && isLastItem ) {
					ul.append( "<li class='ui-autocomplete-more'>" + currentCategoryCount + " more...</li>" );
				}
			});
		}
	});
}(jQuery));
