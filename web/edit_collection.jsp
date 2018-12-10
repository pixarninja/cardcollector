<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="collectionContentsInfo" class="beans.CollectionContentsInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
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
<%
    int id = Integer.parseInt(request.getParameter("id"));
    CollectionInfo collection = collectionInfo.getCollectionById(id);
    if(collection != null) {
%>
<!-- Content -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Edit Collection Information</h2><br>
            <h4>
                <p>Fill out any of the fields below to replace the fields of the selected collection's information. Click the "Submit" button once you are done editing the information.</p>
                <br><br>
            </h4>
        </div>
        <div class="col-xs-12">
            <h4>
                <form id="editProfileForm" action="CollectionServlet" method="POST">
                    <input type="hidden" name="action" value="submit_edit">
                    <input type="hidden" name="id" value="<%=collection.getId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                    <hr>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Collection Title</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            Enter the title for this collection.<br><br>
                            <input id="input-field" name="name" type="text" value="<%=collection.getName()%>"><br><br>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-5 col-sm-4">
                            <p id="title">Collection Description</p>
                        </div>
                        <div class="col-xs-7 col-sm-8">
                            You may enter a description for this collection.<br><br>
                            <%
                                if(collection.getDescription() == null || collection.getDescription().equals("")) {
                            %>
                            <textarea id="input-field" name="description"></textarea>
                            <%} else {%>
                            <textarea id="input-field" name="description"><%=collection.getDescription()%></textarea>
                            <%}%>
                        </div>
                        <div class="col-xs-12"><hr></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-lg-4">
                            <p id="title">Collection Contents and Appearance</p><br>
                            <%
                                CollectionContentsInfo collectionContents;
                                String top = collection.getTop();
                                if(top == null) {
                                    top = "images/magic_card_back.jpg";
                                }
                                else {
                                    CardInfo card = cardInfo.getCardById(top);
                                    if(card != null) {
                                        String[] imageURLs = card.getImageURLs();
                                        top = imageURLs[0];
                                        if(top == null) {
                                            top = "images/magic_card_back.jpg";
                                        }
                                    }
                                    else {
                                        top = "images/magic_card_back.jpg";
                                    }
                                }
                                String middle = collection.getMiddle();
                                if(middle == null) {
                                    middle = "images/magic_card_back.jpg";
                                }
                                else {
                                    CardInfo card = cardInfo.getCardById(middle);
                                    if(card != null) {
                                        String[] imageURLs = card.getImageURLs();
                                        middle = imageURLs[0];
                                        if(middle == null) {
                                            middle = "images/magic_card_back.jpg";
                                        }
                                    } else {
                                        middle = "images/magic_card_back.jpg";
                                    }
                                }
                                String bottom = collection.getBottom();
                                if(bottom == null) {
                                    bottom = "images/magic_card_back.jpg";
                                }
                                else {
                                    CardInfo card = cardInfo.getCardById(bottom);
                                    if(card != null) {
                                        String[] imageURLs = card.getImageURLs();
                                        bottom = imageURLs[0];
                                        if(bottom == null) {
                                            bottom = "images/magic_card_back.jpg";
                                        }
                                    }
                                    else {
                                        bottom = "images/magic_card_back.jpg";
                                    }
                                }
                                int entries = collection.getEntries();
                            %>
                            <h4>
                                <div class="collection-image">
                                    <img class="buffer" width="100%" src="images/buffer.png" id="center-img">
                                    <img class="img-special collect-back" width="100%" src="<%=bottom%>" alt="<%=bottom%>"></img>
                                    <img class="img-special collect-mid" width="100%" src="<%=middle%>" alt="<%=middle%>"></img>
                                    <img class="img-special collect-fore" width="100%" src="<%=top%>" alt="<%=top%>"></img>
                                </div>
                            </h4>
                        </div>
                        <div class="col-xs-12 hidden-lg"><br></div>
                        <div class="col-xs-12 col-lg-8" id="capsule">
                            <div class="col-xs-4">
                                <span style="float: right;">
                                    Change Top
                                </span>
                            </div>
                            <div class="col-xs-8">
                                <select name="top" id="input-field">
                                    <option value=""></option>
                                    <%
                                        int num = 1;
                                        while((collectionContents = collectionContentsInfo.getContentsByNum(num)) != null) {
                                            if(collectionContents.getCollectionId() == id) {
                                                CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                    %>
                                    <option value="<%=card.getId()%>"><%=card.getName()%></option>
                                    <%
                                            }
                                            num++;
                                        }
                                    %>
                                </select><br><br><br>
                            </div>
                            <div class="col-xs-4">
                                <span style="float: right;">
                                    Change Middle
                                </span>
                            </div>
                            <div class="col-xs-8">
                                <select name="middle" id="input-field">
                                    <option value=""></option>
                                    <%
                                        num = 1;
                                        while((collectionContents = collectionContentsInfo.getContentsByNum(num)) != null) {
                                            if(collectionContents.getCollectionId() == id) {
                                                CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                    %>
                                    <option value="<%=card.getId()%>"><%=card.getName()%></option>
                                    <%
                                            }
                                            num++;
                                        }
                                    %>
                                </select><br><br><br>
                            </div>
                            <div class="col-xs-4">
                                <span style="float: right;">
                                    Change Bottom
                                </span>
                            </div>
                            <div class="col-xs-8">
                                <select name="bottom" id="input-field">
                                    <option value=""></option>
                                    <%
                                        num = 1;
                                        while((collectionContents = collectionContentsInfo.getContentsByNum(num)) != null) {
                                            if(collectionContents.getCollectionId() == id) {
                                                CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                    %>
                                    <option value="<%=card.getId()%>"><%=card.getName()%></option>
                                    <%
                                            }
                                            num++;
                                        }
                                    %>
                                </select><br><br><br>
                            </div>
                            <p>You may copy cards to a different collection, update the number of cards in this collection, or remove them from this collection by using the options below.</p><br>
                            <div class="col-xs-12 hidden-lg"><br></div>
                            <h4>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="well col-xs-12" id="black-well">
                                            <div class="col-xs-1"></div>
                                            <div class="col-xs-5">
                                                Card Name
                                            </div>
                                            <div class="col-xs-5">
                                                Number in Collection
                                            </div>
                                            <div class="col-xs-12"><hr></div>
                                            <div>
                                                <%
                                                    num = 1;
                                                    int printed = 1;
                                                    String spacer;
                                                    while((collectionContents = collectionContentsInfo.getContentsByNum(num)) != null) {
                                                        if(collectionContents.getCollectionId() == id) {
                                                            CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                                            String legalities = card.getLegalities();
                                                            String legalityText = "";
                                                            if(legalities.charAt(0) == '1') {
                                                                legalityText += "S";
                                                            }
                                                            if(legalities.charAt(1) == '1') {
                                                                legalityText += "F";
                                                            }
                                                            if(legalities.charAt(2) == '1') {
                                                                legalityText += "R";
                                                            }
                                                            if(legalities.charAt(3) == '1') {
                                                                legalityText += "M";
                                                            }
                                                            if(legalities.charAt(4) == '1') {
                                                                legalityText += "L";
                                                            }
                                                            if(legalities.charAt(5) == '1') {
                                                                legalityText += "A";
                                                            }
                                                            if(legalities.charAt(6) == '1') {
                                                                legalityText += "V";
                                                            }
                                                            if(legalities.charAt(7) == '1') {
                                                                legalityText += "P";
                                                            }
                                                            if(legalities.charAt(8) == '1') {
                                                                legalityText += "C";
                                                            }
                                                            if(legalities.charAt(9) == '1') {
                                                                legalityText += "1";
                                                            }
                                                            if(legalities.charAt(10) == '1') {
                                                                legalityText += "D";
                                                            }
                                                            if(legalities.charAt(11) == '1') {
                                                                legalityText += "B";
                                                            }
                                                            if(legalityText == "") {
                                                                legalityText = "-";
                                                            }
                                                            if(printed == entries) {
                                                                spacer = "hidden-xs hidden-sm hidden-md hidden-lg";
                                                            }
                                                            else {
                                                                spacer = "col-xs-12";
                                                            }
                                                %>
                                                <div class="col-xs-1">
                                                    <input type="checkbox" name="<%=printed%>" value="<%=collectionContents.getCardId()%>">
                                                </div>
                                                <div class="col-xs-5 hidden-sm hidden-md hidden-lg">
                                                    <a id="menu-item" onclick="document.getElementById('cardForm<%=collectionContents.getCardId()%>').submit();">
                                                        <%=card.getName()%> (<%=legalityText%>)
                                                    </a>
                                                </div>
                                                <div class="hidden-xs col-sm-5">
                                                    <div id="container<%=collectionContents.getCardId()%>">
                                                        <span onmouseover="reveal('image<%=collectionContents.getCardId()%>', 'container<%=collectionContents.getCardId()%>', 'capsule', 'edit_deck')" onmouseout="conceal('image<%=collectionContents.getCardId()%>')">
                                                            <a id="menu-item" onclick="document.getElementById('cardForm<%=collectionContents.getCardId()%>').submit();">
                                                                <%=card.getName()%> (<%=legalityText%>)
                                                            </a>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-xs-5">
                                                    <input id="input-field" class="input-number" type="number" name="total<%=collectionContents.getCardId()%>" value="<%=collectionContents.getCardTotal()%>">
                                                </div>
                                                <div class="<%=spacer%>"><br></div>
                                                <%
                                                            printed++;
                                                        }
                                                        num++;
                                                    }
                                                %>
                                                <input type="hidden" name="<%=printed%>" value="ENDTOKEN">
                                            </div>
                                            <div class="col-xs-12"><hr></div>
                                            <div class="col-xs-1">
                                                <input type="checkbox" name="0" value="select_all">
                                            </div>
                                            <div class="col-xs-10">
                                                Select All
                                            </div>
                                            <div class="col-xs-12"><hr></div>
                                            <div class="col-xs-6">
                                                <span style="float: right;">
                                                    Copy Selected To Deck:
                                                </span>
                                            </div>
                                            <div class="col-xs-6">
                                                <select name="copy_deck" id="input-field">
                                                    <option value="">Choose deck...</option>
                                                    <%
                                                        num = 1;
                                                        DeckInfo deck;
                                                        while((deck = deckInfo.getDeckByNumAlpha(num)) != null) {
                                                            if(deck.getUser().equals(username)) {
                                                    %>
                                                    <option value="<%=deck.getId()%>"><%=deck.getName()%></option>
                                                    <%
                                                            }
                                                            num++;
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="col-xs-12"><br></div>
                                            <div class="col-xs-6">
                                                <span style="float: right;">
                                                    Copy Selected To Collection:
                                                </span>
                                            </div>
                                            <div class="col-xs-6">
                                                <select name="copy_collection" id="input-field">
                                                    <option value="">Choose collection...</option>
                                                    <%
                                                        num = 1;
                                                        while((collection = collectionInfo.getCollectionByNumAlpha(num)) != null) {
                                                            if(collection.getId() != id && collection.getUser().equals(username)) {
                                                    %>
                                                    <option value="<%=collection.getId()%>"><%=collection.getName()%></option>
                                                    <%
                                                            }
                                                            num++;
                                                        }
                                                    %>
                                                </select><br><br>
                                            </div>
                                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                                            <div class="col-xs-6">
                                                <span style="float: right;">
                                                    Delete Selected
                                                </span>
                                            </div>
                                            <div class="col-xs-6">
                                                <input type="checkbox" name="delete" value="delete_selected"><br>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    num = 1;
                                    while((collectionContents = collectionContentsInfo.getContentsByNum(num)) != null) {
                                        if(collectionContents.getCollectionId() == id) {
                                            CardInfo card = cardInfo.getCardById(collectionContents.getCardId());
                                            String[] imageURLs = card.getImageURLs();
                                            String front = imageURLs[0];
                                            if(front == null) {
                                                front = "images/magic_card_back.jpg";
                                            }
                                %>
                                <form id="cardForm<%=collectionContents.getCardId()%>" action="CardServlet" method="POST">
                                    <input type="hidden" name="action" value="card">
                                    <input type="hidden" name="id" value="<%=collectionContents.getCardId()%>">
                                    <input type="hidden" name="username" value="<%=username%>">
                                </form>
                                <img class="img-special" id="image<%=collectionContents.getCardId()%>" src="<%=front%>" alt="<%=front%>" style="display: none;"/>
                                <%
                                        }
                                        num++;
                                    }
                                %>
                            </h4>
                            <div class="row">
                                <div class="hidden-xs col-sm-6"></div>
                                <div class="col-xs-12 col-sm-6">
                                    <button title="Submit Collection Edit" id="form-submit" type="submit">Submit</button><br><br><br>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </h4>
        </div>
    </div>
</div>
<%
    } else {
%>
<!-- Error -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Edit Collection Information</h2><br>
            <h4>
                <p>The collection you selected has no information to edit.</p>
                <br>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>