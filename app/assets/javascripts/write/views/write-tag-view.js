/* global Backbone */
(function () {
  'use strict';

  var app = window.app || {};

  app.WriteTagView = Backbone.View.extend({

    initialize: function (options) {
      var self = this;
      var tagList = _.chain(bootstrap.tags || [])
        .map(function (tag) { return tag.name + ' (' + tag.context + ')'; })
        .value();
      // Initialize tagsInput in this element, with the given options
      this.$el
        .tagsInput({
          autocomplete_url: '/tags/search',
          onChange: $.proxy(self.tagsChanged, self)
        })
        .importTags(tagList.join(','));
    },

    tagsChanged: function () {
      var tags = this.$el
        .val()
        .split(',');
      tags = _.map(tags, function (tag) {
        // Return either ['my tag'] or ['my tag', 'context']
        return tag.match(/^(.+?)(?:\((.+?)\))?$/).splice(1, 2);
      });

      this.model.set({ 'tags': tags });
    },

  });

  window.app = app;
}(jQuery));
