//= require daimon_news_gatekeeper_config

jQuery(function($) {

  var postElement = $('article.post');

  if (postElement.length === 0) {
    return;
  }

  var config = daimonNewsGatekeeperConfig;

  var signInUrl = config.sign_in_url;
  var signInStatusUrl = config.sign_in_status_url;

  var displayPostBody = function() {
    $('.loading-indicator-container').css('display', 'none');
    $('article.post').css('display', 'block');
  };

  var loadingHtml = '<div class="loading-indicator-container">'
                        + '<div class="' + config.indicator_type + ' loading-indicator">' + config.loading_message + '</div>'
                        + '<div class="loading-indicator-text">' + config.loading_message + '</div>'
                    + '</div>';
  postElement.after(loadingHtml);

  if(!signInUrl || !signInStatusUrl) {
    displayPostBody();
    return;
  }

  if ($('#preview-notification').length >= 1) {
    displayPostBody();
    return;
  }

  $.ajax({
    type: 'GET',
    url: signInStatusUrl,
    xhrFields: {
      withCredentials: true
    }
  }).then(function(isSignedIn) {
    if (isSignedIn) {
      displayPostBody();
      return;
    }

    var userOnlyMatcher = new RegExp(config.member_only_keyword);

    var isUSerOnly = $('.post__body').html().match(userOnlyMatcher) !== null;

    if (isUSerOnly) {
      var current_path = window.location.href;
      location.href = signInUrl + '?' + config.parameter_name_to_return + '=' + current_path;
    } else {
      displayPostBody();
    }
  })

})