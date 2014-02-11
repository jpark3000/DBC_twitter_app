$(document).ready(function() {

  $('#form').submit(function(event) {
    event.preventDefault();
    $('#tweets').html('<img src="ajax-loader.gif">');
    $.post('/twitter_user', $('#form').serialize(), function(data) {
      $('#tweets').html(data);
    });
  });

  $('#tweet-form').submit(function(event) {
    event.preventDefault();
    var tweet_data = $("#tweet-form").serialize();

    $('#tweet-form input').prop('disabled', true);
    $('#tweet-form submit').prop('disabled', true);
    $('#tweets').html('<img src="ajax-loader.gif">');

    $.post('/tweet', tweet_data, function(data) {
      $('#tweets').html(data);
      $('#tweet-form input').prop('disabled', false);
      $('#tweet-form submit').prop('disabled', false);
    });
    return false;
  });
});

