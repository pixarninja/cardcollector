<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String)request.getAttribute("username");
    String buffer = username;
    if(username != null && (username.length() > 16)) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<form id="forgotForm" action="UserServlet" method="POST">
    <input type="hidden" name="action" value="forgot">
    <input type="hidden" name="username" value="<%=username%>">
</form>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12 col-md-5">
            <%if(username == null) {%>
            <div class="row">
                <h2>Login</h2> <br>
                <h4>
                    Fill out the fields below with your username and password in order to login and view/update your account information. If you forgot your password, use the link beneath the "Login" button below to be send an email with instructions on how to recover your password.
                </h4><br>
            </div>
            <%}%>
            <%if(username != null && buffer.equals("error: invalid credentials")) {%>
            <h1>Login Error: Invalid password combination</h1> <br>
            <h4>Please re-enter your credentials below</h4> <br>
            <%}%>
            <%if(username != null && buffer.equals("error: user does not exist")) {%>
            <h1>Login Error: User does not exist</h1> <br>
            <h4>Please register as a new user to use that username</h4> <br>
            <%}%>
            <%if(username != null && !buffer.equals("error: invalid credentials") && !buffer.equals("error: user does not exist")) {%>
            <h1>Login</h1> <br>
            <h4>You have been logged out. Fill out the fields below with your username and password in order to login and view/update your account information. If you are a new user, use the "Register" button below to create an account. If you forgot your password, use the link beneath the "Login" button below to be send an email with instructions on how to recover your password.</h4> <br>
            <%}%>
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
                            <input id="form-submit" type="submit" value="Login"><br><br>
                            <a href="#" onclick="document.getElementById('forgotForm').submit();">Forgot your password?</a>
                        </div>
                    </div>
                </h4>
            </form>
        </div>
        <div class="hidden-xs hidden-sm col-md-1" style="border-right: 1px solid white;position: relative;right: 20px;height: 70%;"></div>
        <div class="col-xs-12 col-md-5">
            <h2>Register</h2><br>
            <form id="registerForm" action="UserServlet" method="POST">
                <h4>
                    Don't have an account with us yet? Click below to register! Registration is free, and only requires a name, email, age, username, and password.
                    After you have registered, you will be able to make collections and decks, and write reviews!<br><br>
                </h4>
                <div class="col-xs-12 col-md-8">
                    <h4>
                        <input type="hidden" name="action" value="register">
                        <input id="form-submit" style="position: relative; right: 15px;" type="submit" value="Register">
                    </h4>
                </div>
                <div class="hidden-xs col-md-4"></div>
            </form>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>