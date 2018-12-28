<%@page import="java.util.Arrays"%>
<%@page import="java.util.Iterator"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.bundle.min.js" type="text/javascript"></script>
<%@page import="java.util.HashMap"%>
<%@page import="java.math.RoundingMode"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="deckContentsInfo" class="beans.DeckContentsInfo" scope="request"/>
<jsp:useBean id="deckCommentInfo" class="beans.DeckCommentInfo" scope="request"/>
<jsp:useBean id="deckFavoriteInfo" class="beans.DeckFavoriteInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="moreCardInfo" class="beans.MoreCardInfo" scope="request"/>
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
%>
<%@include file="header.jsp"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    int count = 1;
    String collectionIdList = "";
    String collectionNameList = "";
    int collectionNum = 0;
    CollectionInfo collection;
    while((collection = collectionInfo.getCollectionByNumAlpha(count)) != null) {
        if(collection.getUser().equals(username)) {
            collectionNum++;
            if(collectionNum > 1) {
                collectionIdList += "`";
                collectionNameList += "`";
            }
            collectionIdList += collection.getId();
            String name = "";
            for(int i = 0; i < collection.getName().length(); i++) {
                name += (int) collection.getName().charAt(i) + ".";
            }
            collectionNameList += name;
        }
        count++;
    }
    String deckIdList = "";
    String deckNameList = "";
    int deckNum = 0;
    DeckInfo deck;
    count = 1;
    while((deck = deckInfo.getDeckByNumAlpha(count)) != null) {
        if(deck.getUser().equals(username)) {
            deckNum++;
            if(deckNum > 1) {
                deckIdList += "`";
                deckNameList += "`";
            }
            deckIdList += deck.getId();
            String name = "";
            for(int i = 0; i < deck.getName().length(); i++) {
                name += (int) deck.getName().charAt(i) + ".";
            }
            deckNameList += name;
        }
        count++;
    }
    deck = (DeckInfo) deckInfo.getDeckById(id);
    int legalityInfo = 0;
    if(deck != null) {
        count = 1;
        String cardIdList = "";
        String cardFrontList = "";
        String cardNameList = "";
        String cardTypeList = "";
        String cardSetList = "";
        String cardTotalList = "";
        String cardColorList = "";
        String cardCostList = "";
        String cardFavoriteList = "";
        
        int whites = 0;
        int blues = 0;
        int blacks = 0;
        int reds = 0;
        int greens = 0;
        int devoids = 0;
        
        HashMap<Float, Integer> manaCosts = new HashMap();
        int cardNum = 0;
        
        double usd = 0.0;
        DeckContentsInfo deckContents;
        while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
            if(deckContents.getDeckId() != id) {
                count++;
                continue;
            }
            MoreCardInfo card = moreCardInfo.getCardById(deckContents.getCardId());
            if(card.getUsd() != null && !card.getUsd().equals("Unknown")) {
                try {
                    usd += deckContents.getCardTotal() * Double.parseDouble(card.getUsd());
                } catch(NumberFormatException ex) {
                    ; // do nothing
                }
            }
            
            if(legalityInfo == 0 && cardNum == 0) {
                legalityInfo = Integer.parseInt(card.getLegalities(), 2);
            }
            else {
                legalityInfo &= Integer.parseInt(card.getLegalities(), 2);
            }
            cardNum++;
            if(cardNum > 1) {
                cardIdList += "`";
                cardFrontList += "`";
                cardNameList += "`";
                cardTypeList += "`";
                cardSetList += "`";
                cardTotalList += "`";
                cardColorList += "`";
                cardCostList += "`";
                cardFavoriteList += "`";
            }
            cardIdList += card.getId();
            String[] imageURLs = card.getImageURLs();
            String front = imageURLs[0];
            if(front == null) {
                front = "images/magic_card_back.jpg";
            }
            cardFrontList += front;
            cardNameList += card.getName().replace("'", "\\'").replace("\"", "\\\"");
            cardTypeList += card.getType().replace("'", "\\'").replace("\"", "\\\"");
            cardSetList += card.getSetName().replace("'", "\\'").replace("\"", "\\\"");
            cardTotalList += deckContents.getCardTotal();
            int i;
            String[] parsedColors = card.getColors().split(", ");
            String colors = "";
            if(card.getColors() != null && card.getColors() != "") {
                for(i = 0; i < parsedColors.length; i++) {
                    String symbol = parsedColors[i];
                    if(symbol.contains("W")) {
                        whites += deckContents.getCardTotal();
                        if(colors.equals("")) {
                            colors = "White";
                        }
                        else {
                            colors = colors + ", White";
                        }
                    } else if (symbol.contains("U")) {
                        blues += deckContents.getCardTotal();
                        if(colors.equals("")) {
                            colors = "Blue";
                        }
                        else {
                            colors = colors + ", Blue";
                        }
                    } else if (symbol.contains("B")) {
                        blacks += deckContents.getCardTotal();
                        if(colors.equals("")) {
                            colors = "Black";
                        }
                        else {
                            colors = colors + ", Black";
                        }
                    } else if (symbol.contains("R")) {
                        reds += deckContents.getCardTotal();
                        if(colors.equals("")) {
                            colors = "Red";
                        }
                        else {
                            colors = colors + ", Red";
                        }
                    } else if (symbol.contains("G")) {
                        greens += deckContents.getCardTotal();
                        if(colors.equals("")) {
                            colors = "Green";
                        }
                        else {
                            colors = colors + ", Green";
                        }
                    }
                }
                if(colors.equals("") || (card.getText() != null && card.getText().contains("Devoid"))) {
                    if(card.getConvertedManaCost() != 0) {
                        devoids += deckContents.getCardTotal();
                    }
                    colors = "Devoid";
                }
            }
            else {
                colors = "Devoid";
            }
            cardColorList += colors;
            cardCostList += card.getConvertedManaCost();
            
            if(manaCosts.containsKey(card.getConvertedManaCost())) {
                manaCosts.put(card.getConvertedManaCost(), manaCosts.get(card.getConvertedManaCost()) + deckContents.getCardTotal());
            }
            else {
                manaCosts.put(card.getConvertedManaCost(), deckContents.getCardTotal());
            }
            
            CardFavoriteInfo favorite;
            boolean favorited = false;
            int num = 1;
            while((favorite = cardFavoriteInfo.getFavoriteByNum(num)) != null) {
                if(favorite.getUser().equals(username) && favorite.getCardId().equals(card.getId())) {
                    favorited = true;
                    break;
                }
                num++;
            }
            if(favorited) {
                cardFavoriteList += "1";
            }
            else {
                cardFavoriteList += "0";
            }
            count++;
        }
        
        /* parse keys for mana costs */
        int index;
        float keys[] = new float [manaCosts.size()];
        int vals[] = new int [manaCosts.size()];
        for(index = 0; index < manaCosts.size(); index++) {
            keys[index] = Float.MAX_VALUE;
            vals[index] = Integer.MAX_VALUE;
        }
        
        /* sort keys and vals */
        for (HashMap.Entry<Float, Integer> entry : manaCosts.entrySet()) {
            for(index = 0; index < manaCosts.size() - 1; index++) {
                if(keys[index] > entry.getKey()) {
                    /* move all indices to the right */
                    for(int tmpIndex = manaCosts.size() - 2; tmpIndex >= index; tmpIndex--) {
                        keys[tmpIndex + 1] = keys[tmpIndex];
                        vals[tmpIndex + 1] = vals[tmpIndex];
                    }
                    break;
                }
            }
            keys[index] = entry.getKey();
            vals[index] = entry.getValue();
        }
                
        String costData = "";
        String costLabels = "";
        String costBackgroundColor = "";
        String costBackgroundBorder = "";
        int r = 51;
        int g = 153;
        int b = 255;
        for(index = 0; index < manaCosts.size(); index++) {
            if(!costData.equals("")) {
                costData += ", ";
                costLabels += ", ";
                costBackgroundColor += ", ";
                costBackgroundBorder += ", ";
                r = 51 + (index + 1) * (255 - 51) / manaCosts.size();
                if(r > 255) {
                    r = 255;
                }
                b = 255 - (index + 1) * (255 - 51) / manaCosts.size();
                if(b < 0) {
                    b = 0;
                }
            }
            costData += vals[index];
            costLabels += "'" + keys[index] + "'";
            costBackgroundColor += "'rgba(" + r + ", " + g + ", " + b + ", 1.0)'";
            costBackgroundBorder += "'white'";
        }
        
        int totalColors = whites + blues + blacks + reds + greens + devoids;
        int numColors = 0;
        if(whites > 0) {
            numColors += 1;
        }
        if(blues > 0) {
            numColors += 1;
        }
        if(blacks > 0) {
            numColors += 1;
        }
        if(reds > 0) {
            numColors += 1;
        }
        if(greens > 0) {
            numColors += 1;
        }
        if(devoids > 0) {
            numColors += 1;
        }
        int countColors = 0;
        
        String colorLabels = "";
        String colorData = "";
        String colorBackgroundColor = "";
        String colorBackgroundBorder = "";
        
        if(whites > 0) {
            countColors += 1;
            colorLabels += "'White'";
            colorData += String.format ("%.2f", whites / (float)totalColors);
            colorBackgroundColor += "'lightyellow'"; // white
            colorBackgroundBorder += "'white'"; // white
            if(countColors < numColors) {
                colorLabels += ", ";
                colorData += ", ";
                colorBackgroundColor += ", ";
                colorBackgroundBorder += ", ";
            }
        }
        if(blues > 0) {
            countColors += 1;
            colorLabels += "'Blue'";
            colorData += String.format ("%.2f", blues / (float)totalColors);
            colorBackgroundColor += "'skyblue'"; // blue
            colorBackgroundBorder += "'white'"; // blue
            if(countColors < numColors) {
                colorLabels += ", ";
                colorData += ", ";
                colorBackgroundColor += ", ";
                colorBackgroundBorder += ", ";
            }
        }
        if(blacks > 0) {
            countColors += 1;
            colorLabels += "'Black'";
            colorData += String.format ("%.2f", blacks / (float)totalColors);
            colorBackgroundColor += "'darkgray'"; // black
            colorBackgroundBorder += "'white'"; // black
            if(countColors < numColors) {
                colorLabels += ", ";
                colorData += ", ";
                colorBackgroundColor += ", ";
                colorBackgroundBorder += ", ";
            }
        }
        if(reds > 0) {
            countColors += 1;
            colorLabels += "'Red'";
            colorData += String.format ("%.2f", reds / (float)totalColors);
            colorBackgroundColor += "'tomato'"; // red
            colorBackgroundBorder += "'white'"; // red
            if(countColors < numColors) {
                colorLabels += ", ";
                colorData += ", ";
                colorBackgroundColor += ", ";
                colorBackgroundBorder += ", ";
            }
        }
        if(greens > 0) {
            countColors += 1;
            colorLabels += "'Green'";
            colorData += String.format ("%.2f", greens / (float)totalColors);
            colorBackgroundColor += "'mediumseagreen'"; // green
            colorBackgroundBorder += "'white'"; // green
            if(countColors < numColors) {
                colorLabels += ", ";
                colorData += ", ";
                colorBackgroundColor += ", ";
                colorBackgroundBorder += ", ";
            }
        }
        if(devoids > 0) {
            countColors += 1;
            colorLabels += "'Devoid'";
            colorData += String.format ("%.2f", devoids / (float)totalColors);
            colorBackgroundColor += "'plum'"; // devoid
            colorBackgroundBorder += "'white'"; // devoid
            if(countColors < numColors) {
                colorLabels += ", ";
                colorData += ", ";
                colorBackgroundColor += ", ";
                colorBackgroundBorder += ", ";
            }
        }
        
        BigDecimal bd = new BigDecimal(usd);
        bd = bd.setScale(2, RoundingMode.HALF_UP);
        String price = Double.toString(bd.doubleValue());
        String[] subprice = price.split("\\.");
        if(subprice == null || subprice.length < 2) {
            price = price + ".00";
        }
        else {
            while(subprice[1].length() < 2) {
                subprice[1] = subprice[1] + "0";
            }
            price = subprice[0] + "." + subprice[1];
        }
        
        int wins = deck.getWins();
        int losses = deck.getLosses();
        
        String legalities = Integer.toBinaryString(legalityInfo);
        while(legalities.length() < 12) {
            legalities = "0" + legalities;
        }
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
%>
<!-- Content -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Deck Information</h2><br>
            <h4>
                <p>Below is the selected deck's information. If you are the creator of this deck, you will be able to edit or delete it by using the buttons beneath the deck image. If you are not the creator, you may add or remove the deck from your favorites list or print the deck (in order to print with the correct formatting, please remove all margins under PDF options on the generated page). You may write a comment by submitting one at the bottom of the page.<p>
                <br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <%
                String name = deck.getName();
                String top = deck.getTop();
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
                String bottom = deck.getBottom();
                if(bottom == null) {
                    bottom = "images/magic_card_sleeves_default.jpg";
                }
                int entries = deck.getEntries();
                int total = deck.getTotal();
                String user = deck.getUser();
                java.util.Date dateUpdated = deck.getDateUpdated();
                String description = deck.getDescription();
            %>
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <div class="deck-image">
                        <img class="sleeves" width="100%" src="<%=bottom%>" alt="<%=bottom%>" id="center-img">
                        <img class="img-special cover" width="100%" src="<%=top%>" alt="<%=top%>" id="center-img">
                    </div>
                    <br><br>
                    <div class="row" style="margin: auto;display: table">
                        <%
                            if(username != null && !username.equals("")) {
                        %>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Print Deck" onclick="document.getElementById('printForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-print"></span>
                        </div>
                        <%if(deck.getUser().equals(username)) {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-middle" title="Edit Deck" onclick="document.getElementById('editForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                        </div>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Delete Deck" onclick="deleteDeckPopup('<%=id%>', '<%=username%>');">
                            <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                        </div>
                        <form id="editForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <form id="printForm" action="PrintServlet" method="POST" target="_blank">
                            <input type="hidden" name="action" value="deck">
                            <input type="hidden" name="id" value="<%=id%>">
                        </form>
                        <%
                            } else {
                        %>
                        <!--
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-middle" title="Request To Challenge This Deck" onclick="challengeDeckPopup('<%=deck.getId()%>', '<%=top%>', '<%=bottom%>', '<%=username%>', '<%=deck.getUser()%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>', '<%=deck.getWins()%>', '<%=deck.getLosses() + deck.getWins()%>');">
                            <span id="button-symbol" class="glyphicon glyphicon-certificate"></span>
                        </div>
                        -->
                        <%
                            if(favorited) {
                        %>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Remove Deck From Favorites List" onclick="document.getElementById('favoriteForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                        </div>
                        <%} else {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Add Deck To Favorites List" onclick="document.getElementById('favoriteForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                        </div>
                        <%}%>
                        <form id="favoriteForm" action="DeckServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <form id="printForm" action="PrintServlet" method="POST" target="_blank">
                            <input type="hidden" name="action" value="deck">
                            <input type="hidden" name="id" value="<%=id%>">
                        </form>
                        <%}} else {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-pill" title="Print Deck" onclick="document.getElementById('printForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-print"></span>
                        </div>
                        <form id="printForm" action="PrintServlet" method="POST" target="_blank">
                            <input type="hidden" name="action" value="deck">
                            <input type="hidden" name="id" value="<%=id%>">
                        </form>
                        <%}%>
                    </div>
                    <div class="col-xs-12"><br></div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-sm-12 col-lg-4">
                        <p id="title">Price</p>
                    </div>
                    <div class="col-xs-12 hidden-lg"><br></div>
                    <div class="col-sm-12 col-lg-8">
                        <p>$<%=price%></p>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-sm-12 col-lg-4">
                        <p id="title">Legalities</p>
                    </div>
                    <div class="col-xs-12 hidden-lg"><br></div>
                    <%
                        if(legalities.contains("1")) {
                            if(legalities.charAt(0) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Standard</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(1) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Future</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(2) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Frontier</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(3) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Modern</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(4) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Legacy</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(5) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Pauper</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(6) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Vintage</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(7) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Penny</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(8) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Commander</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(9) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>1 vs 1</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(10) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Duel</p>
                    </div>
                    <div class="hidden-sm col-lg-4"></div>
                        <%
                            }
                        if(legalities.charAt(11) == '1') {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>Brawl</p>
                    </div>
                        <%
                            }
                        } else {
                    %>
                    <div class="col-sm-12 col-lg-8">
                        <p>None</p>
                    </div>
                    <%}%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="col-sx-12">
                            <p id="title">Data Distribution</p>
                        </div>
                        <canvas id="color-distribution" width="100%"></canvas>
                        <br>
                        <canvas id="cost-distribution" width="100%" height="125%"></canvas>
                    </div>
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h2 id="capsule"><%=name%><hr></h2>
                <h4>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Created By</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=user%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Date Updated</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=dateUpdated%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Card Total</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=total%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Unique Cards</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=entries%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <!--
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Wins</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=wins%></p>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Losses</p>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=losses%></p>
                        </div>
                    </div>
                    -->
                    <% if(description != null) {%>
                    <div class="row">
                    <div class="col-xs-12"><br></div>
                        <div class="col-xs-12 col-sm-4 col-md-3">
                            <p id="title">Description</p>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-8 col-md-9">
                            <p><%=description%></p>
                        </div>
                    </div>
                    <%}%>
                    <hr>
                </h4>
                <%
                    if(total != 0) {
                %>
                <div class="col-xs-12"><br></div>
                <h3>Contents</h3>
                <h4>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="well col-xs-12" id="black-well">
                                <%
                                    count = 1;
                                    int printed = 1;
                                    String spacer = "";
                                    while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
                                        if(deckContents.getDeckId() == id) {
                                            CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                            legalities = card.getLegalities();
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
                                            if((printed % 2) == 0 && printed != entries) {
                                                spacer = " col-sm-12";
                                            }
                                            else {
                                                spacer = " hidden-sm hidden-md hidden-lg";
                                            }
                                %>
                                <div id="container<%=deckContents.getCardId()%>" class="col-xs-12 col-sm-6">
                                    <div class="col-xs-12 hidden-sm hidden-md hidden-lg">
                                        <%=deckContents.getCardTotal()%>&nbsp;x
                                        <a id="menu-item" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
                                            <%=card.getName()%> (<%=legalityText%>)
                                        </a>
                                    </div>
                                    <div class="hidden-xs col-sm-12">
                                        <div class="col-sm-2">
                                             <%=deckContents.getCardTotal()%>&nbsp;x
                                        </div>
                                        <div class="col-sm-10">
                                            <a id="menu-item" onclick="document.getElementById('cardForm<%=deckContents.getCardId()%>').submit();">
                                                <span onmouseover="reveal('image<%=deckContents.getCardId()%>', 'container<%=deckContents.getCardId()%>', 'capsule', 'your_decks')" onmouseout="conceal('image<%=deckContents.getCardId()%>')">
                                                    <%=card.getName()%> (<%=legalityText%>)
                                                </span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-12<%=spacer%>"><br></div>
                                <%
                                            printed++;
                                        }
                                        count++;
                                    }
                                %>
                            </div>
                        </div>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <%
                        count = 1;
                        while((deckContents = deckContentsInfo.getContentsByNum(count)) != null) {
                            if(deckContents.getDeckId() == id) {
                                CardInfo card = cardInfo.getCardById(deckContents.getCardId());
                                String[] imageURLs = card.getImageURLs();
                                String front = imageURLs[0];
                                if(front == null) {
                                    front = "images/magic_card_back.jpg";
                                }
                    %>
                    <form id="cardForm<%=deckContents.getCardId()%>" action="CardServlet" method="POST">
                        <input type="hidden" name="action" value="card">
                        <input type="hidden" name="id" value="<%=deckContents.getCardId()%>">
                        <input type="hidden" name="username" value="<%=username%>">
                    </form>
                    <img class="img-special" id="image<%=deckContents.getCardId()%>" src="<%=front%>" alt="<%=front%>" style="display: none;"/>
                    <%
                                }
                                count++;
                            }
                        } else {
                    %>
                    <div class="col-xs-12"><br></div>
                    <h4><p>There are no cards in this deck.</p></h4>
                    <%}%>
                </h4>
            </div>
            <div class="col-xs-12">
                <h3>Sorting Area<hr></h3>
                <h4>
                    <p>
                        Click the buttons below to sort the cards visually in different ways. If you are the owner, you may update the number of each card, any number 0 and below will remove the card from this deck. Remember to click the "Submit" button beneath the Sorting Area to publish your changes.
                    </p>
                </h4>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="col-xs-12"><br><br></div>
                        <div class="col-xs-12 col-sm-6 col-md-3">
                            <button title="Sort By Number" id="form-submit" onclick="sortCards('<%=id%>', 'deck', 'number', '<%=username%>', '<%=deck.getUser()%>', '<%=cardNum%>', '<%=cardIdList%>', '<%=cardFrontList%>', '<%=cardNameList%>', '<%=cardTypeList%>', '<%=cardSetList%>', '<%=cardTotalList%>', '<%=cardColorList%>', '<%=cardCostList%>', '<%=cardFavoriteList%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">Number</button>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-6 col-md-3">
                            <button title="Sort By Type" id="form-submit" onclick="sortCards('<%=id%>', 'deck', 'type', '<%=username%>', '<%=deck.getUser()%>', '<%=cardNum%>', '<%=cardIdList%>', '<%=cardFrontList%>', '<%=cardNameList%>', '<%=cardTypeList%>', '<%=cardSetList%>', '<%=cardTotalList%>', '<%=cardColorList%>', '<%=cardCostList%>', '<%=cardFavoriteList%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">Type</button>
                        </div>
                        <div class="col-xs-12 hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-6 col-md-3">
                            <button title="Sort By Color" id="form-submit" onclick="sortCards('<%=id%>', 'deck', 'color', '<%=username%>', '<%=deck.getUser()%>', '<%=cardNum%>', '<%=cardIdList%>', '<%=cardFrontList%>', '<%=cardNameList%>', '<%=cardTypeList%>', '<%=cardSetList%>', '<%=cardTotalList%>', '<%=cardColorList%>', '<%=cardCostList%>', '<%=cardFavoriteList%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">Color</button>
                        </div>
                        <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                        <div class="col-xs-12 col-sm-6 col-md-3">
                            <button title="Sort By Cost" id="form-submit" onclick="sortCards('<%=id%>', 'deck', 'cost', '<%=username%>', '<%=deck.getUser()%>', '<%=cardNum%>', '<%=cardIdList%>', '<%=cardFrontList%>', '<%=cardNameList%>', '<%=cardTypeList%>', '<%=cardSetList%>', '<%=cardTotalList%>', '<%=cardColorList%>', '<%=cardCostList%>', '<%=cardFavoriteList%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">Cost</button>
                        </div>
                        <div class="col-xs-12"><br></div>
                        <div id="sortArea"></div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12">
                <h3>Comments<hr></h3>
                <%
                    num = 1;
                    int commentCount = 0;
                    String picture;
                    DeckCommentInfo comment;
                    while((comment = (DeckCommentInfo) deckCommentInfo.getCommentByNum(num)) != null) {
                        if(comment.getDeckId() != id) {
                            num++;
                            continue;
                        }
                        java.util.Date dateAdded = comment.getDateAdded();
                        String content = comment.getText();
                        int likes = comment.getLikes();
                        int dislikes = comment.getDislikes();
                        total = likes + dislikes;
                        UserInfo owner = (UserInfo) userInfo.getUser(comment.getOwner());
                        if(owner == null) {
                            num++;
                            continue;
                        }
                        picture = owner.getPicture();
                        int commentId = comment.getId();
                %>
                <div class="row">
                    <div class="col-xs-12">
                        <h4>
                            <div class="col-xs-7 col-sm-3 col-md-2">
                                <img width="100%" src="<%=picture%>" alt="<%=picture%>" id="center-img"></img><br>
                                <%
                                    if(username == null || username.equals("")) {
                                %>
                                <%
                                    } else if(owner.getUsername().equals(username)) {
                                %>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                    </div>
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                    </div>
                                </div>
                                <%} else {%>
                                <div class="row" style="margin: auto;display: table">
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteForm<%=num%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                    </div>
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteForm<%=num%>').submit();">
                                        <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <div class="col-xs-5 col-sm-9 col-md-10">
                                <div class="row">
                                    <p><span id="title">Username: </span><%=owner.getUsername()%></p>
                                    <p><span id="title">Date Added: </span><%=dateAdded%></p>
                                    <%
                                        if(username == null || username.equals("")) {
                                    %>
                                    <%
                                        } else if(owner.getUsername().equals(username)) {
                                    %>
                                    <div class="row" style="margin: auto;display: table">
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                        </div>
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteDeckCommentPopup('<%=id%>', '<%=commentId%>', '<%=username%>');">
                                            <span id="button-symbol" class="glyphicon glyphicon-trash"></span>
                                        </div>
                                    </div>
                                    <%} else {%>
                                    <div class="row" style="margin: auto;display: table">
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Like Comment" onclick="document.getElementById('upvoteForm<%=num%>').submit();">
                                            <span id="button-symbol" class="glyphicon glyphicon-thumbs-up"></span>
                                        </div>
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Dislike Comment" onclick="document.getElementById('downvoteForm<%=num%>').submit();">
                                            <span id="button-symbol" class="glyphicon glyphicon-thumbs-down"></span>
                                        </div>
                                    </div>
                                    <%}%>
                                    <div class="well hidden-xs col-sm-12" id="black-well">
                                        <p>
                                            <%=content%>
                                        </p><hr>
                                        <%=likes%> out of <%=total%> people found this comment helpful
                                        <br>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="well col-xs-12 hidden-sm hidden-md hidden-lg" id="black-well">
                                <p>
                                    <%=content%>
                                </p><hr>
                                <%=likes%> out of <%=total%> people found this comment helpful
                                <br>
                            </div>
                        </h4>
                    </div>
                </div>
                <form id="upvoteForm<%=num%>" action="DeckServlet" method="post">
                    <input type="hidden" name="action" value="upvote">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=likes%>">
                    <input type="hidden" name="dislikes" value="<%=dislikes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="downvoteForm<%=num%>" action="DeckServlet" method="post">
                    <input type="hidden" name="action" value="downvote">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=likes%>">
                    <input type="hidden" name="dislikes" value="<%=dislikes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                        commentCount++;
                        num++;
                    }
                    if(commentCount == 0) {
                        %><h4>There are no comments for this deck. Be the first to write one!</h4><br><br><%
                    }
                %>
            </div>
            <div class="col-xs-12">
                <br>
                <h2>Write A Comment</h2><br>
                <%
                    if(username == null || username.equals("")) {
                %>
                <h4>If you want to write a comment, first login or sign up for an account.</h4>
                <div class="col-xs-12"><br></div>
                <%} else {%>
                <h4>Use the following space to write your comment. Please use constructive rhetoric and avoid the use of profanity. We reserve the right to take down comments we find to be inappropriate.<br><br>
                <hr>
                <form id="writeCommentForm" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="comment">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="username" value="<%=username%>">
                    <textarea id="input-field" name="comment" form="writeCommentForm" required></textarea><br><br><br>
                    <div class="row">
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="hidden-xs col-sm-4"></div>
                        <div class="col-xs-12 col-sm-4">
                            <button id="form-submit" title="Submit Comment" style="width: 100%;" type="submit">Submit</button><br><br><br>
                        </div>
                    </div>
                </form>
                <%}%>
            </div>
        </div>
    </div>
</div>
<form id="popupForm" action="PopupServlet" method="POST"></form>
<script src="js/scripts.js"></script>
<script>
Chart.defaults.global.defaultFontColor = "#fff";
var colorCtx = document.getElementById("color-distribution").getContext('2d');
var colorChart = new Chart(colorCtx, {
    type: 'pie',
    data: {
        labels: [<%=colorLabels%>],
        datasets: [{
            data: [<%=colorData%>],
            backgroundColor: [<%=colorBackgroundColor%>],
            borderColor: [<%=colorBackgroundBorder%>],
            borderWidth: 1
        }]
    },
    options: {
        legend: {
           display: false
        },
        title: {
            display: true,
            text: 'Mana Color Distrubution'
        }
    }
});
var costCtx = document.getElementById("cost-distribution").getContext('2d');
var costChart = new Chart(costCtx, {
    type: 'bar',
    data: {
        labels: [<%=costLabels%>],
        datasets: [{
            data: [<%=costData%>],
            backgroundColor: [<%=costBackgroundColor%>],
            borderColor: [<%=costBackgroundBorder%>],
            borderWidth: 1
        }]
    },
    options: {
        legend: {
            display: false
        },
        title: {
            display: true,
            text: 'Converted Mana Cost Distrubution'
        }
    }
});
</script>
<%
    } else {
%>
<!-- Error -->
<div class="row" id="content-well">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Deck Information</h2><br>
            <h4>
                <p>The deck you selected has no information to display.</p>
                <br>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>