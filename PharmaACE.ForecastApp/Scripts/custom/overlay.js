/* 
 * overlay.js v1.1.0
 * Copyright 2014 Joah Gerstenberg (www.joahg.com)
 */
(function($) { 
  $.fn.overlay = function() {
    overlay = $('.overlay');
    overlay.ready(function() {
      overlay.on('transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', function(e) {
        if (!$(this).hasClass('shown')) return $(this).css('visibility', 'hidden');
      });
      overlay.on('show', function() {
        $(this).css('visibility', 'visible');
        $(this).addClass('shown');
        return true;
      });
      overlay.on('hide', function() {
          $(this).removeClass('shown');
          //$('.auto-style2').css("display", "block");
          //$('.tdNews').css("display", "block");
          $('.auto-style2').css("display", "");
          $('.tdNews').css("display", "");
        return true;
      });
      //overlay.on('click', function(e) {
      //    if (e.target.className === $(this).attr('class')) return $(this).trigger('hide');
      //    //$('.auto-style2').css("display", "block");
      //    //$('.tdNews').css("display", "block");
      //    $('.auto-style2').css("display", "");
      //    $('.tdNews').css("display", "");
      //})
      $('a[data-overlay-trigger=""]').on('click', function() {
        overlay.trigger('show');
      });
      $('a[data-overlay-trigger]:not([data-overlay-trigger=""])').on('click', function() {
        console.log($('.overlay#' + $(this).attr('data-overlay-trigger')))
        $('.overlay#' + $(this).attr('data-overlay-trigger')).trigger('show');
      });
    })
  };
})(jQuery);