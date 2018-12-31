<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
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
    String buffer = username;
    if(username != null && (username.length() > 16)) {
        username = "";
    }
    if(username != null && username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div <%=welled%>>
    <div class="col-xs-12">
        <div class="col-xs-12">
            <%if(username == null || username.equals("")) {%>
            <h2>Register</h2><br>
            <h4>
                <p>Fill out the fields below with a chosen username and password in order to register for an account. By registering, you are agreeing to our <a href="/terms.jsp" target="_blank">Terms of Service</a>. Your email and password will not be visible to anyone besides the administrators who manage this website. Your name, username, and biographical information will be visible to other users. If you have any questions about our policies, please contact us via the means specified on the Help Page.</p>
                <br><br><hr>
            </h4>
            <%} else if(username != null && buffer.equals("error: password mismatch")) {%>
            <h2>Registration Error: Password Mismatch</h2><br>
            <h4>
                <p>
                    The passwords you entered don't match. Please re-enter your information below.
                </p>
                <br><br><hr>
            </h4>
            <%} else if(username != null && buffer.equals("error: chosen reserved username")) {%>
            <h2>Registration Error: Reserved Username</h2><br>
            <h4>
                <p>
                    The username you entered not allowed. Please select a different username.
                </p>
                <br><br><hr>
            </h4>
            <%} else if(username != null && buffer.equals("error: username already in use")) {%>
            <h2>Registration Error: Registered Username</h2><br>
            <h4>
                <p>
                    The username you entered is already taken. Please select a different username.
                </p>
                <br><br><hr>
            </h4>
            <%} else if(username != null && buffer.equals("error: username is too long")) {%>
            <h2>Registration Error: Username Length</h2><br>
            <h4>
                <p>
                    The username you entered is too long. Please select a username shorter than 16 characters long.
                </p>
                <br><br><hr>
            </h4>
            <%} else if(username != null && buffer.equals("error: password is too long")) {%>
            <h2>Registration Error: Password Length</h2><br>
            <h4>
                <p>
                    The password you entered is too long. Please select a password shorter than 24 characters long.
                </p>
                <br><br><hr>
            </h4>
            <%}%>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="registerForm" action="UserServlet" method="POST">
                    <input type="hidden" name="action" value="create">
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Name</p>
                        </div>
                        <div class="col-xs-7 col-xs-8">
                            Enter your real name.<br><br>
                            <input id="input-field" name="name" type="text" required><br><br>
                        </div>
                         <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Email</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Enter your email. This will not be displayed to other users. We only use your email for password recovery purposes.<br><br>
                            <input id="input-field" name="email" type="text" required><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Username</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Choose a username less than 16 characters long. This is the name that will be displayed to other users and will be required for when you login.<br><br>
                            <input id="input-field" name="username" type="text" size="16" required><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Password</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Choose a password less than 24 characters long. All passwords are stored securely as hash values.<br><br>
                            <input id="input-field" name="password" type="password" required><br><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Confirm Password</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Please enter the same password as above.<br><br>
                            <input id="input-field" name="confirm" type="password" required><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Bio</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            You may write biographical information about yourself.<br><br>
                            <textarea id="input-field" name="bio" form="registerForm"></textarea><br><br><br>
                        </div>
                    </div>
                    <div class="row">
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="col-xs-12 col-sm-4">
                            <button title="Register" id="form-submit" type="submit">Register</button><br><br><br>
                        </div>
                    </div>
                </form>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>