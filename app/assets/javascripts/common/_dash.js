// _dash is a collection of minimal CSS + JS widgets for swift websites.
// @author Federico Ramirez
// @licence MIT
(function ($) {
  'use strict';

  // DROPDOWNS
  // ---------------------------------------------------------------------------
  // Turn all elements with `_dropdown` class into dropdown widgets.
  //
  // OPTIONS
  //  align: [left|center|right]
  //
  // Ex: <div class="_dropdown" data-align="center"></div>

  var $dropdowns = $('._dropdown').click(function (e) {
    e.preventDefault();
    e.stopPropagation();
    var $el = $(this);
    var $content = $el.find('._dropdown-content');
    $el.toggleClass('active');

    // Check for alignment option
    var align = $el.data('align');
    if(align === 'left') {
      $content.css('left', 0);
    } else if(align === 'right') {
      $content.css('right', 0);
    } else {
      $content.css('left', '-' + (($content.outerWidth() / 2) - ($el.outerWidth() / 2)) + 'px')
    }

    $content.click(function (e) { e.stopPropagation(); } );
    $content.find('a').click(function(e) { $dropdowns.removeClass('active'); });
  })

  $('html').click(function (e) {
    $dropdowns.removeClass('active');
  });

}(jQuery));
