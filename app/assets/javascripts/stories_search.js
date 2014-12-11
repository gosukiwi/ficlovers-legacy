(function ($) {
  'use strict';

  var $fandoms = $('input[name=fandoms]').tagsInput({
    autocomplete_url: '/tags/search/fandoms'
  });
  var $characters = $('input[name=characters]').tagsInput({
    autocomplete_url: '/tags/search/characters'
  });

}(jQuery));
