<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Site Information</h2><br>
            <h4>
                <p>
                    Welcome to Card<span class="glyphicon glyphicon-globe" id="small-icon"></span>Collector, your personal Magic The Gathering collection logbook! Using this website, you can log collections and decks of cards. You can also comment on cards and collections or decks other users have made.
                </p>
                <p>
                    This website is free to use. All card information was imported via the <a href="https://scryfall.com/docs/api/">Scryfall API</a>. I do not own any of the content on this website, nor do I take responsibility for information put on the website by its users. This website's source code (aside from sensitive backend data) is provided on GitHub, in my personal <a href="https://github.com/pixarninja/cardcollector">pixarninja/cardcollector</a> repository. I used a secure MVC architecture to design this website, with the help from the NetBeans IDE and Amazon AWS services.
                </p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h2>Wes Harris<hr></h2>
            <div class="row">
                <div class="col-xs-12 col-sm-4">
                    <img class="img-special" width="100%" src="images/creator.jpg" alt="images/creator.jpg" id="center-img">
                </div>
                <div class="col-xs-12 col-sm-8">
                    <h4>
                        <p>If you would like to contact the creator of this website, you can do so via the contact details below.</p>
                        <br><br>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="New Mexico Tech" onclick="document.getElementById('educationForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-education"></span>
                                </div>&nbsp;&nbsp;New Mexico Tech
                            </div>
                            <form id="educationForm" action="https://www.cs.nmt.edu/"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="wesharris505@gmail.com" onclick="document.getElementById('emailForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-envelope"></span>
                                </div>&nbsp;&nbsp;Email
                            </div>
                            <form id="emailForm" action="mailto:wesharris505@gmail.com"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="GitHub" onclick="document.getElementById('gitForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-user"></span>
                                </div>&nbsp;&nbsp;GitHub
                            </div>
                            <form id="gitForm" action="https://github.com/pixarninja"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="Personal Website" onclick="document.getElementById('personalForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-bookmark"></span>
                                </div>&nbsp;&nbsp;Personal Website
                            </div>
                            <form id="personalForm" action="https://www.markwesleyharris.com/"></form>
                            <br>
                        </div>
                        <div class="col-xs-12 col-sm-6">
                            <div class="row">
                                <div class="col-xs-2" style="margin: auto;display: table;width: 15px !important;" id="button-back-pill" title="Facebook Profile" onclick="document.getElementById('facebookForm').submit();">
                                    <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                </div>&nbsp;&nbsp;Facebook Profile
                            </div>
                            <form id="facebookForm" action="https://www.facebook.com/wesley.harris.the.pixar.ninja"></form>
                        </div>
                    </h4>
                </div>
            </div>
            <div class="col-xs-12"><br><br></div>
            <h2>How To<hr></h2>
            <h4>
                Below are different sections of information which discuss how to use this website.
            </h4>
            <br><br>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h3>Creating Collections And Decks<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
            </h4>
            <h3>Finding Cards<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
            </h4>
            <h3>Logging Cards<hr></h3>
            <h4>
                <p>Derp...</p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-6">
            <h4>
                <h3>Making Friends<hr></h3>
                <h4>
                    <p>Derp...</p>
                    <br>
                </h4>
                <h3>Writing Comments<hr></h3>
                <h4>
                    <p>Derp...</p>
                    <br>
                </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>