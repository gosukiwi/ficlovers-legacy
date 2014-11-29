/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.Story = Backbone.Model.extend({
    defaults: {
      title: 'My Story',
      chapters: []
    },

    initialize: function () {
      var chapters = this.get('chapters');
      if(chapters) {
        this.chapters = new app.Chapters(chapters);
        this.chapters.setStoryId(this.get('id'));
        this.unset('chapters');
      }
    }
  });

  window.app = app;
}(jQuery));
