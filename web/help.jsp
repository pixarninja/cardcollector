<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = null;
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    boolean found = false;

    if( cookies != null ) {
       for (int i = 0; i < cookies.length; i++) {
          cookie = cookies[i];
          if(cookie.getName().equals("username")) {
              username = cookie.getValue();
              found = true;
              break;
          }
       }
    }
    if(!found) {
        if((String)request.getAttribute("username") == null) {
            username = request.getParameter("username");
        }
        else {
            username = (String)request.getAttribute("username");
        }
    }
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div <%=welled%>>
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Site Information</h2><br>
            <h4>
                <p>
                    Welcome to Card<span class="glyphicon glyphicon-globe" id="small-icon"></span>Collector, your personal Magic The Gathering collection logbook! Using this website, you can log collections and decks of cards. You can also comment on cards and collections or decks other users have made.
                </p>
                <p>
                    This website is free to use. All card information was imported via the <a href="https://scryfall.com/docs/api/" target="_blank">Scryfall API</a>. The website owner does not own any of the content on this website, nor do they take responsibility for information put on the website by its users. This website's source code (aside from sensitive backend data) is provided on <a href="https://github.com/pixarninja/cardcollector" target="_blank">GitHub</a>. An MVC architecture and SHA-1 encryption was used to design and secure this website, with the help from the NetBeans IDE and Amazon AWS to develop and deploy it. This website uses cookies to store the username of the user logged in.
                </p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h2>How To<hr></h2>
            <h4>
                Below are different sections of information which discuss how to use this website. Please be responsible in your use of the website. The website owner reserves the right to remove any content that is inappropriate or degrading. If you are concerned about content on this website, send the owner an email describing the issue and it will be investigated. The website owner's email can be found at the bottom of this page.
            </h4>
            <br>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h3>Creating Collections And Decks<hr></h3>
            <h4>
                <p>
                    In order to create collections and decks, click the "<span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Collections" or "<span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Decks" links at the header or footer of any page. This will take you to a page containing all of your collections or decks. You can then click the "New" button displayed at the top of the page to create a new collection or deck, or you can interact with collections or decks you've already created.
                </p>
                <br>
            </h4>
            <h3>Finding Cards<hr></h3>
            <h4>
                <p>
                    In order to find cards to add to your collections and decks, click the "<span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Search" link at the header or footer of any page. This will take you to an advanced search page, where you can either search for cards, decks, collections or users. By selecting to search for collections or decks, you can view them and add cards from them to your own collections or decks if you wish. When looking at the search results for cards, the card's set and legality information is displayed.
                </p>
                <br>
            </h4>
            <h3>Logging Cards<hr></h3>
            <h4>
                <p>
                    In order to log cards in your collections and decks, click the "<span class="glyphicon glyphicon-plus"></span>" Button on any page displaying a card. This will display a popup where you can add any amount of the card to a collection and/or deck.
                </p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h3>Adding Favorites<hr></h3>
            <h4>
                <p>
                    You can add cards, decks, collections, or users to your favorited items by clicking the "<span class="glyphicon glyphicon-star-empty"></span>" button on any page displaying the item. You will then be directed to your profile page, where you may view your favorited items. You can remove an item from your favorite list by clicking the "<span class="glyphicon glyphicon-star"></span>" button on any page displaying the item.
                </p>
                <br>
            </h4>
            <h3>Writing Comments<hr></h3>
            <h4>
                <p>
                    You can write comments on cards, decks, and collections by going to that item's information page and clicking filling out the comment field at the bottom of the page. You can edit or delete your comments, and like or dislike other user's comments.
                </p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h2>Contact Information<hr></h2>
            <div class="row">
                <div class="col-xs-12 col-sm-4">
                    <img class="img-special" width="100%" src="images/creator.jpg" alt="images/creator.jpg" id="center-img">
                </div>
                <div class="col-xs-12 col-sm-8">
                    <h4>
                        <p>My name is Wes Harris, I am a Computer Science Undergraduate student at New Mexico Institute of Mining and Technology. I created this website to provide a unique platform for logging collections and decks of Magic cards. If you would like to contact me, you can do so via the contact details below.</p>
                        <br><br>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="wesharris505@gmail.com" onclick="document.getElementById('emailForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-envelope"></span>
                                </div>
                                <span style="position: relative;top: 8px;left: 10px;">
                                    wesharris505@gmail.com
                                </span>
                            </div>
                            <form id="emailForm" action="mailto:wesharris505@gmail.com" target="_blank"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="New Mexico Tech" onclick="document.getElementById('educationForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-education"></span>
                                </div>
                                <span style="position: relative;top: 8px;left: 10px;">
                                    Studying Computer Science at New Mexico Tech
                                </span>
                            </div>
                            <form id="educationForm" action="https://www.cs.nmt.edu/" target="_blank"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="Personal Website" onclick="document.getElementById('personalForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-bookmark"></span>
                                </div>
                                <span style="position: relative;top: 8px;left: 10px;">
                                    Personal Website
                                </span>
                            </div>
                            <form id="personalForm" action="https://www.markwesleyharris.com/" target="_blank"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="Facebook Profile" onclick="document.getElementById('facebookForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                </div>
                                <span style="position: relative;top: 8px;left: 10px;">
                                    Facebook Profile
                                </span>
                            </div>
                            <form id="facebookForm" action="https://www.facebook.com/wesley.harris.the.pixar.ninja" target="_blank"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="GitHub" onclick="document.getElementById('gitForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-user"></span>
                                </div>
                                <span style="position: relative;top: 8px;left: 10px;">
                                    GitHub
                                </span>
                            </div>
                            <form id="gitForm" action="https://github.com/pixarninja" target="_blank"></form>
                            <br>
                        </div>
                    </h4>
                </div>
            </div>
        </div>
        <div class="col-xs-12"><br><br></div>
    </div>
</div>
<%@include file="footer.jsp"%>