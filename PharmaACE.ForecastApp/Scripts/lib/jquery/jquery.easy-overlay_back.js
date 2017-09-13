(function( $ ){
    $.fn.overlay = function (msg) {
    	var $t = $(this);
		if($t.length <= 0) return;
	  	var vzIndex;
	  	if($t.css('z-index') == "auto") vzIndex = "99999";
	  	else vzIndex = parseFloat($t.css('z-index')) + 1;
	  	var container = $('#page-content-wrapper');
		if( !$("#jqueryEasyOverlayDiv").length ) {
		    var innerDiv = document.createElement('div');
		    $(innerDiv).attr("id", "jqueryOverlayLoad").html("<div class='loader'><img class='front' src='../../../Content/img/logos.png'></div><div class='spintext'><span class='sr-only'>Loading...</span>&nbsp;<br/><span class='blink'>" + msg + "</span></div>");
			//$(innerDiv).attr("id", "jqueryOverlayLoad").html("<i class='fa fa-spinner fa-spin fa-3x fa-fw'></i><span class='sr-only'>Loading...</span>&nbsp;<br/><span class='blink'>" + msg + "</span>");
			var div = document.createElement('div');	
			$(div).css({
				display: "none"
			}).attr('id',"jqueryEasyOverlayDiv").append(innerDiv);
			$("#page-content-wrapper").append(div);
		}
	  	$("#jqueryEasyOverlayDiv").css({
			opacity : 1,
		  	zIndex  : vzIndex,
		});
		var topOverlay = (($t.height()/2)-24);
		if(topOverlay < 0) topOverlay = 0;
		$("#jqueryEasyOverlayDiv").fadeIn();
   	}; 
})(jQuery);
(function( $ ){
	$.fn.overlayout = function() {
	    if ($("#jqueryEasyOverlayDiv").length) $("#jqueryEasyOverlayDiv").fadeOut();
        $('#jqueryOverlayLoad').remove();
	    $("#jqueryEasyOverlayDiv").remove();
   }; 
})(jQuery);
(function( $ ){
	$.overlayout = function() {
	    if ($("#jqueryEasyOverlayDiv").length) $("#jqueryEasyOverlayDiv").fadeOut();
	    $('#jqueryOverlayLoad').remove();
	    $("#jqueryEasyOverlayDiv").remove();
   }; 
})(jQuery);