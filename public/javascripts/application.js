// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function() {
  FB.init({appId: window.fbAppId, status: true, cookie: true, xfbml: true});
  
  // listen for session changes
  FB.Event.subscribe('auth.sessionChange', function(response) {
    if (response.session) {
      if (!window.loggedIn) {
        window.location.reload();
      }
      // A user has logged in, and a new cookie has been saved
    } else {
      // The user has logged out, and the cookie has been cleared
    }
  });

  jQuery('.big-button.share').click(function() {
    FB.ui(
      {
        method: 'feed',
        name: 'Unicef',
        link: $(this).attr('title'),
        picture: 'http://www.unicef.org/images/fb_logo.png',
        description: 'UNICEF is awesome!',
        message: window.defaultDonateMessage
      },
      function(response) {
        if (response && response.post_id) {
          //success!
        }
      }
    );
    return false;
  });
});