/* global Backbone */
/**
 * Write View, most general view of the application, it's in charge of
 * orchestrating child views.
 */
(function () {
  'use strict';

  var app = window.app || {};

  app.WriteView = Backbone.View.extend({

    initialize: function () {
      this.setupChildViews();
      this.listenTo(this.model.chapters, 'selected-changed', this.setCurrentChapter);
      this.render();
    },

    setupChildViews: function () {
      var firstChapter = this.model.chapters.getFirstAndSelect();
      this.writeAreaView = new app.WriteAreaView({
        el: this.el,
        model: firstChapter
      });

      this.writeChapterView = new app.WriteChapterView({
        el: this.$el.find('.chapters'),
        model: this.model.chapters
      });

      this.writeConfigView = new app.WriteConfigView({
        el: this.$el.find('.write-config')
      });
    },

    setCurrentChapter: function (chapter) {
      this.writeAreaView.setModel(chapter);
    },

    render: function () {
      this.writeAreaView.render();
    },

    save: function () {
      this.model.chapters.save().then(this.onSaveSuccessful, this.onSaveError);
    },

    onSaveSuccessful: function () {
        $.jGrowl('Changes saved.');
    },

    onSaveError: function (data) {
      var json = data.responseJSON;
      var i;
      var len;
      console.log(json);
      Object.keys(json).forEach(function (key) {
        len = json[key].length;
        for(i = 0; i < len; i++) {
          $.jGrowl(key + ' ' + json[key], { sticky: true });
        }
      });
    },

    events: {
      'click .btn-save': 'save'
    }

  });

  window.app = app;
}(jQuery));
