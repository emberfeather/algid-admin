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
				// Check if the term has already been searched for
				if ( request.term in searchCache ) {
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
		
		// Display any api messages triggered
		$('body').bind('api.errors api.warnings api.successes api.messages', function( event, type, alerts ) {
			var alert;
			
			for( alert in alerts ) {
				if(alerts.hasOwnProperty(alert)) {
					$.jGrowl(alerts[alert]);
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

(function($){$.jGrowl=function(m,o){if($('#jGrowl').size()==0)
$('<div id="jGrowl"></div>').addClass((o&&o.position)?o.position:$.jGrowl.defaults.position).appendTo('body');$('#jGrowl').jGrowl(m,o);};$.fn.jGrowl=function(m,o){if($.isFunction(this.each)){var args=arguments;return this.each(function(){var self=this;if($(this).data('jGrowl.instance')==undefined){$(this).data('jGrowl.instance',$.extend(new $.fn.jGrowl(),{notifications:[],element:null,interval:null}));$(this).data('jGrowl.instance').startup(this);}
if($.isFunction($(this).data('jGrowl.instance')[m])){$(this).data('jGrowl.instance')[m].apply($(this).data('jGrowl.instance'),$.makeArray(args).slice(1));}else{$(this).data('jGrowl.instance').create(m,o);}});};};$.extend($.fn.jGrowl.prototype,{defaults:{pool:0,header:'',group:'',sticky:false,position:'top-right',glue:'after',theme:'default',themeState:'highlight',corners:'10px',check:250,life:3000,closeDuration:'normal',openDuration:'normal',easing:'swing',closer:true,closeTemplate:'&times;',closerTemplate:'<div>[ close all ]</div>',log:function(e,m,o){},beforeOpen:function(e,m,o){},afterOpen:function(e,m,o){},open:function(e,m,o){},beforeClose:function(e,m,o){},close:function(e,m,o){},animateOpen:{opacity:'show'},animateClose:{opacity:'hide'}},notifications:[],element:null,interval:null,create:function(message,o){var o=$.extend({},this.defaults,o);if(typeof o.speed!=='undefined'){o.openDuration=o.speed;o.closeDuration=o.speed;}
this.notifications.push({message:message,options:o});o.log.apply(this.element,[this.element,message,o]);},render:function(notification){var self=this;var message=notification.message;var o=notification.options;var notification=$('<div class="jGrowl-notification '+o.themeState+' ui-corner-all'+
((o.group!=undefined&&o.group!='')?' '+o.group:'')+'">'+'<div class="jGrowl-close">'+o.closeTemplate+'</div>'+'<div class="jGrowl-header">'+o.header+'</div>'+'<div class="jGrowl-message">'+message+'</div></div>').data("jGrowl",o).addClass(o.theme).children('div.jGrowl-close').bind("click.jGrowl",function(){$(this).parent().trigger('jGrowl.close');}).parent();$(notification).bind("mouseover.jGrowl",function(){$('div.jGrowl-notification',self.element).data("jGrowl.pause",true);}).bind("mouseout.jGrowl",function(){$('div.jGrowl-notification',self.element).data("jGrowl.pause",false);}).bind('jGrowl.beforeOpen',function(){if(o.beforeOpen.apply(notification,[notification,message,o,self.element])!=false){$(this).trigger('jGrowl.open');}}).bind('jGrowl.open',function(){if(o.open.apply(notification,[notification,message,o,self.element])!=false){if(o.glue=='after'){$('div.jGrowl-notification:last',self.element).after(notification);}else{$('div.jGrowl-notification:first',self.element).before(notification);}
$(this).animate(o.animateOpen,o.openDuration,o.easing,function(){if($.browser.msie&&(parseInt($(this).css('opacity'),10)===1||parseInt($(this).css('opacity'),10)===0))
this.style.removeAttribute('filter');$(this).data("jGrowl").created=new Date();$(this).trigger('jGrowl.afterOpen');});}}).bind('jGrowl.afterOpen',function(){o.afterOpen.apply(notification,[notification,message,o,self.element]);}).bind('jGrowl.beforeClose',function(){if(o.beforeClose.apply(notification,[notification,message,o,self.element])!=false)
$(this).trigger('jGrowl.close');}).bind('jGrowl.close',function(){$(this).data('jGrowl.pause',true);$(this).animate(o.animateClose,o.closeDuration,o.easing,function(){$(this).remove();var close=o.close.apply(notification,[notification,message,o,self.element]);if($.isFunction(close))
close.apply(notification,[notification,message,o,self.element]);});}).trigger('jGrowl.beforeOpen');if(o.corners!=''&&$.fn.corner!=undefined)$(notification).corner(o.corners);if($('div.jGrowl-notification:parent',self.element).size()>1&&$('div.jGrowl-closer',self.element).size()==0&&this.defaults.closer!=false){$(this.defaults.closerTemplate).addClass('jGrowl-closer ui-state-highlight ui-corner-all').addClass(this.defaults.theme).appendTo(self.element).animate(this.defaults.animateOpen,this.defaults.speed,this.defaults.easing).bind("click.jGrowl",function(){$(this).siblings().trigger("jGrowl.beforeClose");if($.isFunction(self.defaults.closer)){self.defaults.closer.apply($(this).parent()[0],[$(this).parent()[0]]);}});};},update:function(){$(this.element).find('div.jGrowl-notification:parent').each(function(){if($(this).data("jGrowl")!=undefined&&$(this).data("jGrowl").created!=undefined&&($(this).data("jGrowl").created.getTime()+parseInt($(this).data("jGrowl").life))<(new Date()).getTime()&&$(this).data("jGrowl").sticky!=true&&($(this).data("jGrowl.pause")==undefined||$(this).data("jGrowl.pause")!=true)){$(this).trigger('jGrowl.beforeClose');}});if(this.notifications.length>0&&(this.defaults.pool==0||$(this.element).find('div.jGrowl-notification:parent').size()<this.defaults.pool))
this.render(this.notifications.shift());if($(this.element).find('div.jGrowl-notification:parent').size()<2){$(this.element).find('div.jGrowl-closer').animate(this.defaults.animateClose,this.defaults.speed,this.defaults.easing,function(){$(this).remove();});}},startup:function(e){this.element=$(e).addClass('jGrowl').append('<div class="jGrowl-notification"></div>');this.interval=setInterval(function(){$(e).data('jGrowl.instance').update();},parseInt(this.defaults.check));if($.browser.msie&&parseInt($.browser.version)<7&&!window["XMLHttpRequest"]){$(this.element).addClass('ie6');}},shutdown:function(){$(this.element).removeClass('jGrowl').find('div.jGrowl-notification').remove();clearInterval(this.interval);},close:function(){$(this.element).find('div.jGrowl-notification').each(function(){$(this).trigger('jGrowl.beforeClose');});}});$.jGrowl.defaults=$.fn.jGrowl.prototype.defaults;})(jQuery);