// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function() {
  alert(window.fbAppId);
  FB.init({appId: window.fbAppId, status: true, cookie: true, xfbml: true, permsToRequestOnConnect: 'email, offline_access'});
  
  // listen for session changes
  FB.Event.subscribe('auth.sessionChange', function(response) {
    window.location.reload();
    if (response.session) {
      // A user has logged in, and a new cookie has been saved
    } else {
      // The user has logged out, and the cookie has been cleared
    }
  });

  jQuery('.share_link').click(function() {
    FB.ui(
      {
        method: 'feed',
        name: 'Unicef',
        link: $(this).attr('title'),
        picture: 'http://www.unicef.org/images/fb_logo.png',
        description: 'UNICEF is awesome!',
        message: 'I just donated a crazy amount of money to UNICEF, you should too!'
      },
      function(response) {
        if (response && response.post_id) {
          //success!
        }
      }
    );
    
  });
});