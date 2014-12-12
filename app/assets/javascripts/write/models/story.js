/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.Story = Backbone.Model.extend({
    defaults: {
      title: 'My Story',
      published: false,
      chapters: []
    },

    saveTags: function () {
      console.log('called save');
      // save tags
      $.ajax({
        url: '/stories/' + this.get('id') + '/update_tags',
        method: 'post',
        dataType: 'json',
        data: {
          _method: 'put',
          tags: this.get('tags') || []
        }
      });
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
