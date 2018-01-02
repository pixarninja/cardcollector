<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
<script src="js/scripts.js"></script>
<!-- Add code here -->
<div class="well row">
    <div class="col-xs-12 col-md-5">
        <h2>Search Cards</h2><br>
        <form id="searchForm" action="Servlet" method="POST">
            <input type="hidden" name="action" value="games">
            <input type="hidden" name="username" value="<%=username%>">
            <div class="row">
                <div class="col-xs-3"></div>
                <div class="col-xs-3">
                    <input type="checkbox" class="big-checkbox">Name<br>
                </div>
                <div class="col-xs-3">
                    <input type="checkbox">Type<br>
                </div>
                <div class="col-xs-3">
                    <input type="checkbox">Text<br>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Text:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Mana Color:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <div class="row">
                        <div class="col-xs-1"></div>
                        <div class="col-xs-2" title="White Mana" id="white-mana" onclick=selectMana(0);></div>
                        <div class="col-xs-2" title="Blue Mana" id="blue-mana" onclick=selectMana(1);></div>
                        <div class="col-xs-2" title="Black Mana" id="black-mana" onclick=selectMana(2);></div>
                        <div class="col-xs-2" title="Red Mana" id="red-mana" onclick=selectMana(3);></div>
                        <div class="col-xs-2" title="Green Mana" id="green-mana" onclick=selectMana(4);></div>
                    </div>
                </div>
                <div class="col-xs-12"><br></div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Mana Cost:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="mana" type="number" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Card Type:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Edition:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Rarity:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Power:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Toughness:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Text:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4">
                    <span class="pull-right">Card Artist:&nbsp;&nbsp;</span>
                </div>
                <div class="col-xs-8">
                    <input id="input-field" name="name" type="text" /><br><br>
                </div>
            </div>
            <br><br><br>
            <input id="form-submit" type="submit" value="Search Cards"></input>
        </form>
        <br><br><br>
    </div>
    <div class="hidden-xs hidden-sm col-md-2" style="border-right: 1px solid white;position: relative;right: 85px;height: 118%;"></div>
    <div class="col-xs-12 col-md-5">
        <h2>Search Users</h2><br>
        <form id="searchForm" action="SearchServlet" method="POST">
            <input type="hidden" name="action" value="users">
            <input type="hidden" name="username" value="<%=username%>">
            <h3>Username</h3>
            <input style="min-width: 100%;" type="text" name="user"></input>
            <h3>Name</h3>
            <input style="min-width: 100%;" type="text" name="name"></input>
            <h3>Age</h3>
            <input style="min-width: 100%;" type="text" name="user"></input>
            <br><br><br>
            <input id="form-submit" type="submit" value="Search Users"></input>
        </form>
    </div>
</div>
<%@include file="footer.jsp"%>