/* global Backbone */
(function ($) {
  'use strict';

  var app = window.app || {};

  app.Chapter = Backbone.Model.extend({
    defaults: {
      title: 'My Chapter Title',
      content: 'Lorem ipsum dolor sit amet.',
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
