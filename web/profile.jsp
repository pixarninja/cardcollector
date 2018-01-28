<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="collectionContentsInfo" class="beans.CollectionContentsInfo" scope="request"/>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%
    String username;
    String buffer;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
    buffer = username;
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);
    String cardImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back.jpg";
        picture = "images/blank_user.jpg";
    }
    else {
        cardImage = "images/magic_card_back.jpg";
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Profile</h2><br>
            <h4>
                <p>Below is your profile information. You may edit your information by selecting the "Edit" button. You may edit any decks or collections you have recorded by selecting the item's title, which will take you to the item's information page. Below you will also find your favorited items, friends, and a log of your site history.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-4">
            <h4>
                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img>
                <div class="col-xs-12"><br><br></div>
                <div class="row" style="margin: auto;display: table">
                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Refresh Profile Picture" onclick="document.getElementById('pictureForm').submit();">
                        <span id="button-symbol" class="glyphicon glyphicon-refresh"></span>
                    </div>
                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-middle" title="Edit Profile Information" onclick="document.getElementById('editForm').submit();">
                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                    </div>
                    <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete User" onclick="deleteUserPopup('<%=username%>');">
                        <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                    </div>
                </div>
                <form id="pictureForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="refresh_picture">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="editForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="edit_profile">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <br>
            </h4>
        </div>
        <div class="col-xs-12 col-sm-8">
            <h3>Personal Information<hr></h3>
            <h4>
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Username</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getUsername()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Name</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getName()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <div class="row">
                                <p id="title">Email</p>
                            </div>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <div class="row">
                                <p><%=user.getEmail()%></p>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                </div>
            </h4>
        </div>
        <form id="popupForm" action="PopupServlet" method="POST"></form>
    </div>
</div>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>