$('.approve')
  .bind('ajax:success', function() {
    $(this).closest('tr').css('background-color', 'lightgreen').fadeOut();
  })
  //.bind('ajax:failure', function() {
  //  $(this).closest('tr').css('background-color', 'red');
  //})
  ;

$('.deny')
  .bind('ajax:success', function() {
    $(this).closest('tr').css('background-color', 'red').fadeOut();
  });
