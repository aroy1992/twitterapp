<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page
	import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.FetchOptions"%>
<%@ page import="com.google.appengine.api.datastore.Key"%>
<%@ page import="com.google.appengine.api.datastore.KeyFactory"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="java.util.List"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page
	import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-153794668-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-149651524-1');
</script>


<meta charset="utf-8">
<title>Tweetbook</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">



<link href="./css/bootstrap.min.css" media="all" type="text/css"
	rel="stylesheet">
<link href="./css/bootstrap-responsive.min.css" media="all"
	type="text/css" rel="stylesheet">
<link href="./css/font-awesome.css" rel="stylesheet">
<link href="./css/nav-fix.css" media="all" type="text/css"
	rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



</head>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
</style>
<body class="w3-light-grey">
<div id="fb-root"></div>
<script>

(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

function statusChangeCallback(response) {
console.log('statusChangeCallback');
console.log(response);

if (response.status === 'connected') {

var msg=document.getElementById('main_tweet_db');
msg.style.display='';
var login_div=document.getElementById('status');
login_div.style.display='none';
testAPI();
} 
else if (response.status === 'not_authorized') {

var msg=document.getElementById('main_tweet_db');
msg.style.display='none';
var profile=document.getElementById('profile_link');
profile.style.display='none';
document.cookie = "userid=" ;
document.cookie = "username=";
} else {

var msg=document.getElementById('main_tweet_db');
msg.style.display='none';
var profile=document.getElementById('profile_link');
msg.style.display='none';
document.cookie = "userid=" ;
document.cookie = "username=";
}
}
var login_event = function(response) {
	var msg=document.getElementById('main_tweet_db');
	msg.style.display='';
	var login_div=document.getElementById('status');
	login_div.style.display='none';
}
var logout_event = function(response) {
	var msg=document.getElementById('main_tweet_db');
	msg.style.display='none';
	var profile=document.getElementById('profile_link');
	msg.style.display='none';
	var login_div=document.getElementById('status');
	login_div.style.display='';
	document.cookie = "userid=" ;
	document.cookie = "username=";
}

  	function checkLoginState() {
    	FB.getLoginStatus(function(response) {
      	statusChangeCallback(response);
    	});
  	}
	window.fbAsyncInit = function() {
    FB.init({
   		appId      : '2648637625218654',
      	cookie     : true,  // enable cookies to allow the server to access       
      	xfbml      : true,
      	version    : 'v5.0'
    });  
FB.getLoginStatus(function(response) {
	    statusChangeCallback(response);
	  });
FB.Event.subscribe('auth.statusChange', function(response) {
    if (response.status === 'connected') {
                  //the user is logged and has granted permissions
       login_event();
    } else if (response.status === 'not_authorized') {
          //ask for permissions
         logout_event();
    } else {
    	logout_event();
          //ask the user to login to facebook
    }
});
	  };	  

   
	  var post = function() {
			var text = document.getElementById('tweet_text').value;
			console.log("value of text id " + text);
			var url = "https://www.facebook.com/dialog/share?app_id=2648637625218654&href=https://project1-test-260621.appspot.com/"
	        url = url + "&quote=" + text;
			window.open(url);
		}

// Here we run a very simple test of the Graph API after login is
// successful. See statusChangeCallback() for when this call is made.
function share() {
		var tweet_text = document.getElementById('tweet_text').value;
		var userid = document.getElementById('userid').value;
		var username = document.getElementById('username').value;
		var picture = document.getElementById('picture').value;
		var msg_tweet = "true";

		var post_data = {
			  tweet_text: tweet_text,
			  userid: userid  , 
			  username: username,
			 picture: picture,
			 msg_tweet : "true"
		};
		$.post("Tweet", post_data, function(data) {
			console.log(data);
			var key = data;
			var url = window.location.href ;
			if (url.search("localhost")!==-1) {
				url = "https://facebook.com/";
			}
			var share_url = url + "view_tweet.jsp?tweet_key=" + key ;
			var url = "https://www.facebook.com/dialog/send?app_id=2648637625218654";
		    url = url + "&link=" + share_url;
		    url = url + "&redirect_uri=https://apps.facebook.com/2648637625218654/?fb_source=feed";
		    window.open(url);
	} );
	
	


}
var profile_url = "";
function testAPI() {
	console.log('Welcome! Fetching your information.... ');
	FB.api('/me', function(response) {
		console.log('Successful login for: ' + response.name);
		console.log('response is ' + JSON.stringify(response));
		document.getElementById('profile_pic').innerHTML = '<a href="#" class="thumbnail"><img src="http://graph.facebook.com/' + response.id + '/picture?type=large" /></a>';
		document.getElementById('fullname').innerText = response.name;
		document.getElementById('fullname_head').innerText = response.name;
		document.getElementById('whatsup').innerText = 'What\'s happening ' + response.name;
		document.getElementById('profile_link').href = 'https://facebook.com/' + response.id;
		profile_url = 'https://facebook.com/' + response.id;
		localStorage.profile_url = profile_url;
		document.getElementById('picture').value = 'http://graph.facebook.com/' + response.id + '/picture';
		document.getElementById('userid').value =  response.id;
		document.getElementById('username').value =  response.name.split(" ")[0];
		document.cookie = "userid=" + response.id;
		document.cookie = "username=" + response.name.split(" ")[0];
		document.cookie = "profile=" + "https://facebook.com/" + response.id;
		document.cookie = "picture=" + "http://graph.facebook.com/" + response.id + "/picture?type=large";
	});
}
</script>


	<% Cookie[] cookies = request.getCookies();
	String userid="", username="",picture="";
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookie.getName().equals("userid")) {
				userid = cookie.getValue();
			}
			if (cookie.getName().equals("username")) {
				username = cookie.getValue();
			}
			if (cookie.getName().equals("picture")) {
				picture = cookie.getValue();
			}
		}
	}
	
	%>
	<div class="w3-bar w3-white w3-large">
  		<b><a href="#" class="w3-bar-item w3-button w3-red w3-mobile">Tweetbook</a></b>
  		<a href="#" class="w3-bar-item w3-button w3-mobile">Home</a>
  		<a href="./friends.jsp" class="w3-bar-item w3-button w3-mobile">Friends Tweet</a>
 		 <a href="./friends_top_tweets.jsp" class="w3-bar-item w3-button w3-mobile">Top Tweets of Friends</a>
 		 <div class="btn-group pull-right" id="welcome">
					Welcome, <strong><a id="fullname"> </a> </strong>
					<fb:login-button autologoutlink="false"
						scope="public_profile,email" onlogin="checkLoginState();">
					</fb:login-button>

					<div class="fb-share-button"
						data-href="https://developers.facebook.com/docs/plugins/"
						data-layout="button_count" data-size="small">
						<a target="_blank"
							href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse"
							class="fb-xfbml-parse-ignore">Share</a>
					</div>
		</div>
	</div>
	<div class="w3-container w3-margin-top" id="rooms">
    <h3>Welcome to Tweetbook!</h3>
  </div>

	<div id="main_tweet_db" class="container" style="display: none;">
		<div class="row">
			<div class="span4 offset4">
				<p id="whatsup" class="lead"></p>
				<div class="row">
					 <div class="w3-container" id="contact">
						    <form method="post" action="Tweet" name="post_tweet"
							id="post_tweet" accept-charset="UTF-8">
								<input type="hidden" name="userid" id="userid" value="" /> <input
								type="hidden" name="username" id="username" value="" /> <input
								type="hidden" name="picture" id="picture" value="" />
								<textarea class="span4" id="tweet_text" name="tweet_text"
								rows="5" placeholder="Type in your new tweet"></textarea>
								<input type="submit" name="post_btn" value="Post New Tweet"
								class="btn btn-info" onclick="post()" /> <input type="button"
								name="share_btn" value="Share with friends"
								class="btn btn-primary" onclick="share()" />
						</form>
						  </div>
				</div>
				
				<div class="container">
					<div class="row">
						<div class="span4 well" style="overflow-y: scroll; height: 101%;">
							<p class="lead">Previously Tweeted:</p>
							<hr/>

							<%
   DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
   // Run an ancestor query to ensure we see the most up-to-date
   // view of the Greetings belonging to the selected Guestbook.
   Query query = new Query("Tweet").addSort("date", Query.SortDirection.DESCENDING);
   Filter propertyFilter = new FilterPredicate("userid",Query.FilterOperator.EQUAL, userid);
