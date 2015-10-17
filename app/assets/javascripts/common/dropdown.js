// Dropdowns
// @author Federico Ramirez
// @licence MIT
(function ($) {
  'use strict';

  // DROPDOWNS
  // ---------------------------------------------------------------------------
  // Turn all elements with the `dropdown` class into dropdown widgets.
  //
  // OPTIONS
  //  align: [left|center|right]
  //
  // Eg: 
  // <div class="dropdown" data-align="center">
  //
  //   <!-- There can be any HTML here -->
  //
  //   <div class="dropdown-content">
  //     Hello! I'm a dropdown message
  //   </div>
  // </div>

  var $dropdowns = $('.dropdown').click(function (e) {
    e.preventDefault();
    e.stopPropagation();
    var $el = $(this);
    var $content = $el.find('.dropdown-content');
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
