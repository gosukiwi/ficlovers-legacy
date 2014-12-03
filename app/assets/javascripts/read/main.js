/* global _ */
/**
 * Read UI for FicLovers
 */
(function () {
  'use strict';

  var $page = $('.read-story-content');
  var $content = $('<div />');
  var pages = [];
  var characters_per_page = 100;


  /**
   * Turns an HTML string into pages. A page is just a substring.
   */
  function paginate(content, pp) {
    var start = 0;
    pp = pp || characters_per_page;
    while(content.length > 0) {
      content.substring(start, pp);
    }
  }

  //_.each(chapters, function (chapter) {
  //  var content = '<h1>' + chapter.title + '<h1>' + chapter.content;
  //  pages.push(paginate(content));
  //});
}(jQuery));