query.setFilter(propertyFilter);
  // query.addFilter("userid",Query.FilterOperator.EQUAL, userid);
   List<Entity> tweets = datastore.prepare(query).asList(FetchOptions.Builder.withChunkSize(2000));
   int num_tweets = tweets.size();
   if (tweets.isEmpty()) {
%>
							<div class="alert alert-danger">
								<p>No tweets to be shown yet</p>
							</div>
							<%
}
else { 
%>
							<script type="text/javascript"> console.log(<%=num_tweets%>);document.getElementById("num_tweets").innerText = "<%=num_tweets%> tweets";</script>
							<% 
for (Entity tweet : tweets) { 
	String tweet_text =  (String) tweet.getProperty("text");
	String tweet_date = (String) tweet.getProperty("date");
	String key = KeyFactory.keyToString(tweet.getKey());
	String href = "'view_tweet.jsp?tweet_key=" + key + "'";
%>
							<div>
								<a class="active" href=<%=href%>><%=tweet_text%></a>
								<form method="post" action="Delete" name="delete_tweet"
									accept-charset="UTF-8">
									<input type="hidden" name="tweet_key" id="tweet_key"
										value="<%=key%>" /> <input type="submit"
										class="btn btn-danger" value="Delete" />
								</form>
								<span class="badge pull-right">At <%=tweet_date%></span>
								<p>&nbsp;</p>
							</div>
							<hr />
							<% 
 } 
%>

							<ul class="pager">
								<li class="previous disabled"><a href="#">&laquo;
										Previous</a></li>
								<li class="next disabled"><a href="#">Next &raquo;</a></li>
							</ul>
						</div>
					</div>
				</div>

				<div class="container">
					<div class="row">
						<div class="span4 well" style="overflow-y: scroll; height: 101%;">
							<p class="lead">Most Famous Tweets:</p>
							<hr />
							<%   Query c_query = new Query("Tweet").addSort("count", Query.SortDirection.DESCENDING);
        Filter propertyFilter2 = new FilterPredicate("userid",Query.FilterOperator.EQUAL,userid);
        c_query.setFilter(propertyFilter2);
//c_query.addFilter("userid",Query.FilterOperator.EQUAL,userid);
List<Entity> c_tweets = datastore.prepare(c_query).asList(FetchOptions.Builder.withChunkSize(2000)); 
for (Entity each_tweet : c_tweets ) { 
		String c_tweet_text =  (String) each_tweet.getProperty("text");
		String c_tweet_date = (String) each_tweet.getProperty("date");
		Long c_tweet_count = (Long) each_tweet.getProperty("count");
		String c_key = KeyFactory.keyToString(each_tweet.getKey());
		String c_href = "'view_tweet.jsp?tweet_key=" + c_key + "'";%>
							<div>
								<a class="active" href=<%=c_href%>><%=c_tweet_text%></a>
								<p>&nbsp;</p>
								<button type="submit" class="btn btn-primary">
									View Count
									<%=c_tweet_count %></button>
								<span class="badge pull-right"><%=c_tweet_date%></span>
								<p>&nbsp;</p>
							</div>
							<hr />
							<% } %>

						</div>
					</div>

					<% } %>
				</div>
			</div>
		</div>

	</div>

	
	<script src="./js/jquery-1.7.2.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/charcounter.js"></script>
	<script src="./js/app.js"></script>
</body>
</html>