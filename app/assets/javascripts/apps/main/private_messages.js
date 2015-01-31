(function ($) {
  'use strict';

  // Convert new lines to proper paragraphs
  function nl2paras(text) {
    return _.map(text.split("\n"), function (para) {
      para = para.trim();
      if(para === '') return;
      return '<p>' + para + '</p>';
    });
  }

  var $pmView = $('.private-message-view');
  var $pmViewContainer = $('.private-message-view-container');

  $('.private-message-text').click(function () {
    var $el     = $(this);
    var replyId = (+$el.data('id'));
    var text    = nl2paras($el.find('.private-message-message').text());

    $pmView.html(text);
    $pmViewContainer.show();

    var $replyLink = $('.private-message-view-reply');
    var oldLink    = $replyLink.attr('href').split('?')[0];
    $replyLink.attr('href', oldLink + '?reply_id=' + replyId);
  });

  $('.private-message-close').click(function (e) {
    e.preventDefault();
    $pmViewContainer.hide();
  });

  // Compose autocomplete
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
