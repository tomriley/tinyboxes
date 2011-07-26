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
        link: $(this).attr('href'),
        name: $(this).attr('href'),
        picture: 'http://www.unicef.org/images/unicef_logo.gif',
        description: window.defaultDonateMessage,
        message: window.defaultDonateMessage+' '+$(this).attr('href')
      },
      function(response) {
        if (response && response.post_id) {
          //success!
        }
      }
    );
    return false;
  });
  
  jQuery('.big-button.tell').click(function() {
    FB.ui(
      {
        method: 'send',
        link: $(this).attr('href'),
        name: $(this).attr('href'),
        description: window.defaultDonateMessage,
        picture: 'http://www.unicef.org/images/unicef_logo.gif'
        //message: window.defaultDonateMessage+' '+$(this).attr('href')
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


function show_tweet_publish_popup(msg) {
  var url = "http://twitter.com/home?"+jQuery.param({status:msg});
  window.open(url, 'publish_tweet', 'toolbar=1,scrollbars=1,location=1,statusbar=1,menubar=1,resizable=1,width=500,height=400,left = 590,top = 325');
}