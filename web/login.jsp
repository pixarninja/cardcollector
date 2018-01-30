<%@page import="beans.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    if(username != null && (username.length() > 16)) {
        username = "";
    }
    if(username != null && username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <form id="forgotForm" action="UserServlet" method="POST">
        <input type="hidden" name="action" value="forgot">
        <input type="hidden" name="username" value="<%=username%>">
    </form>
    <div class="col-xs-12 col-md-5" style="position: relative;top: -15px;">
        <%if(username == null) {%>
        <div class="col-xs-12">
            <h2>Login</h2> <br>
            <h4>
                Fill out the fields below with your username and password in order to login and view/update your account information. If you forgot your password, use the link beneath the "Login" button below to be send an email with instructions on how to recover your password.
            </h4><br>
        </div>
        <%}%>
        <%if(username != null && buffer.equals("error: propted redirect")) {%>
        <div class="col-xs-12">
            <h2>Login</h2> <br>
            <h4>
                In order to access the requested page, you must first log into your account.<br><br>
                Fill out the fields below with your username and password in order to login and view/update your account information. If you forgot your password, use the link beneath the "Login" button below to be send an email with instructions on how to recover your password.
            </h4><br>
        </div>
        <%}%>
        <%if(username != null && buffer.equals("error: invalid credentials")) {%>
        <div class="col-xs-12">
            <h2>Login Error: Invalid Credentials</h2> <br>
            <h4>
                You did not enter the correct password. Please re-enter your credentials below.
            </h4><br>
        </div>
        <%}%>
        <%if(username != null && buffer.equals("error: user does not exist")) {%>
        <div class="col-xs-12">
            <h2>Login Error: Unregistered Username</h2> <br>
            <h4>
                You entered an unregistered username. Please register as a new user to use that username.
            </h4><br>
        </div>
        <%}%>
        <%if(username != null && !buffer.equals("error: invalid credentials") && !buffer.equals("error: propted redirect") && !buffer.equals("error: user does not exist")) {%>
        <div class="col-xs-12">
            <h2>Login</h2> <br>
            <h4>
                You have been logged out. Fill out the fields below with your username and password in order to login and view/update your account information. If you forgot your password, use the link beneath the "Login" button below to be send an email with instructions on how to recover your password.
            </h4><br>
        </div>
        <%}%>
        <div class="col-xs-12">
            <form id="loginForm" action="UserServlet" method="POST">
                <input type="hidden" name="action" value="validate">
                <h4>
                    <div class="row">
                        <div class="col-xs-4">
                            <span class="pull-right">Username:&nbsp;&nbsp;</span>
                        </div>
                        <div class="col-xs-8">
                            <input id="input-field" name="username" type="text" size="24" required /><br><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4">
                            <span class="pull-right">Password:&nbsp;&nbsp;</span>
                        </div>
                        <div class="col-xs-8">
                            <input id="input-field" name="password" type="password" size="24" required /><br><br><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="hidden-xs col-md-4"></div>
                        <div class="col-xs-12 col-md-8">
                            <button title="Login" id="form-submit" type="submit">Login</button><br><br>
                            <a href="#" onclick="document.getElementById('forgotForm').submit();">Forgot your password?</a>
                        </div>
                    </div>
                </h4>
            </form>
        </div>
    </div>
    <div class="hidden-xs hidden-sm col-md-1" style="border-right: 1px solid white;position: relative;right: 20px;height: 70%;"></div>
    <div class="col-xs-12 col-md-5" style="position: relative;top: -15px;">
        <div class="col-xs-12">
            <h2>Register</h2><br>
            <form id="registerForm" action="UserServlet" method="POST">
                <h4>
                    Don't have an account with us yet? Click below to register! Registration is free, and only requires a name, email, username, and password.
                    After you have registered, you will be able to make collections and decks, and write reviews!<br><br>
                </h4>
                <div class="col-xs-12 col-md-8">
                    <h4>
                        <input type="hidden" name="action" value="register">
                        <button title="Register" id="form-submit" style="position: relative; right: 15px;" type="submit">Register</button>
                    </h4>
                </div>
                <div class="hidden-xs col-md-4"></div>
            </form>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>