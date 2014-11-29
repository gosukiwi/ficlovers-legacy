/* global Backbone, _ */
(function () {
  'use strict';

  var app = window.app || {};

  app.Chapters = Backbone.Collection.extend({

    comparator: 'order',

    initialize: function () {
      this.selected = null;

      this.on('change:selected', this.changeSelection);
      this.on('change:order', this.reorder);
    },

    setStoryId: function (id) {
      this.url = '/stories/' + id + '/chapters';
    },

    getFirstAndSelect: function () {
      var chapter = this.first();
      if(chapter === undefined) {
        chapter = new app.Chapter({ order: 1 });
        this.add(chapter);
      }
      chapter.select();
      return chapter;
    },

    select: function (chapter) {
      this.changeSelection(chapter);
    },

    save: function() {
      this.each(function(chapter) {
        chapter.save();
      });
    },

    changeSelection: function (chapter) {
      if(this.selected === chapter) {
        return;
      }

      if(this.selected !== null) {
        this.selected.set('selected', false, { silent: true });
        this.selected.trigger('was-selected');
      }

      chapter.set('selected', true, { silent: true });
      chapter.trigger('was-selected');
      this.selected = chapter;
      this.trigger('selected-changed', chapter);
    },

    reorder: function (chapter) {
      var newOrder = chapter.get('order');
      var oldOrder = chapter.previous('order');

      if(newOrder <= 0 || newOrder > this.length) {
        chapter.set('order', oldOrder, {silent:true});
        return;
      }

      var other = _.without(this.where({ order: newOrder }), chapter)[0];
      other.set('order', oldOrder, {silent: true});
      this.sort();
      this.trigger('reorder');
    },

    model: app.Chapter,

    deselectOld: function (chapter) {
      this
      .chain()
      .without(chapter)
      .each(function (c) {
        c.set('selected', false, { silent: true });
      });
    },

  });

  window.app = app;
}(jQuery));
