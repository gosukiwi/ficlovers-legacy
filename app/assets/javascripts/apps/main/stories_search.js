(function ($) {
  'use strict';

  var $tags = $('input[name=tags]').tagsInput({
    autocomplete_url: '/tags/search'
  });

}(jQuery));
