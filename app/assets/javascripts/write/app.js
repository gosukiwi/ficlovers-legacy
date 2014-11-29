/* global Backbone */

var bootstrap = {
  title: 'My TODO story!',
  chapters: [
    { title: 'Hinata\'s love', content: 'Some text...', order: 2 },
    { title: 'Hinata\'s eagerness', content: 'Some more text...', order: 1 },
    { title: 'Hinata\'s potato', content: 'Some more text...', order: 3 },
    { title: 'Hinata\'s rage', content: 'Some more text...', order: 4 },
    { title: 'Hinata\'s butt', content: 'Some more text...', order: 5 },
  ]
};

(function (/*$*/) {
  'use strict';

  var app = window.app || {};

  var appRouter = new (Backbone.Router.extend({

    initialize: function () {
      //TODO: story.fetch() instead of manually adding chapters.
      this.story = new app.Story(bootstrap);
      this.story.chapters.on('change:title', this.updateCurrentRoute, this);
      
      new app.WriteView({
        el: '#write',
        model: this.story
      });
    },

    start: function () {
      Backbone.history.start({ pushState: false });
    },

    routes: {
      'chapter/:name': 'showChapter',
    },

    updateCurrentRoute: function (chapter) {
      var title = decodeURIComponent(chapter.get('title'));
      this.navigate('chapter/' + title);
    },

    showChapter: function(name) {
      var chapter = this.story.chapters.findWhere({ title: name });
      if(chapter) {
        this.story.chapters.select(chapter);
      }
    },

  }))();

  appRouter.start();

}(jQuery));
