<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="selectionInfo" class="beans.SelectionInfo" scope="request"/>
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
    int selectionEntries = 0;
    int selectionId = 1;
    SelectionInfo selection;
    while((selection = (SelectionInfo) selectionInfo.getSelectionById(selectionId)) != null) {
        String user = selection.getUser();
        if(user.equals(username)) {
            selectionEntries++;
        }
        selectionId++;
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="row">
    <div class="well col-xs-12">
        <div class="col-xs-12">
            <div class="col-xs-12">
                <%if(username == null || username.equals("")) {%>
                <h2>Register</h2><br>
                <h4>
                    <p>Fill out the fields below with a chosen username and password in order to register for an account.</p>
                    <br><br><hr>
                </h4>
                <%}%>
                <%if(username != null && buffer.equals("error: password mismatch")) {%>
                <h2>Registration Error: Password Mismatch</h2><br>
                <h4>
                    <p>
                        The passwords you entered don't match. Please re-enter your information below.
                    </p>
                    <br><br><hr>
                </h4>
                <%}%>
                <%if(username != null && buffer.equals("error: chosen reserved username")) {%>
                <h2>Registration Error: Reserved Username</h2><br>
                <h4>
                    <p>
                        The username you entered not allowed. Please select a different username.
                    </p>
                    <br><br><hr>
                </h4>
                <%}%>
                <%if(username != null && buffer.equals("error: username already in use")) {%>
                <h2>Registration Error: Registered Username</h2><br>
                <h4>
                    <p>
                        The username you entered is already taken. Please select a different username.
                    </p>
                    <br><br><hr>
                </h4>
                <%}%>
                <%if(username != null && buffer.equals("error: username is too long")) {%>
                <h2>Registration Error: Username Length</h2><br>
                <h4>
                    <p>
                        The username you entered is too long. Please select a username shorter than 16 characters long.
                    </p>
                    <br><br><hr>
                </h4>
                <%}%>
                <%if(username != null && buffer.equals("error: password is too long")) {%>
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
                        <input type="hidden" name="action" value="new_user">
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p id="title">Name</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Enter your real name. This will not be displayed to other users.<br><br>
                                <input id="input-field" name="name" type="text" required><br><br>
                            </div>
                             <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p id="title">Email</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Enter your email. This will not be displayed to other users.<br><br>
                                <input id="input-field" name="email" type="text" required><br><br>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p id="title">Username</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Choose a username less than 16 characters long. This is the name that will be displayed to other users and will be required for when you login.<br><br>
                                <input id="input-field" name="username" type="text" size="16" required><br><br>
                            </div>
                            <div class="col-xs-12"><hr></div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p id="title">Password</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Choose a password less than 24 characters long.<br><br>
                                <input id="input-field" name="password" type="password" required><br><br>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5 col-sm-4">
                                <input type="hidden" name="action" value="validate">
                                <p id="title">Confirm Password</p>
                            </div>
                            <div class="col-xs-7 col-xs-8">
                                Please enter the same password as above.<br><br>
                                <input id="input-field" name="confirm" type="password" required><br><br><br>
                                <input id="form-submit" type="submit" value="Register"><br><br><br>
                            </div>
                        </div>
                    </form>
                </h4>
            </div>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>