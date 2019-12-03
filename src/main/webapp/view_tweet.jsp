<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.EntityNotFoundException" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    
 <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

         <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    

    <link href="./css/bootstrap.min.css" media="all" type="text/css" rel="stylesheet">
    <link href="./css/bootstrap-responsive.min.css" media="all" type="text/css" rel="stylesheet">
    <link href="./css/font-awesome.css" rel="stylesheet" >
    <link href="./css/nav-fix.css" media="all" type="text/css" rel="stylesheet">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <style>
      .artwork {
        margin-top:30px;
        margin-bottom: 30px;
      }
    </style>

  </head>
  <style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
</style>
<body class="w3-light-grey">

     <div class="w3-bar w3-white w3-large">
  		<b><a href="#" class="w3-bar-item w3-button w3-teal w3-mobile">Tweetbook</a></b>
  		<a href="home.jsp" class="w3-bar-item w3-button w3-mobile">Home</a>
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
  
  
  <div class="jumbotron">
  <h1> View Tweet Page</h1><br>
  <h3> View single tweets here</h3>
  </div>
  
  
    <div class="container">

  <%
    String tweet_key = request.getParameter("tweet_key");
    if (tweet_key == null) {
    	
    	%>
    	<script type="text/javascript"> msg= "fatal no tweet ID provided , this page must be opened by providing a tweet ID using POST- redirecting to home...";console.log(msg);alert(msg); location.href="home.jsp";</script>
    <%
    } else { 
        DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
        Key tw_key = KeyFactory.stringToKey(tweet_key); 
        String tweet_text="", username="", date="";
 
        String count = "";
			Entity tweet = ds.get(tw_key);
			 tweet_text = (String) tweet.getProperty("text");
			 Long newcount = (Long) tweet.getProperty("count");
			 newcount +=1 ;
			 tweet.setProperty("count", newcount);
			 username = (String) tweet.getProperty("username");
			 date = (String) tweet.getProperty("date");
			 ds.put(tweet);	
    %>	
        <ul class="list-group">

            <li class="list-group-item list-group-item-info">
              <p>
                <strong> Tweet: <%=tweet_text %> </strong>
              </p>
              <p>
                <strong>Created at: <%=date %></strong>
              </p>
              <p>
                <strong> Posted by: <%=username %></strong> 
              </p>
               <p>
                <strong> View Count : <%=newcount %></strong> 
              </p>
            </li>


      </ul>
  <%
      }
      %>
     </div>   
  
  </body>   
</html>