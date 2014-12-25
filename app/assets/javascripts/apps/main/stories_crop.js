(function ($) {
  'use strict';

  $('#crop-thumb').Jcrop({
    aspectRatio: 10/2,
    setSelect: [100, 100, 500, 50],
    onChange: updateCoords,
    onSelect: updateCoords
  });

  function updateCoords(c) {
    $('#x1').val(c.x);
    $('#y1').val(c.y);
    $('#w').val(c.w);
    $('#h').val(c.h);
  }

  $('.crop-button').click(function () {
    $('form').submit();
  });
}(jQuery));
