(function($) {
  'use strict';

function prettyReader($reader) {
  var $chapters   = $reader.find('.chapter');
  var $btnNext    = $reader.find('#reader-btn-next');
  var $btnPrev    = $reader.find('#reader-btn-prev'); 
  var current     = 0;

  function initialize() {
    setupDOM();
    bindEvents();
  }

  function setupDOM() {
    // Hide all chapters and show first
    $chapters
      .hide()
      .first()
      .show()
    ;
  }

  function setChapterHash(idx) {
    window.location.hash = '/chapter-' + (idx + 1);
  }

  function selectChapter(idx) {
    $chapters.hide();
    $( $chapters.get(idx) ).show();
    $('body').animate({scrollTop: 0});
    setChapterHash(idx);

    if(idx === 0) {
      $btnPrev.hide();
    } else {
      $btnPrev.show();
    }

    if(idx >= $chapters.length - 1) {
      $btnNext.hide();
    } else {
      $btnNext.show();
    }

    // Set according chapter in chapter navigation
    $reader
      .find('[data-page]').parent().removeClass('active')
      .find('[data-page=' + idx + ']').parent().addClass('active');
  }

  function loadChapter() {
    var idx = window.location.hash ? (+window.location.hash.match(/chapter\-(\d+)/)[1]) - 1 : 0;

    if(idx >= $chapters.length) {
      idx = 0;
      setChapterHash(0);
    }
    current = idx;
    selectChapter(idx);
  }

  function bindEvents() {
    $btnPrev.click(function (e) {
      e.preventDefault();
      if(current === 0) {
        return;
      }

      current = current - 1;
      selectChapter(current);
    });

    $btnNext.click(function (e) {
      e.preventDefault();
      if(current + 1 === $chapters.length) {
        return;
      }

      current = current + 1;
      selectChapter(current);
    });

    $('.btn-chapter').click(function (e) {
      e.preventDefault();
      var $el = $(this);
      var idx = (+$el.data('page'));
      current = idx;
      selectChapter(idx);
    });

    $('.btn-set-theme').click(function (e) {
      e.preventDefault();
      var theme = $(this).text().toLowerCase();

      if(theme === 'dark') {
        $('body').addClass('dark');
      } else {
        $('body').removeClass('dark');
      }
    });

    $(window).ready(loadChapter);
  }

  return {
    initialize: initialize
  };
}

var $reader = $('.reader');
if($reader.length > 0) {
  var reader = prettyReader($reader);
  reader.initialize();
}

// Fic scroll
// ---------------------------------------------------------------------------
var raf = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
var buildFicScroll = function (idx, el) {
  var $el = $(el).unbind();
  var $p = $el.find('p');
  if($p.height() < $el.height()) return;

  var stop = false;
  var ammountToMove = $p.height() - $el.height();
  var speed = 25 / 1000;
  var lastStep = 0;
  var current = 0;

  function step(now) {
    if(stop) {
      lastStep = 0;
      current = 0;
      stop = false;
      return;
    }

    if(lastStep === 0) {
      lastStep = now;
      raf(step);
      return;
    }

    var delta = now - lastStep;
    lastStep = now;
    current = current + (speed * delta);

    if(current >= ammountToMove) {
      current = ammountToMove;
      stop = true;
    }

    $p.css('transform', 'translateY(-' + current + 'px)');
    raf(step);
  }

  $el.mouseenter(function () {
    stop = false;
    raf(step);
  });

  $el.mouseleave(function () {
    stop = true;
    $p.css('transform', 'translateY(0)');
  });
};

function setupFicScroll() {
  $('.fic-description').each(buildFicScroll);

  $(window).resize(_.debounce(function () {
    $('.fic-description').each(buildFicScroll);
  }, 200));
}

$(document).ready(setupFicScroll);
$(document).on('page:load', setupFicScroll);

}(jQuery));
