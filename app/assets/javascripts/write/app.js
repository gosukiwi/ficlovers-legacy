/* global Backbone, bootstrap */
(function (/*$*/) {
  'use strict';

  // Set up CSRF token
  var token = $('meta[name="csrf-token"]').attr('content');
  $.ajaxSetup({
    beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });

  // Get app namespace or initialize
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
