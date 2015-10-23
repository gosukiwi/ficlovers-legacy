//= require tooltip
// Enable Bootstrap's tooltip
function setupTooltips() {
  $('[data-toggle="tooltip"]').tooltip()
}

$(document).ready(setupTooltips);
$(document).on('page:load', setupTooltips);
