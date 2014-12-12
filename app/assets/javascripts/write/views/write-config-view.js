/* global Backbone */
(function ($) {
  'use strict';

  var app = window.app || {};

  app.WriteConfigView = Backbone.View.extend({

    initialize: function () {
      this.$text = this.$el.find('.write-config-panel');
    },

    events: {
      'click .btn-help': 'toggleHelp'
    },

    toggleHelp: function () {
      this.$text.toggleClass('hidden');
    }

  });

  window.app = app;
}(jQuery));
