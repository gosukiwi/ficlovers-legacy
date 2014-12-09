/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.WriteTagView = Backbone.View.extend({

    initialize: function (options) {
      var self = this;
      var tagList = _.chain(bootstrap.tags || [])
        .filter(function (tag) { return tag.context === options.context; })
        .pluck('name')
        .value();
      // Initialize tagsInput in this element, with the given options
      this.$el
        .tagsInput({
          autocomplete_url: '/search_tag/' + options.context
        })
        .importTags(tagList.join(','));
    },

  });

  window.app = app;
}(jQuery));
