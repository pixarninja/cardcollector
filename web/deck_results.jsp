<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
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
    if(username == null || username.equals("null")) {
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
<script src="js/scripts.js"></script>
<%@include file="header.jsp"%>
<%
    UserInfo user = userInfo.getUser(username);;
    String cardImage;
    String sleevesImage;
    String picture;
    if(user == null) {
        cardImage = "images/magic_card_back_hd.png";
        sleevesImage = "images/magic_card_sleeves_default.png";
        picture = "images/icons/battered-axe.png";
    }
    else {
        cardImage = user.getPicture();
        sleevesImage = user.getPicture();
        picture = user.getPicture();
    }
%>
<!-- Content -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Search Results: Decks</h2><br>
            <h4>
                <p>Below are the results of your search. You may choose to view a deck's information page by clicking the "View" link. You may add the cards from the deck to your selection by clicking the "Add" link.</p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <%
                    int count = 1;
                    if(request.getParameter("start") != null && request.getParameter("start") != "") {
                        count = Integer.parseInt(request.getParameter("start"));
                    }
                    int total = 8;
                    if(request.getParameter("total") != null && request.getParameter("total") != "") {
                        total = Integer.parseInt(request.getParameter("total"));
                    }
                    else if(request.getAttribute("total") != null && request.getAttribute("total") != ""){
                        total = (int)request.getAttribute("total");
                    }
                    int end = 0;
                    if((count + 99) < total) {
                        end = count + 99;
                    }
                    else {
                        end = total;
                    }
                %>
                <h3>Showing: <%=end%> out of <%=total%></h3><hr>
                <%
                    if(count != 1) {
                %>
                <div class="col-xs-6">
                    <form id="requestLessForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="decks">
                        <input type="hidden" name="start" value="<%=count - 100%>">
                        <input type="hidden" name="total" value="<%=total%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
                        <input type="hidden" name="publisher" value="<%=request.getParameter("publisher")%>">
                        <input type="hidden" name="studio" value="<%=request.getParameter("studio")%>">
                        <input type="hidden" name="platform" value="<%=request.getParameter("platform")%>">
                        <input type="hidden" name="min-score" value="<%=request.getParameter("min-score")%>">
                        <input type="hidden" name="max-score" value="<%=request.getParameter("max-score")%>">
                        <input id="form-submit" type="submit" value="Previous 100 Decks">
                      </form>
                </div>
                <%}%>
                <%
                    if(end < total) {
                %>
                <div class="col-xs-6">
                    <form id="requestMoreForm" action="SearchServlet" method="POST">
                        <input type="hidden" name="action" value="decks">
                        <input type="hidden" name="start" value="<%=count + 100%>">
                        <input type="hidden" name="total" value="<%=total%>">
                        <input type="hidden" name="username" value="<%=username%>">
                        <input type="hidden" name="title" value="<%=request.getParameter("title")%>">
                        <input type="hidden" name="publisher" value="<%=request.getParameter("publisher")%>">
                        <input type="hidden" name="studio" value="<%=request.getParameter("studio")%>">
                        <input type="hidden" name="platform" value="<%=request.getParameter("platform")%>">
                        <input type="hidden" name="min-score" value="<%=request.getParameter("min-score")%>">
                        <input type="hidden" name="max-score" value="<%=request.getParameter("max-score")%>">
                        <input id="form-submit" type="submit" value="Next 100 Decks">
                    </form>
                </div>
                <%}%>
                <h4>
                    <div class="row">
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-6 col-sm-3 col-md-2">
                            <p align="center">Deck Name</p>
                            <br>
                            <div class="deck-image">
                                <img class="sleeves-alt" width="100%" src="<%=sleevesImage%>" alt="<%=sleevesImage%>" id="center-img"></img>
                                <img class="cover" width="100%" src="<%=cardImage%>" alt="<%=cardImage%>" id="center-img"></img>
                            </div>
                            <br><br>
                            <form id="deckForm" action="DeckServlet" method="POST">
                                <input type="hidden" name="action" value="deck">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="View Deck Information" id="alt-submit" type="submit"><span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;View</button>
                            </form>
                            <form id="addForm" action="SelectionServlet" method="POST">
                                <input type="hidden" name="action" value="add_deck_to_selection">
                                <input type="hidden" name="username" value="<%=username%>">
                                <button title="Add To Selection" id="alt-submit" type="submit"><span class="glyphicon glyphicon-download-alt"></span>&nbsp;&nbsp;Add</button>
                            </form>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                </h4>
                <div class="col-xs-12"><br></div>
            </h4>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>
