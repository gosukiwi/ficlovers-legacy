/* global Backbone, Hogan, confirm */
(function () {
  'use strict';

  var app = window.app || {};

  app.WriteChapterItemView = Backbone.View.extend({

    initialize: function () {
      this.listenTo(this.model, 'change:title', this.render);
      this.listenTo(this.model, 'destroy', this.remove);
      this.listenTo(this.model, 'was-selected', this.render);
    },

    template: Hogan.compile($('#tpl-chapter').html()),

    render: function () {
      this.$el.html(this.template.render({ chapter: this.model.attributes }));
      return this;
    },

    events: {
      'click .btn-up': function () {
        this.model.moveUp();
      },

      'click .btn-down': function () {
        this.model.moveDown();
      },

      'click .btn-delete': function () {
        if(confirm('Are you sure you want to delete this chapter?')) {
          this.model.destroy();
        }
      }
    }

  });

  window.app = app;
}(jQuery));
