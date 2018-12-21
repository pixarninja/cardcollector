<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
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
    String buffer = username;
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);
%>
<!-- Content -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <%if(username != null && !username.equals("")) {%>
            <h2>Edit Profile Information</h2><br>
            <h4>
                <p>Fill out any of the fields below to replace the fields of your profile information. Click "Submit Changes" once you are done editing your information.</p>
                <br><br><hr>
            </h4>
            <%}%>
            <%if(buffer != null && buffer.equals("error: password mismatch")) {%>
            <h2>Edit Profile Error: Password Mismatch</h2><br>
            <h4>
                <p>The passwords you entered don't match. Please re-enter your information below.</p>
                <br><br><hr>
            </h4>
            <%}%>
            <%if(buffer != null && buffer.equals("error: username already in use")) {%>              
            <h2>Edit Profile Error: Taken Username</h2><br>
            <h4>
                <p>The username you entered is already taken. Please select a different username. Please re-enter your information below.</p>
                <br><br><hr>
            </h4>
            <%}%>
            <%if(buffer != null && buffer.equals("error: username is too long")) {%>
            <h2>Edit Profile Error: Username Length</h2><br>
            <h4>
                <p>The username you entered is too long. Please select a username shorter than 16 characters long. Please re-enter your information below.</p>
                <br><br><hr>
            </h4>
            <%}%>
            <%if(buffer != null && buffer.equals("error: password is too long")) {%>
            <h2>Edit Profile Error: Password Length</h2><br>
            <h4>
                <p>The password you entered is too long. Please select a password shorter than 24 characters long. Please re-enter your information below.</p>
                <br><br><hr>
            </h4>
            <%}%>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="editProfileForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="submit_edit">
                    <input type="hidden" name="username" value="<%=username%>">
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Name</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Enter your real name. This will not be displayed to other users.<br><br>
                            <%
                                if(user.getUsername() == null || user.getUsername().equals("")) {
                            %>
                            <input id="input-field" name="name" type="text"><br><br>
                            <%} else {%>
                            <input id="input-field" name="name" type="text" value="<%=user.getName()%>"><br><br>
                            <%}%>
                        </div>
                         <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Email</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Enter your email. This will not be displayed to other users.<br><br>
                            <%
                                if(user.getEmail() == null || user.getEmail().equals("")) {
                            %>
                            <input id="input-field" name="email" type="text"><br><br>
                            <%} else {%>
                            <input id="input-field" name="email" type="text" value="<%=user.getEmail()%>"><br><br>
                            <%}%>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Username</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Choose a username less than 16 characters long. This is the name that will be displayed to other users and will be required for when you login.<br><br>
                            <%
                                if(user.getUsername() == null || user.getUsername().equals("")) {
                            %>
                            <input id="input-field" name="new_user" type="text" size="16"><br><br>
                            <%} else {%>
                            <input id="input-field" name="new_user" type="text" size="16" value="<%=user.getUsername()%>"><br><br>
                            <%}%>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Password</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Choose a password less than 24 characters long.<br><br>
                            <input id="input-field" name="password" type="password"><br><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Confirm Password</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Please enter the same password as above.<br><br>
                            <input id="input-field" name="confirm" type="password"><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Bio</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            You may write biographical information about yourself.<br><br>
                            <%
                                if(user.getBio() == null || user.getBio().equals("")) {
                            %>
                            <textarea id="input-field" name="bio" form="editProfileForm"></textarea><br><br>
                            <%} else {%>
                            <textarea id="input-field" name="bio" form="editProfileForm"><%=user.getBio()%></textarea><br><br>
                            <%}%>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Randomize Profile Picture</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            <input type="checkbox" name="pic" value="update"> Get a new random profile picture.<br><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Notification Settings</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Select/deselect the notifications you would like to receive via email. If disabled notifications will still be viewable on the Notifications Page, however an email will not be sent to you when the type of notification is generated.<br><br>
                            <%
                                if(userInfo.getDeckCommentNotification()) {
                            %>
                            <input type="checkbox" name="deck_comment" value="receive" checked="checked"> Deck Comments (a comment on your deck)<br>
                            <%
                                } else {
                            %>
                            <input type="checkbox" name="deck_comment" value="receive"> Deck Comments (a comment on your deck)<br>
                            <%}%>
                            <%
                                if(userInfo.getCollectionCommentNotification()) {
                            %>
                            <input type="checkbox" name="collection_comment" value="receive" checked="checked"> Collection Comments (a comment on your collection)<br>
                            <%
                                } else {
                            %>
                            <input type="checkbox" name="collection_comment" value="receive"> Collection Comments (a comment on your collection)<br>
                            <%}%>
                            <%
                                if(userInfo.getCardCommentReactionNotification()) {
                            %>
                            <input type="checkbox" name="card_comment_reaction" value="receive" checked="checked"> Card Comment Reactions (a reaction to your comment(s) on a card)<br>
                            <%
                                } else {
                            %>
                            <input type="checkbox" name="card_comment_reaction" value="receive"> Card Comment Reactions (a reaction to your comment(s) on a card)<br>
                            <%}%>
                            <%
                                if(userInfo.getDeckCommentReactionNotification()) {
                            %>
                            <input type="checkbox" name="deck_comment_reaction" value="receive" checked="checked"> Deck Comment Reactions (a reaction to your comment(s) on a deck)<br>
                            <%
                                } else {
                            %>
                            <input type="checkbox" name="deck_comment_reaction" value="receive"> Deck Comment Reactions (a reaction to your comment(s) on a deck)<br>
                            <%}%>
                            <%
                                if(userInfo.getCollectionCommentReactionNotification()) {
                            %>
                            <input type="checkbox" name="collection_comment_reaction" value="receive" checked="checked"> Collection Comment Reactions (a reaction to your comment(s) on a collection)<br><br><br>
                            <%
                                } else {
                            %>
                            <input type="checkbox" name="collection_comment_reaction" value="receive"> Collection Comment Reactions (a reaction to your comment(s) on a collection)<br><br><br>
                            <%}%>
                        </div>
                    </div>
                    <div class="row">
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="col-xs-12 col-sm-4">
                            <button title="Update Profile" id="form-submit" type="submit">Submit</button><br><br><br>
                        </div>
                    </div>
                </form>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>