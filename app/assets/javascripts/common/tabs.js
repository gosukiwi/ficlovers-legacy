(function ($) {
  'use strict';

  $('.tabs').each(function (idx, el) {
    var $el     = $(el);
    var $active = $el.find('li.active');
    var $target = $( $active.data('for') ).show();

    $el.find('li').click(function(e) {
      e.preventDefault();
      $active.removeClass('active');
      $active = $(this).addClass('active');
      $target.hide();
      $target = $( $(this).data('for') ).show();
    });
  });

}(jQuery));
