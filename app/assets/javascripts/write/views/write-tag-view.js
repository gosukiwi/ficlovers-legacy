/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.WriteTagView = Backbone.View.extend({

    initialize: function (options) {
      var self = this;
      this.$el.tagsInput({
        autocomplete_url: '/search_tag/' + options.context
      });
    },

  });

  window.app = app;
}(jQuery));
