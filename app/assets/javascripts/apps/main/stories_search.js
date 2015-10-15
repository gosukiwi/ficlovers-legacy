(function ($) {
  'use strict';

  var $tags = $('input[name=tags]').tagsInput({
    autocomplete_url: '/tags/search',
    width: '100%',
    height: '60px',
  });

}(jQuery));
