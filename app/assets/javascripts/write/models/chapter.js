/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.Chapter = Backbone.Model.extend({
    defaults: {
      title: 'Chapter Title...',
      content: 'Chapter content...',
      selected: false,
      order: 1
    },

    select: function () {
      this.set('selected', true);
      return this; // make it chainable
    },

    moveUp: function () {
      this.set('order', this.get('order') - 1);
    },

    moveDown: function () {
      this.set('order', this.get('order') + 1);
    },
  });

  window.app = app;
}(jQuery));
