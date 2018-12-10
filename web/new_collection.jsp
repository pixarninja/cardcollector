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
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Create New Collection</h2><br>
            <h4>
                <p>If you would like to create a new collection, fill out the fields below and click the "Create" button. You must give a title to the collection.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="newDeckForm" action="CollectionServlet" method="POST">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="username" value="<%=username%>">
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Collection Title</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Please enter the title for this collection.<br><br>
                            <input id="input-field" name="name" type="text" required>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Collection Description</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            You may enter a description for this collection.<br><br>
                            <textarea id="input-field" name="description"></textarea>
                        </div>
                    </div>
                    <div class="col-xs-12"><br><br></div>
                    <div class="row">
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="col-xs-12 col-sm-4">
                            <button id="form-submit" title="Create Collection" style="width: 100%;" type="submit">Create</button><br><br><br>
                        </div>
                    </div>
                </form>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>