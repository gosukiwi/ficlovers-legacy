/* global Backbone, bootstrap */
(function ($) {
  'use strict';

  // Set up CSRF token
  var token = $('meta[name="csrf-token"]').attr('content');
  $.ajaxSetup({
    beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });

  // Get app namespace or initialize
  var app = window.app || {};

  var initializers = {

    start: function() {
      this.writeView();
      this.autosave();
    },

    // Load the story from the bootstrap and set up the main view
    writeView: function () {
      this.story = new app.Story(bootstrap);
      new app.WriteView({
        el: '#write',
        model: this.story
      });
    },

    // Save once and fire up autosave
    autosave: function () {
      this.story.save();
      this.story.chapters.save();
      setTimeout($.proxy(this.autosave, this), 60 * 1000);
    },

  };

  initializers.start();

}(jQuery));
