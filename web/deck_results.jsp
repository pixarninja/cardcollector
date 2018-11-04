<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="deckFavoriteInfo" class="beans.DeckFavoriteInfo" scope="request"/>
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
            <h2>Search Results: Decks</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a deck's information page by clicking the "View" link. You may add the cards from the deck to your selection by clicking the "Add" link.</p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
                int max = 24;
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
                %><h3>Showing: <%=count%> through <%=end%> out of <%=total%></h3><hr><%
                int i;
            %>
            <form id="requestLessForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="less_decks">
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
            </form>
            <form id="requestMoreForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="more_decks">
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
            </form>
            <%
                if(count > 1) {
                    if(end >= total) {
            %>
            <div class="col-xs-4"></div>
            <%}%>
            <div class="col-xs-4">
                <div class="col-xs-12"><br></div>
                <button title="Previous <%=max%> Decks" id="form-submit" type="button" onclick="document.getElementById('requestLessForm').submit();"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
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
                    <button title="Next <%=max%> Decks" id="form-submit" type="button" onclick="document.getElementById('requestMoreForm').submit();">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
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
                        DeckInfo deck;
                        int printed = 1;
                        int tracker = 1;
                        int id;
                        if(request.getAttribute(Integer.toString(count)) != null) {
                            id = Integer.parseInt((String) request.getAttribute(Integer.toString(count)));
                        }
                        else if(request.getParameter(Integer.toString(count)) != null) {
                            id = Integer.parseInt(request.getParameter(Integer.toString(count)));
                        }
                        else {
                            id = 0;
                        }
                        while((deck = deckInfo.getDeckById(id)) != null) {
                            DeckFavoriteInfo favorite;
                            boolean favorited = false;
                            int num = 1;
                            while((favorite = deckFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(favorite.getUser().equals(username) && favorite.getDeckId() == id) {
                                    favorited = true;
                                    break;
                                }
                                num++;
                            }
                            String top = deck.getTop();
                            if(top == null) {
                                top = "images/magic_card_back.jpg";
                            }
                            String bottom = deck.getBottom();
                            if(bottom == null) {
                                bottom = "images/magic_card_sleeves_default.jpg";
                            }
                    %>
                    <div class="col-xs-6 col-sm-4 col-md-3">
                        <div class="deck-image">
                            <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img"></img>
                            <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img"></img>
                        </div>
                        <%if(deck.getUser().equals(username)) {%>
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Edit Deck" onclick="document.getElementById('editForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                            </div>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                                <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                            </div>
                        </div>
                        <form id="editForm<%=id%>" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%=id%>">
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
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                            </div>
                            <%} else {%>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Add Deck To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                            </div>
                            <%}%>
                        </div>
                        <form id="favoriteForm<%=id%>" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%} else {%>
                        <br>
                        <%}}%>
                        <p align="center" style="position: relative;top: -5px;">
                            <a id="menu-item" onclick="document.getElementById('deckForm<%=id%>').submit();">
                                <%=deck.getName()%> by <%=deck.getUser()%> (<%=deck.getTotal()%>)
                            </a>
                        </p>
                        <form id="deckForm<%=id%>" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="deck">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                    </div>
                    <%
                        String spacer = "";
                        if((printed % 2) == 0) {
                            spacer += "col-xs-12";
                        }
                        else {
                            spacer += "hidden-xs";
                        }
                        if((printed % 3) == 0) {
                            spacer += " col-sm-12";
                        }
                        else {
                            spacer += " hidden-sm";
                        }
                        if((printed % 4) == 0) {
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
                                id = Integer.parseInt((String) request.getAttribute(Integer.toString(count)));
                            }
                            else if(request.getParameter(Integer.toString(count)) != null) {
                                id = Integer.parseInt(request.getParameter(Integer.toString(count)));
                            }
                            else {
                                id = 0;
                            }
                            try {
                                Thread.sleep(250);
                            } catch(InterruptedException ex) {
                                System.out.println("ERROR: sleep was interrupted!");
                            }
                        }%><div class="col-xs-12"></div><%
                        count = 0;
                        total = 0;
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
                        end = 0;
                        if((count + max - 1) < total) {
                            end = count + max - 1;
                        }
                        else {
                            end = total;
                        }
                        if(count > 1) {
                        if(end >= total) {
                    %>
                    <div class="col-xs-4"></div>
                    <%}%>
                    <div class="col-xs-4">
                        <button title="Previous <%=max%> Decks" id="form-submit" type="button" onclick="document.getElementById('requestLessForm').submit();"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
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
                        <button title="Next <%=max%> Decks" id="form-submit" type="button" onclick="document.getElementById('requestMoreForm').submit();">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
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
                </div>
            </h4>
        </div>
    </div>
</div>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>
