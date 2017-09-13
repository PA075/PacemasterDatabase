(function( $ ){
    $.fn.overlay = function (msg, divid, fontSize, fromTop) {
        if (divid == 'undefined' || divid == '' || divid == null)
        {
            divid = '';
        }
        if (fontSize == '' || fontSize == null || fontSize == 'undefined')
        {
            fontSize = 15;
        }

        if (fromTop == 'undefined' || fromTop == '' || fromTop == null)
        {
            fromTop = '';
        }

    	var $t = $(this);
		if($t.length <= 0) return;
	  	var vzIndex;
	  	if($t.css('z-index') == "auto") vzIndex = "99999";
	  	else vzIndex = parseFloat($t.css('z-index')) + 1;
	  	//alert(divid);
	  	if (divid != '') {
	  	    //alert('hello');
	  	    var container = '#' + divid;
	  	}
	  	else {
	  	    //alert('ok');
	  	    var container = '#page-content-wrapper';
	  	}
	  	if (!$(container + " " + ".jqueryEasyOverlayDiv:last-child").length) {
		    var innerDiv = document.createElement('div');
		    //$(innerDiv).attr("class", "jqueryOverlayLoad").html("<div class='loader' style='font-size:" + fontSize + "px'><img class='front' src='../../../Content/img/logos.png'></div><div class='spintext'><span class='sr-only'>Loading...</span>&nbsp;<br/><span class='blink'>" + msg + "</span></div>");
		    $(innerDiv).attr("class", "jqueryOverlayLoad").html("<div class='loader' style='font-size:" + fontSize + "px'><img class='front' src='../../../Content/img/logos-overlay.png'></div><div class='spintext'><span class='sr-only'>Loading...</span>&nbsp;<br/><span class='blink' >" + msg + "</span></div>");
	  	    //$(innerDiv).attr("id", "jqueryOverlayLoad").html("<i class='fa fa-spinner fa-spin fa-3x fa-fw'></i><span class='sr-only'>Loading...</span>&nbsp;<br/><span class='blink'>" + msg + "</span>");
			var div = document.createElement('div');	
			$(div).css({
				display: "none"
			}).attr('class', "jqueryEasyOverlayDiv").append(innerDiv);
			var Parentdiv = document.createElement('div');
			//$(Parentdiv).css({
				//position: "relative"
			//})
			var yoursystemday = new Date(new Date().getTime() - (120000 * 60 + new Date().getTimezoneOffset() * 60000));
			//yoursystemday = new Date();
			var random = Math.round(Math.round(yoursystemday));
			$(Parentdiv).attr("id", random).append(div)
			$(container).append(Parentdiv);
		
		}
		//alert("#" + random + " " + ".jqueryEasyOverlayDiv");
		$("#" + random + " " + ".jqueryEasyOverlayDiv").css({
			opacity : 1,
			zIndex: vzIndex,
			top: fromTop,
		});
		var topOverlay = (($t.height()/2)-24);
		if(topOverlay < 0) topOverlay = 0;
		$("#" + random + " " + ".jqueryEasyOverlayDiv").fadeIn();
   	}; 
})(jQuery);
(function( $ ){
    $.fn.overlayout = function (divid) {
        if (divid == 'undefined' || divid == '' || divid == null)
        {
            divid = '';
        }

        if (divid != '') {
	  	    //alert('hello');
	  	    var container = '#' + divid;
	  	}
	  	else {
	  	    //alert('ok');
	  	    var container = '#page-content-wrapper';
	  	}
	    //if ($("#" + random + " " + ".jqueryEasyOverlayDiv").length)
	    //    $("#" + random + " " + ".jqueryEasyOverlayDiv").fadeOut();
	    //$("#" + random + " " + ".jqueryOverlayLoad").remove();
	    //$("#" + random + " " + ".jqueryEasyOverlayDiv").remove();

	    if ($(container+" "+".jqueryEasyOverlayDiv:last-child").length)
	        $(container + " " + ".jqueryEasyOverlayDiv:last-child").fadeOut();
	    $(container + " " + ".jqueryOverlayLoad:last-child").remove();
	    $(container + " " + ".jqueryEasyOverlayDiv:last-child").remove();
	    $(container + " " + ".jqueryEasyOverlayDiv:last-child").closest('div').remove();
   }; 
})(jQuery);
//(function( $ ){
//	$.overlayout = function() {
//	    if ($("#jqueryEasyOverlayDiv").length) $("#jqueryEasyOverlayDiv").fadeOut();
//	    $('#jqueryOverlayLoad').remove();
//	    $("#jqueryEasyOverlayDiv").remove();
//   }; 
//})(jQuery);