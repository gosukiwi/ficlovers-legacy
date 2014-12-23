/* global Backbone */
(function ($) {
  'use strict';

  var app = window.app || {};

  app.Chapter = Backbone.Model.extend({
    defaults: {
      title: null,
      content: 'Lorem ipsum dolor sit amet.',
      selected: false,
      order: 1
    },

    initialize: function () {
      if(null === this.get('title')) {
        this.set('title', 'Chapter ' + this.get('order'));
      }
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
