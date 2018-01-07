<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<%
    String username;
    String buffer = null;
    if((String)request.getAttribute("username") == null) {
        username = request.getParameter("username");
    }
    else {
        username = (String)request.getAttribute("username");
    }
%>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);
    String cardImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back_hd.png";
        picture = "images/icons/battered-axe.png";
    }
    else {
        cardImage = user.getPicture();
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="row">
    <div class="well col-xs-12 col-sm-8">
        <div class="col-xs-12">
            <div class="col-xs-12">
                <h2>Edit Profile Information</h2><br>
                <h4>
                    <%if(username != null && (buffer == null || buffer.equals(""))) {%>
                    <p>Fill out any of the fields below to replace the fields of your profile information. Click "Submit Changes" once you are done editing your information.</p>
                    <br><br><hr>
                    <%}%>
                </h4>
                <%if(buffer != null && buffer.equals("error: password mismatch")) {%>
                <h2>Edit Profile Error: The passwords you entered don't match</h2>
                <h4>Please re-enter your information below</h4>
                <%}%>
                <%if(buffer != null && buffer.equals("error: username already in use")) {%>
                <h2>Edit Profile Error: The username you entered is already taken. Please select a different username</h2>
                <h4>Please re-enter your information below</h4>
                <%}%>
                <%if(buffer != null && buffer.equals("error: username is too long")) {%>
                <h1>Edit Profile Error: The username you entered is too long</h1> <br>
                <h4>Please select a username shorter than 16 characters long</h4> <br>
                <%}%>
                <%if(buffer != null && buffer.equals("error: password is too long")) {%>
                <h1>Edit Profile Error: The password you entered is too long</h1> <br>
                <h4>Please select a password shorter than 24 characters long</h4> <br>
                <%}%>
            </div>
            <div class="col-xs-12">
                <h4>
                    <form id="editProfileForm" action="UserServlet" method="POST">
                        <input type="hidden" name="action" value="submit_edit">
                        <input type="hidden" name="username" value="<%=username%>">
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Name</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Enter your real name. This will not be displayed to other users.<br><br>
                                <input id="input-field" name="name" type="text"><br><br>
                            </div>
                             <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Email</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Enter your email. This will not be displayed to other users.<br><br>
                                <input id="input-field" name="email" type="text"><br><br>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Age</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Enter your age. This will not be displayed to other users.<br><br>
                                <input id="input-field" name="age" type="text"><br><br>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Username</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Choose a username less than 16 characters long. This is the name that will be displayed to other users and will be required for when you login.<br><br>
                                <input id="input-field" name="username" type="text" size="16"><br><br>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Password</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Choose a password less than 24 characters long.<br><br>
                                <input id="input-field" name="password" type="text"><br><br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Confirm Password</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Please enter the same password as above.<br><br>
                                <input id="input-field" name="confirm" type="text"><br><br><br>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p>Update Profile Picture</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                <input type="checkbox" name="pic" value="update"> Get a new random profile picture<br><br><br>
                                <input id="form-submit" type="submit" value="Submit Changes"><br><br><br>
                            </div>
                        </div>
                    </form>
                    <div class="col-xs-12"><br></div>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>