/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.Story = Backbone.Model.extend({
    defaults: {
      title: 'My Story',
      chapters: []
    },

    save: function () {
      console.log('called save');
      // save tags
      $.ajax({
        url: '/stories/' + this.get('id') + '/update_tags',
        method: 'post',
        dataType: 'json',
        data: {
          _method: 'put',
          fandom: this.get('fandom_tags') || [],
          character: this.get('character_tags') || [],
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
    }
  });

  window.app = app;
}(jQuery));
