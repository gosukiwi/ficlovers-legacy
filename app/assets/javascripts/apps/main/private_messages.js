(function ($) {
  'use strict';

  $('.private-message-text').click(function () {
    var $el = $(this);
    $('.private-message-view').text($el.text());
  });

  var cache = [];

  $('#private_message_receiver').autocomplete({ 
    minLength: 2,
    source: function (req, res) {
      var term = req.term;
      if(term in cache) {
        res(cache[term]);
        return;
      }

      $.get('/u/search', req, function (data) {
        cache[term] = data;
        res(data);
      });
    }
  });
}(jQuery));
