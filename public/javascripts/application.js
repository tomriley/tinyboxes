// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


jQuery(function() {
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