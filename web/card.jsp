<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userInfo" class="beans.UserInfo" scope="request"/>
<jsp:useBean id="cardInfo" class="beans.CardInfo" scope="request"/>
<jsp:useBean id="cardCommentInfo" class="beans.CardCommentInfo" scope="request"/>
<jsp:useBean id="deckInfo" class="beans.DeckInfo" scope="request"/>
<jsp:useBean id="collectionInfo" class="beans.CollectionInfo" scope="request"/>
<jsp:useBean id="favoriteInfo" class="beans.CardFavoriteInfo" scope="request"/>
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
    String id = request.getParameter("id");
    ArrayList<String> icons = new ArrayList();
    CardInfo card = (CardInfo) cardInfo.getCardById(id);
    if(card != null) {
        String game = card.getGame();
        String name = card.getName();
        String edition = card.getSetName();
        String rarity = card.getRarity();
        char lowercase = rarity.charAt(0);
        String captital = ("" + lowercase).toUpperCase();
        rarity = captital + rarity.substring(1);
        String front = card.getFront();
        String[] parsedCost = card.getManaCost().split("}");
        int i;
        for(i = 0; i < parsedCost.length; i++) {
            String symbol = parsedCost[i] + "}";
            symbol = symbol.replaceAll(Pattern.quote("/"),"-");
            icons.add("images/" + symbol + ".png");
        }
        String type = card.getType();
        String[] parsedColors = card.getColors().split(", ");
        String colors;
        if(card.getColors() != null && card.getColors() != "") {
            colors = "";
            for(i = 0; i < parsedColors.length; i++) {
                String symbol = parsedColors[i];
                if(symbol.contains("W")) {
                    if(colors.equals("")) {
                        colors = "White";
                    }
                    else {
                        colors = colors + ", White";
                    }
                } else if (symbol.contains("U")) {
                    if(colors.equals("")) {
                        colors = "Blue";
                    }
                    else {
                        colors = colors + ", Blue";
                    }
                } else if (symbol.contains("B")) {
                    if(colors.equals("")) {
                        colors = "Black";
                    }
                    else {
                        colors = colors + ", Black";
                    }
                } else if (symbol.contains("R")) {
                    if(colors.equals("")) {
                        colors = "Red";
                    }
                    else {
                        colors = colors + ", Red";
                    }
                } else if (symbol.contains("G")) {
                    if(colors.equals("")) {
                        colors = "Green";
                    }
                    else {
                        colors = colors + ", Green";
                    }
                }
            }
            if(colors.equals("") || (card.getText() != null && card.getText().contains("Devoid"))) {
                colors = "Devoid";
            }
        }
        else {
            colors = "Devoid";
        }
        String artist = card.getArtist();
        String year;
        if(card.getYear().equals("future")) {
            year = "Future";
        }
        else {
            year = card.getYear();
        }
        /* Optional Parameters */
        String text = null;
        String flavor = null;
        String power = null;
        String toughness = null;
        String loyalty = null;
        if(card.getYear().equals("future")) {
            year = "Future";
        }
        else {
            year = card.getYear();
        }
        if(card.getText() != null && card.getText() != "") {
            text = card.getText();
        }
        if(card.getFlavor() != null && card.getFlavor() != "") {
            flavor = card.getFlavor();
        }
        if(card.getPower() != null && card.getPower() != "") {
            power = card.getPower();
        }
        if(card.getToughness() != null && card.getToughness() != "") {
            toughness = card.getToughness();
        }
        if(card.getLoyalty() != null && card.getLoyalty() != "") {
            loyalty = card.getLoyalty();
        }
        int multiverse = card.getMultiverse();
        String legalities = card.getLegalities();
        String kingdom = card.getKingdom();
        String back = card.getBack();
        String revName = null;
        String revType = null;
        String revText = null;
        String revFlavor = null;
        String revPower = null;
        String revToughness = null;
        String revLoyalty = null;
        ArrayList<String> revIcons = new ArrayList();
        String revColors = null;
        if(back != null) {
            String[] revParsedCost = card.getRevManaCost().split("}");
            for(i = 0; i < revParsedCost.length; i++) {
                String symbol = revParsedCost[i] + "}";
                symbol = symbol.replaceAll(Pattern.quote("/"),"-");
                revIcons.add("images/" + symbol + ".png");
            }
            String[] revParsedColors = card.getColors().split(", ");
            if(card.getRevColors() != null && card.getRevColors() != "") {
                revColors = "";
                for(i = 0; i < revParsedColors.length; i++) {
                    String symbol = revParsedColors[i];
                    if(symbol.contains("W")) {
                        if(revColors.equals("")) {
                            revColors = "White";
                        }
                        else {
                            revColors = revColors + ", White";
                        }
                    } else if (symbol.contains("U")) {
                        if(revColors.equals("")) {
                            revColors = "Blue";
                        }
                        else {
                            revColors = revColors + ", Blue";
                        }
                    } else if (symbol.contains("B")) {
                        if(revColors.equals("")) {
                            revColors = "Black";
                        }
                        else {
                            revColors = revColors + ", Black";
                        }
                    } else if (symbol.contains("R")) {
                        if(revColors.equals("")) {
                            revColors = "Red";
                        }
                        else {
                            revColors = revColors + ", Red";
                        }
                    } else if (symbol.contains("G")) {
                        if(revColors.equals("")) {
                            revColors = "Green";
                        }
                        else {
                            revColors = revColors + ", Green";
                        }
                    }
                }
                if(revColors.equals("") || (card.getRevText() != null && card.getRevText().contains("Devoid"))) {
                    revColors = "Devoid";
                }
            }
            else {
                revColors = "Devoid";
            }
            if(card.getRevName() != null && card.getRevName() != "") {
                revName = card.getRevName();
            }
            if(card.getRevType() != null && card.getRevType() != "") {
                revType = card.getRevType();
            }
            if(card.getRevText() != null && card.getRevText() != "") {
                revText = card.getRevText();
            }
            if(card.getRevFlavor() != null && card.getRevFlavor() != "") {
                revFlavor = card.getRevFlavor();
            }
            if(card.getRevPower() != null && card.getRevPower() != "") {
                revPower = card.getRevPower();
            }
            if(card.getRevToughness() != null && card.getRevToughness() != "") {
                revToughness = card.getRevToughness();
            }
            if(card.getRevLoyalty() != null && card.getRevLoyalty() != "") {
                revLoyalty = card.getRevLoyalty();
            }
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
        CardFavoriteInfo favorite;
        boolean favorited = false;
        int num = 1;
        while((favorite = favoriteInfo.getFavoriteByNum(num)) != null) {
            if(favorite.getUser().equals(username) && favorite.getCardId().equals(id)) {
                favorited = true;
                break;
            }
            num++;
        }
%>
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <%
                String collectionId = (String) request.getAttribute("collection_id");
                String collectionTotal = (String) request.getAttribute("collection_total");
                String deckId = (String) request.getAttribute("deck_id");
                String deckTotal = (String) request.getAttribute("deck_total");
                String end = "";
                if(collectionId != null && collectionTotal != null && deckId != null && deckTotal != null) {
                    end = ", and ";
                }
                if((collectionId != null && collectionTotal != null) || (deckId != null && deckTotal != null)) {
            %>
            <h4>
                <div class="well" id="black-well">
                    <p align="center" style="position: relative;top: 5px;">
                        <%
                            if(deckId != null && deckTotal != null) {
                                DeckInfo sender = deckInfo.getDeckById(Integer.parseInt(deckId));
                        %>
                        <span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;<%=Integer.parseInt(deckTotal)%> of this card were added to your deck, <a style="cursor: pointer;" onclick="document.getElementById('deckForm').submit();"><%=sender.getName()%></a>
                        <%
                            if(end.equals("")) {
                        %>
                        &nbsp;&nbsp;<span class="glyphicon glyphicon-alert"></span>
                        <%
                                }
                            }
                            if(collectionId != null && collectionTotal != null) {
                                CollectionInfo sender = collectionInfo.getCollectionById(Integer.parseInt(collectionId));
                                if(end.equals("")) {
                        %>
                            <span class="glyphicon glyphicon-alert"></span>&nbsp;&nbsp;
                            <%}%>
                            <%=end%><%=Integer.parseInt(collectionTotal)%> of this card were added to your collection, <a style="cursor: pointer;" onclick="document.getElementById('collectionForm').submit();"><%=sender.getName()%></a>&nbsp;&nbsp;<span class="glyphicon glyphicon-alert"></span>
                        <%
                            }
                        %>
                    </p>
                </div>
            </h4>
            <%}%>
            <h2>Card Information</h2><br>
            <h4>
                <p>Below is the selected card's information. You may add this card to your collections or decks, and you may add or remove this card from your favorites list by using the buttons beneath the card image. You may write a comment by submitting one at the bottom of the page.</p>
                <%
                    if(collectionId != null && collectionTotal != null) {
                        CollectionInfo sender = collectionInfo.getCollectionById(Integer.parseInt(collectionId));
                %>
                <form id="collectionForm" action="CollectionServlet" method="POST">
                    <input type="hidden" name="action" value="collection">
                    <input type="hidden" name="id" value="<%=sender.getId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    } if(deckId != null && deckTotal != null) {
                        DeckInfo sender = deckInfo.getDeckById(Integer.parseInt(deckId));
                %>
                <form id="deckForm" action="DeckServlet" method="POST">
                    <input type="hidden" name="action" value="deck">
                    <input type="hidden" name="id" value="<%=sender.getId()%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <%
                    } if(collectionId == null && collectionTotal == null && deckId == null && deckTotal == null) {
                %>
                <br>
                <%}%>
                <br><hr>
            </h4>
        </div>
        <div class="col-xs-12">
            <div class="col-xs-12 col-sm-4">
                <h4>
                    <img class="img-special" width="100%" src="<%=front%>" alt="<%=front%>">
                    <%
                        if(back != null && !back.equals("")) {
                    %>
                    <br><br><img class="img-special" width="100%" src="<%=back%>" alt="<%=back%>">
                    <%}%>
                    <div class="col-xs-12"><br><br></div>
                    <div class="row" style="margin: auto;display: table">
                        <%
                            if(username != null && !username.equals("")) {
                        %>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Print Card" onclick="document.getElementById('printForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-print"></span>
                        </div>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-middle" title="Add Card To Collection/Deck" onclick="addCardPopup('<%=card.getId()%>', '<%=card.getFront()%>', '<%=username%>', '<%=collectionNum%>', '<%=collectionIdList%>', '<%=collectionNameList%>', '<%=deckNum%>', '<%=deckIdList%>', '<%=deckNameList%>');">
                            <span id="button-symbol" class="glyphicon glyphicon-plus"></span>
                        </div>
                        <%
                            if(favorited) {
                        %>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Remove Card From Favorites List" onclick="document.getElementById('favoriteForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-star"></span>
                        </div>
                        <%} else {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-right" title="Add Card To Favorites List" onclick="document.getElementById('favoriteForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-star-empty"></span>
                        </div>
                        <%}%>
                        <form id="favoriteForm" action="CardServlet" method="POST">
                            <input type="hidden" name="action" value="favorite">
                            <input type="hidden" name="id" value="<%=id%>">
                            <input type="hidden" name="username" value="<%=username%>">
                        </form>
                        <form id="printForm" action="PrintServlet" method="POST" target="_blank">
                            <input type="hidden" name="action" value="card">
                            <input type="hidden" name="id" value="<%=id%>">
                        </form>
                        <%} else {%>
                        <div class="col-xs-2" style="margin: auto;display: table" id="button-back-left" title="Print Card" onclick="document.getElementById('printForm').submit();">
                            <span id="button-symbol" class="glyphicon glyphicon-print"></span>
                        </div>
                        <form id="printForm" action="PrintServlet" method="POST" target="_blank">
                            <input type="hidden" name="action" value="card">
                            <input type="hidden" name="id" value="<%=id%>">
                        </form>
                        <%}%>
                    </div>
                    <div class="col-xs-12"><br></div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-sm-12 col-lg-4">
                        <p id="title">Links</p>
                    </div>
                    <div class="col-xs-12 hidden-lg"><br></div>
                    <%if(multiverse == -1 && kingdom == null) {%>
                    <div class="col-sm-12 col-lg-8"><p>None</p></div>
                    <%} else {
                        if(multiverse > -1) {%>
                    <div class="col-sm-12 col-lg-8"><p><a href="http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=<%=multiverse%>" target="_blank"><span class="glyphicon glyphicon-info-sign"></span> MTG Gatherer</a></p></div>
                    <%if(kingdom != null) {%>
                    <div class="col-xs-12"><br></div>
                    <%}%>
                    <div class="hidden-sm col-lg-4"></div>
                    <%} if(kingdom != null) {%>
                    <div class="col-sm-12 col-lg-8"><p><a href="<%=kingdom%>" target="_blank"><span class="glyphicon glyphicon-shopping-cart"></span> Card Kingdom</a></p></div>
                    <div class="hidden-sm col-lg-4"></div>
                    <%}}%>
                    <div class="col-xs-12"><br></div>
                    <div class="col-sx-12"><hr id="in-line-hr"></div>
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
                </h4>
            </div>
            <div class="col-xs-12 col-sm-8">
                <h2><%=name%> | <%=edition%><hr></h2>
                <h4>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Game</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=game%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Edition</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=edition%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Rarity</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=rarity%></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Artist</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=artist%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Year</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=year%></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        if(back != null && !back.equals("")) {
                    %>
                    <div class="col-xs-12"><br><br></div>
                    </h4><h3>Side 1</h3><h4>
                    <%}%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Colors</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=colors%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Mana Cost</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p>
                                        <%
                                            found = false;
                                            String[] params = {"{0}", "{1}", "{2}", "{3}", "{4}", "{5}", "{6}", "{7}", "{8}", "{9}", "{1000000}", "{100}", "{10}", "{11}", "{12}", "{13}", "{14}", "{15}", "{16}", "{17}", "{18}", "{19}", "{20}", "{2/W}", "{2/U}", "{2/B}", "{2/R}", "{2/G}", "{W/U}", "{W/B}", "{W/P}", "{U/B}", "{U/R}", "{U/P}", "{B/G}", "{B/R}", "{B/P}", "{R/G}", "{R/W}", "{R/P}", "{G/U}", "{G/W}", "{G/P}", "{W}", "{U}", "{B}", "{R}", "{G}", "{C}", "{E}", "{HR}", "{HW}", "{PW}", "{P}", "{Q}", "{T}", "{S}", "{X}", "{Y}", "{Z}", "{CHAOS}", "{½}", "{∞}"};
                                            for(String p : params) {
                                                p = p.replace("/", "-");
                                                p = "images/" + p + ".png";
                                                for(String c : icons) {
                                                    if(c.equals(p)) {
                                                        found = true;
                                                        break;
                                                    }
                                                }
                                                if(found) {
                                                    break;
                                                }
                                            }
                                            if(!found) {
                                                %>None<%
                                            }
                                            else {
                                                for(String s : icons) {
                                        %>
                                        <img class="img-noborder" style="height: 16px;position: relative;top: -1px;" src="<%=s%>" alt="<%=s%>">
                                        <%
                                                }
                                            }
                                        %>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%if(power != null || toughness != null || loyalty != null) {%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <%if(power != null) {%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Power</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=power%></p>
                                </div>
                            </div>
                        </div>
                        <%
                            } if(toughness != null) {
                                if(power != null) {
                        %>
                        <div class="col-xs-12"><br></div>
                        <%}%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Toughness</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=toughness%></p>
                                </div>
                            </div>
                        </div>
                        <%
                            } if(loyalty != null) {
                                if(toughness != null) {
                        %>
                        <div class="col-xs-12"><br></div>
                        <%}%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Loyalty</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=loyalty%></p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <%}%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Type</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=type%></p>
                                </div>
                            </div>
                        </div>
                        <% if(text != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p>
                                        <%
                                            for(String p : params) {
                                                text = text.replace(p, "<img src='images/" + p.replace("/", "-") + ".png' alt='images/" + p.replace("/", "-") + ".png' style='border: none !important;height: 16px;position: relative;top: -1px;'> ");
                                            }
                                        %>
                                        <%=text%>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <%} if(flavor != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-3">
                                <div class="row">
                                    <p id="title">Flavor Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-9">
                                <div class="row">
                                    <p><em><%=flavor%></em></p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <%
                        if(back != null && !back.equals("")) {
                    %>
                    <div class="col-xs-12"><br><br></div>
                    </h4><h3>Side 2</h3><h4>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Name</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=revName%></p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Colors</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=revColors%></p>
                                </div>
                            </div>
                            <div class="col-xs-12"><br></div>
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Mana Cost</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p>
                                        <%
                                            found = false;
                                            for(String p : params) {
                                                p = p.replace("/", "-");
                                                p = "images/" + p + ".png";
                                                for(String c : revIcons) {
                                                    if(c.equals(p)) {
                                                        found = true;
                                                        break;
                                                    }
                                                }
                                                if(found) {
                                                    break;
                                                }
                                            }
                                            if(!found) {
                                                %>None<%
                                            }
                                            else {
                                                for(String s : revIcons) {
                                        %>
                                        <img class="img-noborder" style="height: 16px;position: relative;top: -1px;" src="<%=s%>" alt="<%=s%>">
                                        <%
                                                }
                                            }
                                        %>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%if(revPower != null || revToughness != null || revLoyalty != null) {%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <%if(revPower != null) {%>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Power</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=revPower%></p>
                                </div>
                            </div>
                        </div>
                        <%} if(revToughness != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Toughness</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=revToughness%></p>
                                </div>
                            </div>
                        </div>
                        <%} if(revLoyalty != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Loyalty</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=revLoyalty%></p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                    </div>
                    <%}%>
                    <div class="col-xs-12"><hr id="in-line-hr-big"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12 col-sm-4 col-lg-3">
                                <div class="row">
                                    <p id="title">Type</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-sm-8 col-lg-9">
                                <div class="row">
                                    <p><%=revType%></p>
                                </div>
                            </div>
                        </div>
                        <% if(revText != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-3">
                                <div class="row">
                                    <p id="title">Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-9">
                                <div class="row">
                                    <p>
                                        <%
                                            for(String p : params) {
                                                revText = revText.replace(p, "<img src='images/" + p.replace("/", "-") + ".png' alt='images/" + p.replace("/", "-") + ".png' style='border: none !important;height: 16px;position: relative;top: -1px;'> ");
                                            }
                                        %>
                                        <%=revText%>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <%} if(revFlavor != null) {%>
                        <div class="col-xs-12"><br></div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-3">
                                <div class="row">
                                    <p id="title">Flavor Text</p>
                                </div>
                            </div>
                            <div class="col-xs-12 hidden-sm hidden-md hidden-lg"><br></div>
                            <div class="col-xs-12 col-lg-9">
                                <div class="row">
                                    <p><em><%=revFlavor%></em></p>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        <div class="col-xs-12"><br></div>
                    </div>
                    <%}%>
                </h4>
            </div>
            <div class="col-xs-12">
                <h3>Comments<hr></h3>
                <%
                    num = 1;
                    int commentCount = 0;
                    String picture;
                    CardCommentInfo comment;
                    while((comment = (CardCommentInfo) cardCommentInfo.getCommentByNum(num)) != null) {
                        if(!comment.getCardId().equals(card.getId())) {
                            num++;
                            continue;
                        }
                        java.util.Date dateAdded = comment.getDateAdded();
                        String content = comment.getText();
                        int likes = comment.getLikes();
                        int dislikes = comment.getDislikes();
                        int total = likes + dislikes;
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
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                        <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                    </div>
                                    <div class="hidden-xs col-sm-2" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>');">
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
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-left" title="Edit Comment" onclick="editCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>', '<%=content%>');">
                                            <span id="button-symbol" class="glyphicon glyphicon-pencil"></span>
                                        </div>
                                        <div class="col-xs-2 hidden-sm hidden-md hidden-lg" style="margin: auto;display: table" id="button-back-right" title="Delete Comment" onclick="deleteCardCommentPopup('<%=card.getId()%>', '<%=commentId%>', '<%=username%>');">
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
                <form id="upvoteForm<%=num%>" action="CardServlet" method="post">
                    <input type="hidden" name="action" value="upvote">
                    <input type="hidden" name="id" value="<%=id%>">
                    <input type="hidden" name="comment_id" value="<%=commentId%>">
                    <input type="hidden" name="likes" value="<%=likes%>">
                    <input type="hidden" name="dislikes" value="<%=dislikes%>">
                    <input type="hidden" name="username" value="<%=username%>">
                </form>
                <form id="downvoteForm<%=num%>" action="CardServlet" method="post">
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
                        %><h4>There are no comments for this card. Be the first to write one!</h4><br><br><%
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
                <form id="writeCommentForm" action="CardServlet" method="POST">
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
<%
    } else {
%>
<!-- Error -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Card Information</h2><br>
            <h4>
                <p>The card you selected has no information to display.</p>
                <br><br><hr>
            </h4>
        </div>
    </div>
</div>
<%}%>
<%@include file="footer.jsp"%>