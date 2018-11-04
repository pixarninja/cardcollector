                        <p id="footer"><a id="menu-item" class="footer-link" onclick="document.getElementById('indexForm').submit();">Card<span class="glyphicon glyphicon-globe" id="mini-icon"></span>Collector</a>
                            &nbsp;&nbsp;|&nbsp;
                            <a id="menu-item" title="Your Collections" class="footer-link" onclick="document.getElementById('yourCollectionsForm').submit();">
                                <span class="glyphicon glyphicon-book"></span>&nbsp;&nbsp;Collections
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <a id="menu-item" title="Your Decks" class="footer-link" onclick="document.getElementById('yourDecksForm').submit();">
                                <span class="glyphicon glyphicon-inbox"></span>&nbsp;&nbsp;Decks
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <a id="menu-item" title="Your Profile" class="footer-link" onclick="document.getElementById('profileForm').submit();">
                                <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;Profile
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <!--
                            <a id="menu-item" title="Playmat" class="footer-link" onclick="document.getElementById('playmatForm').submit();">
                                <span class="glyphicon glyphicon-knight"></span>&nbsp;&nbsp;Playmat
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            -->
                            <a id="menu-item" title="Help" class="footer-link" onclick="document.getElementById('helpForm').submit();">
                                <span class="glyphicon glyphicon-question-sign"></span>&nbsp;&nbsp;Help
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <%if(username != null && !username.equals("")) {%>
                            <a id="menu-item" title="Notifications (<%=notifications%>)" class="footer-link" onclick="document.getElementById('notificationsForm').submit();">
                                <span class="glyphicon glyphicon-gift"></span>&nbsp;&nbsp;(<%=notifications%>)
                            </a>
                            <%}%>
                            &nbsp;&nbsp;|&nbsp;
                            <a id="menu-item" title="Advanced Search" class="footer-link" onclick="document.getElementById('searchForm').submit();">
                                <span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Search
                            </a>
                            &nbsp;&nbsp;|&nbsp;
                            <%if(username == null || username.equals("")) {%>
                            <a id="menu-item" title="Login" class="footer-link" onclick="document.getElementById('loginForm').submit();">
                                <span class="glyphicon glyphicon-log-in"></span>&nbsp;&nbsp;Login
                            </a>
                            <%} else {%>
                            <a id="menu-item" title="Logout" class="footer-link" onclick="document.getElementById('logoutForm').submit();">
                                <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;Logout
                            </a>
                            <%}%>
                            <!--<span style="float: right;">© 2018</span>-->
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>