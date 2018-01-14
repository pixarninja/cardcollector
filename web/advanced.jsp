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
<%@include file="header.jsp"%>
<script src="js/scripts.js"></script>
<!-- Add code here -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Advanced Search</h2><br>
            <h4>
                Fill in the fields below in order to search our database for cards, decks, or users. In order to search for multiple keywords of a single category, separate each query parameter with a '|' (vertical pipe) character.
                <br><br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12 col-md-5">
            <h3>Cards<hr></h3>
            <form id="searchCardsForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="cards">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order By</p>
                    </div>
                    <div class="col-xs-8">
                        <select name="order_by" id="input-field">
                            <option value="name">Name</option>
                            <option value="type">Type</option>
                            <option value="text">Text</option>
                            <option value="colors">Mana Color</option>
                            <option value="mc">Mana Cost</option>
                            <option value="set_name">Edition</option>
                            <option value="rarity">Rarity</option>
                            <option value="power">Power</option>
                            <option value="toughness">Toughness</option>
                            <option value="loyalty">Loyalty</option>
                            <option value="artist">Artist</option>
                            <option value="year">Year</option>
                        </select>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Inclusion</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="inc" checked> Inclusive ("OR")&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="exc" > Exclusive ("AND")
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Rarity</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="common" type="checkbox" value="rarity">&nbsp;Common
                    </div>
                    <div class="col-xs-4">
                        <input name="uncommon" type="checkbox" value="rarity">&nbsp;Uncommon
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4"></div>
                    <div class="col-xs-4">
                        <input name="rare" type="checkbox" value="rarity">&nbsp;Rare
                    </div>
                    <div class="col-xs-4">
                        <input name="mythic" type="checkbox" value="rarity">&nbsp;Mythic
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Search</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="inc_name" type="checkbox" value="name">&nbsp;Name
                    </div>
                    <div class="col-xs-4">
                        <input name="inc_type" type="checkbox" value="type">&nbsp;Type
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4"></div>
                    <div class="col-xs-4">
                        <input name="inc_text" type="checkbox" value="text">&nbsp;Text
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Search Text</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="query" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Mana Color</p>
                    </div>
                    <div class="col-xs-8">
                        <div class="row">
                            <div class="col-xs-1"></div>
                            <div class="col-xs-2" title="White Mana" id="white-mana-1" onclick="selectMana('white-mana-1', 0);"></div>
                            <div class="col-xs-2" title="Blue Mana" id="blue-mana-1" onclick="selectMana('blue-mana-1', 1);"></div>
                            <div class="col-xs-2" title="Black Mana" id="black-mana-1" onclick="selectMana('black-mana-1', 2);"></div>
                            <div class="col-xs-2" title="Red Mana" id="red-mana-1" onclick="selectMana('red-mana-1', 3);"></div>
                            <div class="col-xs-2" title="Green Mana" id="green-mana-1" onclick="selectMana('green-mana-1', 4);"></div>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Minimum Converted Mana Cost</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" name="min_cmc" type="text">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Maximum Converted Mana Cost</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" name="max_cmc" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Card Type</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="type" type="text"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Edition</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="set_name" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Minimum Power</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" name="min_power" type="number"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Maximum Power</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" name="max_power" type="number"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Minimum Toughness</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" name="min_toughness" type="number"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Maximum Toughness</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" name="max_toughness" type="number">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Card Artist</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="artist" type="text"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Year</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="year" type="text"><br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <input id="form-submit" type="submit" value="Search Cards"><br><br><br>
                    </div>
                </div>
            </form>
        </div>
        <div class="hidden-xs hidden-sm col-md-1" style="border-right: 1px solid white;position: relative;right: 20px;height: 193%;"></div>
        <div class="col-xs-12 col-md-5">
            <h3>Decks<hr></h3>
            <form id="searchDecksForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="decks">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Deck Title</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="username" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Containing</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="name" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Mana Color</p>
                    </div>
                    <div class="col-xs-8">
                        <div class="row">
                            <div class="col-xs-1"></div>
                            <div class="col-xs-2" title="White Mana" id="white-mana-2" onclick="selectMana('white-mana-2', 0);"></div>
                            <div class="col-xs-2" title="Blue Mana" id="blue-mana-2" onclick="selectMana('blue-mana-2', 1);"></div>
                            <div class="col-xs-2" title="Black Mana" id="black-mana-2" onclick="selectMana('black-mana-2', 2);"></div>
                            <div class="col-xs-2" title="Red Mana" id="red-mana-2" onclick="selectMana('red-mana-2', 3);"></div>
                            <div class="col-xs-2" title="Green Mana" id="green-mana-2" onclick="selectMana('green-mana-2', 4);"></div>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Creator (Username)</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="age" type="text"><br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <input id="form-submit" type="submit" value="Search Decks">
                    </div>
                </div>
            </form><br>
            <h3>Collections<hr></h3>
            <form id="searchCollectionsForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="collections">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Collection Title</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="username" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Containing</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="name" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Mana Color</p>
                    </div>
                    <div class="col-xs-8">
                        <div class="row">
                            <div class="col-xs-1"></div>
                            <div class="col-xs-2" title="White Mana" id="white-mana-3" onclick="selectMana('white-mana-3', 0);"></div>
                            <div class="col-xs-2" title="Blue Mana" id="blue-mana-3" onclick="selectMana('blue-mana-3', 1);"></div>
                            <div class="col-xs-2" title="Black Mana" id="black-mana-3" onclick="selectMana('black-mana-3', 2);"></div>
                            <div class="col-xs-2" title="Red Mana" id="red-mana-3" onclick="selectMana('red-mana-3', 3);"></div>
                            <div class="col-xs-2" title="Green Mana" id="green-mana-3" onclick="selectMana('green-mana-3', 4);"></div>
                        </div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Creator (Username)</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="age" type="text"><br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <input id="form-submit" type="submit" value="Search Collections">
                    </div>
                </div>
            </form><br>
            <h3>Users<hr></h3>
            <form id="searchUsersForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="users">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Username</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="username" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <input id="form-submit" type="submit" value="Search Users"><br><br>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<%@include file="footer.jsp"%>