// _dash is a collection of minimal CSS + JS widgets for swift websites.
// @author Federico Ramirez
// @licence MIT

// Dropdowns
// ---------------------------------------------------------------------------
var dropdowns = $('._dropdown').click(function (e) {
  e.preventDefault();
  e.stopPropagation();
  $(this).toggleClass('active');
})

dropdowns.find('._dropdown-content').click(function (e) {
  e.stopPropagation();
});

$('html').click(function (e) {
  dropdowns.removeClass('active');
});
