/* global Backbone  */
(function () {
  'use strict';

  var app = window.app || {};

  app.WriteChapterView = Backbone.View.extend({

    initialize: function () {
      this.$list = this.$el.find('ol');

      this.listenTo(this.model, 'add', this.addOne);
      this.listenTo(this.model, 'remove', this.selectChapter);
      this.listenTo(this.model, 'reorder', this.render);

      this.render();
    },

    // Select the first chapter, if there aren't any, create an empty one.
    selectChapter: function () {
      this.model.getFirstAndSelect();
    },

    render: function () {
      this.$list.empty();
      this.model.each(this.addOne, this);
    },

    addOne: function (chapter) {
      var view = new app.WriteChapterItemView({ model: chapter });
      this.$list.append(view.render().el);
    },

    createChapter: function () {
      this.model.addChapter();
    },

    events: {
      'click .btn-add-chapter': 'createChapter'
    }

  });

  window.app = app;
}(jQuery));
