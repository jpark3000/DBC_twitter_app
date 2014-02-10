$(document).ready(function() {

  $('#form').submit(function(event) {
    event.preventDefault();
    $('#tweets').html('<img src="ajax-loader.gif">');
    $.post('/twitter_user', $('#form').serialize(), function(data) {
      $('#tweets').html(data);
    });
  });
});

