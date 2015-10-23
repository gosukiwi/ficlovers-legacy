function setupTags() {
  var $tags = $('input[name=tags]').tagsInput({
    autocomplete_url: '/tags/search',
    width: '100%',
    height: '60px'
  });
}

$(document).ready(setupTags);
$(document).on('page:load', setupTags);
