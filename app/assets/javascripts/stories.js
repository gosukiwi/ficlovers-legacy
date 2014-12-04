function prettyReader($reader) {
  var $chapters   = $reader.find('.chapter');
  var $pagination = $reader.find('#reader-pagination');
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
      .addClass('hidden')
      .first()
      .removeClass('hidden');
    // Set up pagination
    var html = '';
    for(var i = 0; i < $chapters.length; i++) {
      html += '<li><a href="#" data-page="'+i+'">' + (i + 1) + '</a></li>';
    }
    $pagination.html(html);
  }

  function setChapterHash(idx) {
    window.location.hash = '/chapter-' + (idx + 1);
  }

  function selectChapter(idx) {
    $chapters.addClass('hidden');
    $( $chapters.get(idx) ).removeClass('hidden');
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

    // Set .active class for pagination
    $pagination.find('.active').removeClass('active');
    $pagination.find('a[data-page=' + idx + ']').parent().addClass('active');
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

    $pagination.find('a').click(function (e) {
      e.preventDefault();
      var $el = $(this);
      var idx = (+$el.data('page'));
      current = idx;
      selectChapter(idx);
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
