<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="cardFavoriteInfo" class="beans.CardFavoriteInfo" scope="request"/>
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
    int count = 1;
    String collectionIdList = "";
    String collectionNameList = "";
    int collectionNum = 0;
    CollectionInfo collection;
    while((collection = collectionInfo.getCollectionByNum(count)) != null) {
        if(collection.getUser().equals(username)) {
            collectionNum++;
            if(collectionNum > 1) {
                collectionIdList += "`";
                collectionNameList += "`";
            }
            collectionIdList += collection.getId();
            collectionNameList += collection.getName();
        }
        count++;
    }
    String deckIdList = "";
    String deckNameList = "";
    int deckNum = 0;
    DeckInfo deck;
    count = 1;
    while((deck = deckInfo.getDeckByNum(count)) != null) {
        if(deck.getUser().equals(username)) {
            deckNum++;
            if(deckNum > 1) {
                deckIdList += "`";
                deckNameList += "`";
            }
            deckIdList += deck.getId();
            deckNameList += deck.getName();
        }
        count++;
    }
%>
<%@include file="header.jsp"%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Search Results: Cards</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a card's information page by clicking the link below it. You may add the card to a deck or collection by clicking the plus button, and you can add the card to your favorites list by clicking the star button.</p>
                <br>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
                int max = 24;
                count = 0;
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
                <input type="hidden" name="action" value="less_cards">
                <input type="hidden" name="total" value="<%=total%>">
                <input type="hidden" name="start" value="<%=count - max%>">
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
                <input type="hidden" name="action" value="more_cards">
                <input type="hidden" name="total" value="<%=total%>">
                <input type="hidden" name="start" value="<%=count + max%>">
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
                <button title="Previous <%=max%> Cards" id="form-submit" type="button" onclick="document.getElementById('requestLessForm').submit();"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
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
                <button title="Next <%=max%> Cards" id="form-submit" type="button" onclick="document.getElementById('requestMoreForm').submit();">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
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
                        CardInfo card;
                        int printed = 1;
                        int tracker = 1;
                        String id;
                        if(request.getAttribute(Integer.toString(count)) != null) {
                            id = (String) request.getAttribute(Integer.toString(count));
                        }
                        else {
                            id = request.getParameter(Integer.toString(count));
                        }
                        while((card = cardInfo.getCardById(id)) != null) {
                            CardFavoriteInfo favorite;
                            boolean favorited = false;
                            int num = 1;
                            while((favorite = cardFavoriteInfo.getFavoriteByNum(num)) != null) {
                                if(favorite.getUser().equals(username) && favorite.getCardId().equals(id)) {
                                    favorited = true;
                                    break;
                                }
                                num++;
                            }
                    %>
                    <div class="col-xs-6 col-sm-4 col-md-3">
                        <img class="img-special" width="100%" src="<%=card.getFront()%>" alt="<%=card.getFront()%>" id="center-img">
                        <%
                            if(username != null && !username.equals("")) {
                        %>
                        <br>
                        <div class="row" style="margin: auto;display: table">
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Add Card To Collection/Deck" onclick="addCardPopup('<%=card.getId()%>', '<%=card.getFront()%>', '<%=username%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">
                                <span id="button-symbol" class="glyphicon glyphicon-plus"></span>
                            </div>
                            <%
                                if(favorited) {
                            %>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Remove Card From Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                            </div>
                            <%} else {%>
                            <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Add Card To Favorites List" onclick="document.getElementById('favoriteForm<%=id%>').submit();">
                                <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                            </div>
                            <%}%>
                        </div>
                        <form id="favoriteForm<%=id%>" action="CardServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <%} else {%>
                        <br>
                        <%}%>
                        <p align="center" style="position: relative;top: -5px;">
                            <a id="menu-item" onclick="document.getElementById('cardForm<%=id%>').submit();">
                                <%=card.getName()%> (<%=card.getSetName()%>)
                            </a>
                        </p>
                        <form id="cardForm<%=id%>" action="CardServlet" method="POST">
                            <input type="hidden" name="action" value="card">
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
                        <button title="Previous <%=max%> Cards" id="form-submit" type="button" onclick="document.getElementById('requestLessForm').submit();"><span class="glyphicon glyphicon-menu-left"></span>&nbsp;&nbsp;Previous <%=max%></button>
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
                        <button title="Next <%=max%> Cards" id="form-submit" type="button" onclick="document.getElementById('requestMoreForm').submit();">Next <%=max%>&nbsp;&nbsp;<span class="glyphicon glyphicon-menu-right"></span></button>
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
