/* global Backbone, _ */
(function ($) {
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

    // Gets the first chapter, creating one if there isn't any, selects it and
    // returns it.
    getFirstAndSelect: function () {
      if(this.length === 0) {
        this.addChapter();
      }

      return this.first().select();
    },

    // Adds a new chapter to the collection with the appropiate order
    addChapter: function () {
      this.add(new app.Chapter({ order: this.length + 1 }));
    },

    select: function (chapter) {
      this.changeSelection(chapter);
    },

    save: function() {
      var promises = [];
      this.each(function(chapter) {
        promises.push(chapter.save());
      });
      return $.when.apply(this, promises);
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
