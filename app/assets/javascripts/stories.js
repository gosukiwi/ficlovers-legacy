function dynamicReader() {
  var $reader   = $('.reader');
  var $chapters = $reader.find('.chapter');
  var $btnNext  = $('#reader-btn-next');
  var $btnPrev  = $('#reader-btn-prev'); 

  $chapters
    .addClass('hidden')
    .first()
    .removeClass('hidden');

  var current = 0;

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

  // Event binding
  // --------------------------------------------------------------------------
  function bind () {
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

    $(window).ready(loadChapter);
  }

  bind();
}

if($('.reader').length > 0) {
  dynamicReader();
}
