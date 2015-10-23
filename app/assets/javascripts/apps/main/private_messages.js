(function ($) {
  'use strict';

  // Convert new lines to proper paragraphs
  //function nl2paras(text) {
  //  return _.map(text.split("\n"), function (para) {
  //    para = para.trim();
  //    if(para === '') return;
  //    return '<p>' + para + '</p>';
  //  });
  //}

  // Compose autocomplete
  var cache = [];

  function autocompletePrivateMessageReceiver() {
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
  }

  $(document).ready(autocompletePrivateMessageReceiver)
  $(document).on('page:load', autocompletePrivateMessageReceiver);

}(jQuery));
