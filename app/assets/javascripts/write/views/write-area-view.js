/* global Backbone, MediumEditor */
(function ($) {
  'use strict';

  var app = window.app || {};

  app.WriteAreaView = Backbone.View.extend({

    initialize: function () {
      // Cache elements
      this.$title = this.$el.find('.write-area-title');
      this.$text = this.$el.find('.write-area-text');
      this.$writeArea = this.$el.find('.write-area');

      new MediumEditor(this.$el.find('.write-area-text').get(0));

      //this.listenTo(this.model, 'change', this.render);
      this.render();
    },

    setModel: function(model) {
      //this.stopListening(this.model);
      this.model = model;
      //this.listenTo(model, 'change', this.render);
      this.render();
    },

    render: function () {
      this.$title.val( this.model.get('title') );
      this.$text.html( this.model.get('content') );
    },

    events: {
      'keyup .write-area-title': function () {
        this.model.set('title', this.$title.val());
      },

      'input .write-area-text': function () {
        this.model.set('content', this.$text.html());
      },
    }

  });

  window.app = app;
}(jQuery));
