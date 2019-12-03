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
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter" %>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate" %>
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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
	</div>
  <div class="jumbotron">
  <h4> Friends Tweet Page</h4><br>
  </div>

<% Cookie[] cookies = request.getCookies();
		String name="";
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				if (cookie.getName().equals("userid")) {
					name = cookie.getValue();
					break;
				}
				else{
				}
			}
		}
		
 %> 
		
		<% 
	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    // Run an ancestor query to ensure we see the most up-to-date
	    // view of the Greetings belonging to the selected Guestbook.
	    Query query = new Query("Tweet");
	    Filter propertyFilter = new FilterPredicate("userid", Query.FilterOperator.NOT_EQUAL, name);
		query.setFilter(propertyFilter);
	   // query.addFilter("userid",Query.FilterOperator.NOT_EQUAL,name);
	    List<Entity> tweets = datastore.prepare(query).asList(FetchOptions.Builder.withChunkSize(2000));
	    int num_tweets = tweets.size();
	    if (tweets.isEmpty()) {
		%>
<div class="alert alert-danger">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <h4>Warning!</h4>
  Please verify if your friends use this app.
</div>
<% 
} 
	     else {
	    	 for (Entity tweet : tweets) { 
	    			String tweet_text =  (String) tweet.getProperty("text");
	    			String tweet_date = (String) tweet.getProperty("date");
	    			String username = (String) tweet.getProperty("username");
	    			Long count = (Long) tweet.getProperty("count");
	    			String key = KeyFactory.keyToString(tweet.getKey()); 
					String href = "'view_tweet.jsp?tweet_key=" + key + "'";
					String picture = "'" + (String) tweet.getProperty("picture") + "'";
					%>
	     <div class="container">
        <ul class="list-group">

            <li class="list-group-item list-group-item-info">
              <p>
                <a class="active" target="_blank" href=<%=href%> ><%=tweet_text%></a>
              </p>
              <p>
                <strong>Created at: <%=tweet_date %></strong>
              </p>
              <p>
                <strong> Posted by: <%=username %></strong> 
              </p>
               <p>
                <strong> View Count : <%=count %></strong> 
              </p>
              <div id="profile_pic" class="span1"><a href=<%=href%> class="thumbnail"><img src=<%=picture%> alt=""></a></div>
            </li>


      </ul>
  </div>
	     <% }  
	    	} %>
 <script>
document.getElementById('profile_link').href = localStorage.profile_url;
</script>
</body>
</html>