<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userFavoriteInfo" class="beans.UserFavoriteInfo" scope="request"/>
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
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Search Results: Users</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a user's information page by clicking the "View" link. You may add the cards from the deck to your selection by clicking the "Add" link.</p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
                int max = 12;
                int count = 0;
                int total = 0;
                if(request.getParameter("total") != null) {
                    total = Integer.parseInt(request.getParameter("total"));
                }
                else if(request.getAttribute("total") != null) {
                    total = (Integer)request.getAttribute("total");
                }
                if(total > 0) {
                    count = 1;
                }
                if(request.getParameter("start") != null && !request.getParameter("start").equals("")) {
                    count = Integer.parseInt(request.getParameter("start"));
                }
                int end = 0;
                if((count + max - 1) < total) {
                    end = count + max - 1;
                }
                else {
                    end = total;
                }
                if(end < max) {
                    %><h3>Showing: <%=count%> through <%=end%> out of <%=total%></h3><hr><%
                }  
                else {
                    %><h3>Showing: <%=end - max + 1%> through <%=end%> out of <%=total%></h3><hr><%
                }
                int i;
                if(count > 1) {
                    if(end >= total) {
            %>
            <div class="col-xs-4"></div>
            <%}%>
            <div class="col-xs-4">
                <div class="col-xs-12"><br></div>
                <form id="requestLessForm" action="SearchServlet" method="POST">
                    <input type="hidden" name="action" value="less_users">
                    <input type="hidden" name="start" value="<%=count - max%>">
                    <input type="hidden" name="total" value="<%=total%>">
                    <%
                        for(i = 1; i <= total; i++) {
                            if(request.getAttribute(Integer.toString(i)) != null) {
                                %><input type="hidden" name="<%=i%>" value="<%=(String) request.getAttribute(Integer.toString(i))%>"><%
                            } else {
                                %><input type="hidden" name="<%=i%>" value="<%=request.getParameter(Integer.toString(i))%>"><%
                            }
                        }
                    %>
                    <input type="hidden" name="username" value="<%=username%>">
                    <button title="Previous <%=max%> Users" id="form-submit" type="submit"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
                </form>
                <div class="col-xs-12"><br></div>
            </div>
            <%
                if(end >= total) {
            %>
            <div class="col-xs-4"></div>
            <%
                    }
                }
            %>
            <%
                if(end < total && count != 0) {
                    if(count >= 1) {
            %>
            <div class="col-xs-4"></div>
            <%}%>
            <div class="col-xs-4">
                <div class="col-xs-12"><br></div>
                <form id="requestMoreForm" action="SearchServlet" method="POST">
                    <input type="hidden" name="action" value="more_users">
                    <input type="hidden" name="start" value="<%=count + max%>">
                    <input type="hidden" name="total" value="<%=total%>">
                    <%
                        for(i = 1; i <= total; i++) {
                            if(request.getAttribute(Integer.toString(i)) != null) {
                                %><input type="hidden" name="<%=i%>" value="<%=(String) request.getAttribute(Integer.toString(i))%>"><%
                            } else {
                                %><input type="hidden" name="<%=i%>" value="<%=request.getParameter(Integer.toString(i))%>"><%
                            }
                        }
                    %>
                    <input type="hidden" name="username" value="<%=username%>">
                    <button title="Next <%=max%> Users" id="form-submit" type="submit">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
                </form>
                <div class="col-xs-12"><br></div>
            </div>
            <%
                if(count == 1) {
            %>
            <div class="col-xs-4"></div>
            <%
                    }
                }
            %>
            <h4>
                <div class="row">
                    <div class="col-xs-12"><br></div>
                    <%
                        UserInfo user;
                        int printed = 1;
                        int tracker = 1;
                        String id;
                        if(request.getAttribute(Integer.toString(count)) != null) {
                            id = (String) request.getAttribute(Integer.toString(count));
                        }
                        else {
                            id = request.getParameter(Integer.toString(count));
                        }
                        while((user = userInfo.getUser(id)) != null) {
                            UserFavoriteInfo favorite;
                            boolean favorited = false;
                            int num = 1;
                            while((favorite = userFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(favorite.getUser().equals(username) && favorite.getUserId().equals(id)) {
                                    favorited = true;
                                    break;
                                }
                                num++;
                            }
                            String picture = user.getPicture();
                    %>
                    <div class="col-xs-4 col-sm-3 col-md-2">
                        <img class="img-special" width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img">
                        <%if(user.getUsername().equals(username)) {%>
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Edit Profile Information" onclick="document.getElementById('editForm').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                            </div>
                        </div>
                        <form id="editForm" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="edit_profile">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%
                            } else {
                                if(username != null && !username.equals("")) {
                        %>
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <%
                                if(favorited) {
                            %>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove User From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                            </div>
                            <%} else {%>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add User To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                            </div>
                            <%}%>
                        </div>
                        <form id="favoriteForm<%=id%>" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%} else {%>
                        <br>
                        <%}}%>
                        <p align="center" style="position: relative;top: -5px;">
                            <a id="menu-item" onclick="document.getElementById('userForm<%=id%>').submit();">
                                <%=user.getUsername()%> (<%=user.getName()%>)
                            </a>
                        </p>
                        <form id="userForm<%=id%>" action="UserServlet" method="POST">
                            <input type="hidden" name="action" value="user">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                    </div>
                    <%
                        String spacer = "";
                        if((printed % 3) == 0) {
                            spacer += "col-xs-12";
                        }
                        else {
                            spacer += "hidden-xs";
                        }
                        if((printed % 4) == 0) {
                            spacer += " col-sm-12";
                        }
                        else {
                            spacer += " hidden-sm";
                        }
                        if((printed % 6) == 0) {
                            spacer += " col-md-12";
                        }
                        else {
                            spacer += " hidden-md hidden-lg";
                        }
                    %>
                    <div class="<%=spacer%>"><br></div>
                    <%
                            if(tracker >= max) {
                                break;
                            }
                            tracker++;
                            printed++;
                            count++;
                            if(request.getAttribute(Integer.toString(count)) != null) {
                                id = (String) request.getAttribute(Integer.toString(count));
                            }
                            else {
                                id = request.getParameter(Integer.toString(count));
                            }
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                        }
                    %>
                </div>
            </h4>
        </div>
    </div>
</div>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>
