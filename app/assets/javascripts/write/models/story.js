/* global Backbone */
(function ($) {
  'use strict';

  var app = window.app || {};

  app.Story = Backbone.Model.extend({
    defaults: {
      title: 'My Story',
      published: false,
      chapters: []
    },

    initialize: function () {
      var chapters = this.get('chapters');
      if(chapters) {
        this.chapters = new app.Chapters(chapters);
        this.chapters.setStoryId(this.get('id'));
        this.unset('chapters');
      }

      var self = this;
      this.url = function () {
        return '/stories/' + self.get('id');
      };
    }
  });

  window.app = app;
}(jQuery));
