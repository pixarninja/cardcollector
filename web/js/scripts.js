var mana = [false, false, false, false, false, false];

function refresh() {
    selectMana("", -1);
}

function reveal(imageId, containerId, capsuleId, target) {
    var image = document.getElementById(imageId);
    var container = document.getElementById(containerId);
    var capsule = document.getElementById(capsuleId);
    
    var rect = container.getBoundingClientRect();
    var cap = capsule.getBoundingClientRect();
    var width = container.clientWidth;
    if(width > 250) {
        width = 250;
    }
    var height = width * 1.4;
    
    var xpos = rect.left - cap.left - (4 * width / 5);
    var ypos = rect.top - cap.top - height / 2;
    
    if(target === "edit_deck") {
        xpos = rect.left - cap.left - (11 * width / 10);
    } else if(target === "edit_collection") {
        xpos = rect.left - cap.left - (11 * width / 10);
    }
    
    image.style.position = "absolute";
    image.style.left = (xpos) + "px";
    image.style.top = (ypos) + "px";
    image.style.display = "block";
    image.style.width = (width) + "px";
}

function conceal(imageId) {
    var image = document.getElementById(imageId);
    image.style.display = "none";
}

function selectMana(id, num) {
    if(id !== "") {
        if(mana[0]) {
            document.getElementById(id).style.background = "url(images/white_on.png)";
            document.getElementById(id).innerHTML = "<input name='white' type='hidden' value='on'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/white_off.png)";
        }
        if(mana[1]) {
            document.getElementById(id).style.background = "url(images/blue_on.png)";
            document.getElementById(id).innerHTML = "<input name='blue' type='hidden' value='on'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/blue_off.png)";
        }
        if(mana[2]) {
            document.getElementById(id).style.background = "url(images/black_on.png)";
            document.getElementById(id).innerHTML = "<input name='black' type='hidden' value='on'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/black_off.png)";
        }
        if(mana[3]) {
            document.getElementById(id).style.background = "url(images/red_on.png)";
            document.getElementById(id).innerHTML = "<input name='red' type='hidden' value='on'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/red_off.png)";
        }
        if(mana[4]) {
            document.getElementById(id).style.background = "url(images/green_on.png)";
            document.getElementById(id).innerHTML = "<input name='green' type='hidden' value='on'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/green_off.png)";
        }
        if(mana[5]) {
            document.getElementById(id).style.background = "url(images/colorless_on.png)";
            document.getElementById(id).innerHTML = "<input name='colorless' type='hidden' value='on'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/colorless_off.png)";
        }
    }
    switch(num) {
    case 0:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/white_off.png)";
            mana[num] = false;
            document.getElementById(id).innerHTML = "<input name='white' type='hidden' value='off'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/white_on.png)";
            mana[num] = true;
            document.getElementById(id).innerHTML = "<input name='white' type='hidden' value='on'>";
        }
        break;
    case 1:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/blue_off.png)";
            mana[num] = false;
            document.getElementById(id).innerHTML = "<input name='blue' type='hidden' value='off'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/blue_on.png)";
            mana[num] = true;
            document.getElementById(id).innerHTML = "<input name='blue' type='hidden' value='on'>";
        }
        break;
    case 2:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/black_off.png)";
            mana[num] = false;
            document.getElementById(id).innerHTML = "<input name='black' type='hidden' value='off'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/black_on.png)";
            mana[num] = true;
            document.getElementById(id).innerHTML = "<input name='black' type='hidden' value='on'>";
        }
        break;
    case 3:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/red_off.png)";
            mana[num] = false;
            document.getElementById(id).innerHTML = "<input name='red' type='hidden' value='off'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/red_on.png)";
            mana[num] = true;
            document.getElementById(id).innerHTML = "<input name='red' type='hidden' value='on'>";
        }
        break;
    case 4:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/green_off.png)";
            mana[num] = false;
            document.getElementById(id).innerHTML = "<input name='green' type='hidden' value='off'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/green_on.png)";
            mana[num] = true;
            document.getElementById(id).innerHTML = "<input name='green' type='hidden' value='on'>";
        }
        break;
    case 5:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/colorless_off.png)";
            mana[num] = false;
            document.getElementById(id).innerHTML = "<input name='colorless' type='hidden' value='off'>";
        }
        else {
            document.getElementById(id).style.background = "url(images/colorless_on.png)";
            mana[num] = true;
            document.getElementById(id).innerHTML = "<input name='colorless' type='hidden' value='on'>";
        }
        break;
    default:
        mana = [false, false, false, false, false, false];
        document.getElementById("white-mana").style.background = "url(images/white_off.png)";
        document.getElementById("white-mana").innerHTML = "<input name='white' type='hidden' value='off'>";
        document.getElementById("blue-mana").style.background = "url(images/blue_off.png)";
        document.getElementById("blue-mana").innerHTML = "<input name='blue' type='hidden' value='off'>";
        document.getElementById("black-mana").style.background = "url(images/black_off.png)";
        document.getElementById("black-mana").innerHTML = "<input name='black' type='hidden' value='off'>";
        document.getElementById("red-mana").style.background = "url(images/red_off.png)";
        document.getElementById("red-mana").innerHTML = "<input name='red' type='hidden' value='off'>";
        document.getElementById("green-mana").style.background = "url(images/green_off.png)";
        document.getElementById("green-mana").innerHTML = "<input name='green' type='hidden' value='off'>";
        document.getElementById("colorless-mana").style.background = "url(images/colorless_off.png)";
        document.getElementById("colorless-mana").innerHTML = "<input name='colorless' type='hidden' value='off'>";
    }
}

function hideForm(formId) {
    document.getElementById(formId).style.display = "none";
}

function revealForm(formId) {
    document.getElementById(formId).style.display = "block";
}

function sortCards(id, type, sortBy, username, owner, cardNum, cardIdList, cardFrontList, cardNameList, cardTypeList, cardSetList, cardTotalList, cardColorList, cardCostList, cardFavoriteList, collectionNum, collectionIdList, collectionNameList, deckNum, deckIdList, deckNameList) {
    var cardIds = cardIdList.split("`");
    var cardFronts = cardFrontList.split("`");
    var cardNames = cardNameList.split("`");
    var cardTypes = cardTypeList.split("`");
    var cardSets = cardSetList.split("`");
    var cardTotals = cardTotalList.split("`");
    var cardColors = cardColorList.split("`");
    var cardCosts = cardCostList.split("`");
    var cardFavorites = cardFavoriteList.split("`");
    var i;
    hideForm("sortArea");
    if(sortBy === "type") {
        var i = 0;
        var j = 0;
        var tmpId;
        var tmpFront;
        var tmpName;
        var tmpType;
        var tmpSet;
        var tmpTotal;
        var tmpFavorite;
        for(i = 0 ; i < cardNum - 2 ; i++) {
            for (j = 0 ; j < cardNum - 1 ; j++) {
                var compare = (cardTypes[j]).localeCompare(cardTypes[j + 1]);
                if (compare > 0) {
                    /* tmp storage */
                    tmpId = cardIds[j];
                    tmpFront = cardFronts[j];
                    tmpName = cardNames[j];
                    tmpType = cardTypes[j];
                    tmpSet = cardSets[j];
                    tmpTotal = cardTotals[j];
                    tmpColor = cardColors[j];
                    tmpCost = cardCosts[j];
                    tmpFavorite = cardFavorites[j];
                    /* store new value */
                    cardIds[j] = cardIds[j + 1];
                    cardFronts[j] = cardFronts[j + 1];
                    cardNames[j] = cardNames[j + 1];
                    cardTypes[j] = cardTypes[j + 1];
                    cardSets[j] = cardSets[j + 1];
                    cardTotals[j] = cardTotals[j + 1];
                    cardColors[j] = cardColors[j + 1];
                    cardCosts[j] = cardCosts[j + 1];
                    cardFavorites[j] = cardFavorites[j + 1];
                    /* restore tmp */
                    cardIds[j + 1] = tmpId;
                    cardFronts[j + 1] = tmpFront;
                    cardNames[j + 1] = tmpName;
                    cardTypes[j + 1] = tmpType;
                    cardSets[j + 1] = tmpSet;
                    cardTotals[j + 1] = tmpTotal;
                    cardColors[j + 1] = tmpColor;
                    cardCosts[j + 1] = tmpCost;
                    cardFavorites[j + 1] = tmpFavorite;
                }
            }
        }
    }
    else if(sortBy === "color") {
        var i = 0;
        var j = 0;
        var tmpId;
        var tmpFront;
        var tmpType;
        var tmpSet;
        var tmpTotal;
        var tmpColor;
        var tmpCost;
        var tmpFavorite;
        for(i = 0 ; i < cardNum - 2 ; i++) {
            for (j = 0 ; j < cardNum - 1 ; j++) {
                var compare = (cardColors[j]).localeCompare(cardColors[j + 1]);
                if (compare > 0) {
                    /* tmp storage */
                    tmpId = cardIds[j];
                    tmpFront = cardFronts[j];
                    tmpName = cardNames[j];
                    tmpType = cardTypes[j];
                    tmpSet = cardSets[j];
                    tmpTotal = cardTotals[j];
                    tmpColor = cardColors[j];
                    tmpCost = cardCosts[j];
                    tmpFavorite = cardFavorites[j];
                    /* store new value */
                    cardIds[j] = cardIds[j + 1];
                    cardFronts[j] = cardFronts[j + 1];
                    cardNames[j] = cardNames[j + 1];
                    cardTypes[j] = cardTypes[j + 1];
                    cardSets[j] = cardSets[j + 1];
                    cardTotals[j] = cardTotals[j + 1];
                    cardColors[j] = cardColors[j + 1];
                    cardCosts[j] = cardCosts[j + 1];
                    cardFavorites[j] = cardFavorites[j + 1];
                    /* restore tmp */
                    cardIds[j + 1] = tmpId;
                    cardFronts[j + 1] = tmpFront;
                    cardNames[j + 1] = tmpName;
                    cardTypes[j + 1] = tmpType;
                    cardSets[j + 1] = tmpSet;
                    cardTotals[j + 1] = tmpTotal;
                    cardColors[j + 1] = tmpColor;
                    cardCosts[j + 1] = tmpCost;
                    cardFavorites[j + 1] = tmpFavorite;
                }
            }
        }
    }
    else if(sortBy === "cost") {
        var i = 0;
        var j = 0;
        var tmpId;
        var tmpFront;
        var tmpType;
        var tmpSet;
        var tmpTotal;
        var tmpFavorite;
        for(i = 0 ; i < cardNum - 2 ; i++) {
            for (j = 0 ; j < cardNum - 1 ; j++) {
                if (cardCosts[j] > cardCosts[j + 1]) {
                    /* tmp storage */
                    tmpId = cardIds[j];
                    tmpFront = cardFronts[j];
                    tmpName = cardNames[j];
                    tmpType = cardTypes[j];
                    tmpSet = cardSets[j];
                    tmpTotal = cardTotals[j];
                    tmpColor = cardColors[j];
                    tmpCost = cardCosts[j];
                    tmpFavorite = cardFavorites[j];
                    /* store new value */
                    cardIds[j] = cardIds[j + 1];
                    cardFronts[j] = cardFronts[j + 1];
                    cardNames[j] = cardNames[j + 1];
                    cardTypes[j] = cardTypes[j + 1];
                    cardSets[j] = cardSets[j + 1];
                    cardTotals[j] = cardTotals[j + 1];
                    cardColors[j] = cardColors[j + 1];
                    cardCosts[j] = cardCosts[j + 1];
                    cardFavorites[j] = cardFavorites[j + 1];
                    /* restore tmp */
                    cardIds[j + 1] = tmpId;
                    cardFronts[j + 1] = tmpFront;
                    cardNames[j + 1] = tmpName;
                    cardTypes[j + 1] = tmpType;
                    cardSets[j + 1] = tmpSet;
                    cardTotals[j + 1] = tmpTotal;
                    cardColors[j + 1] = tmpColor;
                    cardCosts[j + 1] = tmpCost;
                    cardFavorites[j + 1] = tmpFavorite;
                }
            }
        }
    }
    if(type === "deck") {
        var curr = "";
        var view = "";
        var printed = 1;
        for(i = 0; i < cardNum; i++) {
            var favorited = false;
            if(cardFavorites[i] === "1") {
                favorited = true;
            }
            if(sortBy === "number") {
                if(cardTotals[i] !== curr) {
                    curr = cardTotals[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Card Number: " + curr + "<hr></h3></div></div>";
                }
            }
            else if(sortBy === "type") {
                if(cardTypes[i] !== curr) {
                    curr = cardTypes[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Card Type: " + curr + "<hr></h3></div></div>";
                }
            }
            else if(sortBy === "color") {
                if(cardColors[i] !== curr) {
                    curr = cardColors[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Color(s): " + curr + "<hr></h3></div></div>";
                }
            }
            else if(sortBy === "cost") {
                if(cardCosts[i] !== curr) {
                    curr = cardCosts[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Converted Mana Cost: " + curr + "<hr></h3></div></div>";
                }
            }
            view += "<div class='col-xs-6 col-sm-4 col-md-3'>\
            <img class='img-special' width='100%' src='" + cardFronts[i] + "' alt='" + cardFronts[i] + "' id='center-img'>";
            if(username !== null && username !== "") {
                if(username === owner) {
                    view += "<br><div class='row' style='margin: auto;display: table'>";
                    view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-left' title='Add Card To Deck' onclick=\"addCardPopup('" + cardIds[i] + "', '" + cardFronts[i] + "', '" + username + "', '" + collectionNum + "', '" + collectionIdList + "', '" + collectionNameList + "', '" + deckNum + "', '" + deckIdList + "', '" + deckNameList + "');\">\
                                <span id='button-symbol' class='glyphicon glyphicon-plus'></span>\
                            </div>";
                    if(favorited) {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-middle' title='Remove Card From Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star'></span>\
                            </div>";
                    }
                    else {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-middle' title='Add Card To Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star-empty'></span>\
                            </div>";
                    }
                    view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-right' title='Delete Card(s) From Deck' onclick=\"document.getElementById('deleteForm" + cardIds[i] + "').submit();\">\
                            <span id='button-symbol' class='glyphicon glyphicon-trash'></span>\
                        </div>";
                    view += "</div>\
                    <form id='favoriteForm" + cardIds[i] + "' action='CardServlet' method='POST'>\
                        <input type='hidden' name='action' value='favorite'>\
                        <input type='hidden' name='id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>\
                    <form id='removeForm" + cardIds[i] + "' action='DeckServlet' method='POST'>\
                        <input type='hidden' name='action' value='remove_card'>\
                        <input type='hidden' name='card_id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='id' value='" + id + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>\
                    <form id='deleteForm" + cardIds[i] + "' action='DeckServlet' method='POST'>\
                        <input type='hidden' name='action' value='delete_card'>\
                        <input type='hidden' name='card_id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='id' value='" + id + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>";
                }
                else {
                    view += "<br><div class='row' style='margin: auto;display: table'>";
                    view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-left' title='Add Card To Deck' onclick=\"addCardPopup('" + cardIds[i] + "', '" + cardFronts[i] + "', '" + username + "', '" + collectionNum + "', '" + collectionIdList + "', '" + collectionNameList + "', '" + deckNum + "', '" + deckIdList + "', '" + deckNameList + "');\">\
                                <span id='button-symbol' class='glyphicon glyphicon-plus'></span>\
                            </div>";
                    if(favorited) {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-right' title='Remove Card From Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star'></span>\
                            </div>";
                    }
                    else {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-right' title='Add Card To Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star-empty'></span>\
                            </div>";
                    }
                    view += "</div>\
                    <form id='favoriteForm" + cardIds[i] + "' action='CardServlet' method='POST'>\
                        <input type='hidden' name='action' value='favorite'>\
                        <input type='hidden' name='id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>\
                    <form id='removeForm" + cardIds[i] + "' action='DeckServlet' method='POST'>\
                        <input type='hidden' name='action' value='remove_card'>\
                        <input type='hidden' name='card_id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='id' value='" + id + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>";
                }
            } else {
                view += "<br>";
            }
            view += "<h4><p align='center' style='position: relative;top: -5px;'>\
                    <a id='menu-item' onclick=\"document.getElementById('cardForm" + cardIds[i] + "').submit();\">\
                        " + cardNames[i] + " (" + cardSets[i] + ") x " + cardTotals[i] + "\
                    </a>\
                </p></h4>\
                <form id='cardForm" + cardIds[i] + "' action='CardServlet' method='POST'>\
                    <input type='hidden' name='action' value='card'>\
                    <input type='hidden' name='id' value='" + cardIds[i] + "'>\
                    <input type='hidden' name='username' value='" + username + "'>\
                </form>\
            </div>";
            var spacer = "";
            if((printed % 2) === 0) {
                spacer += "col-xs-12";
            }
            else {
                spacer += "hidden-xs";
            }
            if((printed % 3) === 0) {
                spacer += " col-sm-12";
            }
            else {
                spacer += " hidden-sm";
            }
            if((printed % 4) === 0) {
                spacer += " col-md-12";
            }
            else {
                spacer += " hidden-md hidden-lg";
            }
            view += "<div class='" + spacer + "'><br></div>";
            printed++;
        }
        view += "<div class='col-xs-12'></div>";
    }
    else if(type === "collection") {
        var curr = "";
        var view = "";
        var printed = 1;
        for(i = 0; i < cardNum; i++) {
            var favorited = false;
            if(cardFavorites[i] === 1) {
                favorited = true;
            }
            if(sortBy === "number") {
                if(cardTotals[i] !== curr) {
                    curr = cardTotals[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Card Number: " + curr + "<hr></h3></div></div>";
                }
            }
            else if(sortBy === "type") {
                if(cardTypes[i] !== curr) {
                    curr = cardTypes[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Card Type: " + curr + "<hr></h3></div></div>";
                }
            }
            else if(sortBy === "color") {
                if(cardColors[i] !== curr) {
                    curr = cardColors[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Color(s): " + curr + "<hr></h3></div></div>";
                }
            }
            else if(sortBy === "cost") {
                if(cardCosts[i] !== curr) {
                    curr = cardCosts[i];
                    printed = 1;
                    view += "<div class='row'><div class='col-xs-12'><h3>Converted Mana Cost: " + curr + "<hr></h3></div></div>";
                }
            }
            view += "<div class='col-xs-6 col-sm-4 col-md-3'>\
            <img class='img-special' width='100%' src='" + cardFronts[i] + "' alt='" + cardFronts[i] + "' id='center-img'>";
            if(username !== null && username !== "") {
                if(username === owner) {
                    view += "<br><div class='row' style='margin: auto;display: table'>";
                    view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-left' title='Add Card To Collection' onclick=\"addCardPopup('" + cardIds[i] + "', '" + cardFronts[i] + "', '" + username + "', '" + collectionNum + "', '" + collectionIdList + "', '" + collectionNameList + "', '" + deckNum + "', '" + deckIdList + "', '" + deckNameList + "');\">\
                                <span id='button-symbol' class='glyphicon glyphicon-plus'></span>\
                            </div>";
                    if(favorited) {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-middle' title='Remove Card From Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star'></span>\
                            </div>";
                    }
                    else {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-middle' title='Add Card To Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star-empty'></span>\
                            </div>";
                    }
                    view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-right' title='Delete Card(s) From Collection' onclick=\"document.getElementById('deleteForm" + cardIds[i] + "').submit();\">\
                            <span id='button-symbol' class='glyphicon glyphicon-trash'></span>\
                        </div>";
                    view += "</div>\
                    <form id='favoriteForm" + cardIds[i] + "' action='CardServlet' method='POST'>\
                        <input type='hidden' name='action' value='favorite'>\
                        <input type='hidden' name='id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>\
                    <form id='removeForm" + cardIds[i] + "' action='CollectionServlet' method='POST'>\
                        <input type='hidden' name='action' value='remove_card'>\
                        <input type='hidden' name='card_id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='id' value='" + id + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>\
                    <form id='deleteForm" + cardIds[i] + "' action='CollectionServlet' method='POST'>\
                        <input type='hidden' name='action' value='delete_card'>\
                        <input type='hidden' name='card_id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='id' value='" + id + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>";
                }
                else {
                    view += "<br><div class='row' style='margin: auto;display: table'>";
                    view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-left' title='Add Card To Collection' onclick=\"addCardPopup('" + cardIds[i] + "', '" + cardFronts[i] + "', '" + username + "', '" + collectionNum + "', '" + collectionIdList + "', '" + collectionNameList + "', '" + deckNum + "', '" + deckIdList + "', '" + deckNameList + "');\">\
                                <span id='button-symbol' class='glyphicon glyphicon-plus'></span>\
                            </div>";
                    if(favorited) {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-right' title='Remove Card From Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star'></span>\
                            </div>";
                    }
                    else {
                        view += "<div class='col-xs-2' style='margin: auto;display: table' id='button-back-right' title='Add Card To Favorites List' onclick=\"document.getElementById('favoriteForm" + cardIds[i] + "').submit();\">\
                                <span id='button-symbol' class='glyphicon glyphicon-star-empty'></span>\
                            </div>";
                    }
                    view += "</div>\
                    <form id='favoriteForm" + cardIds[i] + "' action='CardServlet' method='POST'>\
                        <input type='hidden' name='action' value='favorite'>\
                        <input type='hidden' name='id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>\
                    <form id='removeForm" + cardIds[i] + "' action='CollectionServlet' method='POST'>\
                        <input type='hidden' name='action' value='remove_card'>\
                        <input type='hidden' name='card_id' value='" + cardIds[i] + "'>\
                        <input type='hidden' name='id' value='" + id + "'>\
                        <input type='hidden' name='username' value='" + username + "'>\
                    </form>";
                }
            } else {
                view += "<br>";
            }
            view += "<h4><p align='center' style='position: relative;top: -5px;'>\
                    <a id='menu-item' onclick=\"document.getElementById('cardForm" + cardIds[i] + "').submit();\">\
                        " + cardNames[i] + " (" + cardSets[i] + ") x " + cardTotals[i] + "\
                    </a>\
                </p></h4>\
                <form id='cardForm" + cardIds[i] + "' action='CardServlet' method='POST'>\
                    <input type='hidden' name='action' value='card'>\
                    <input type='hidden' name='id' value='" + cardIds[i] + "'>\
                    <input type='hidden' name='username' value='" + username + "'>\
                </form>\
            </div>";
            var spacer = "";
            if((printed % 2) === 0) {
                spacer += "col-xs-12";
            }
            else {
                spacer += "hidden-xs";
            }
            if((printed % 3) === 0) {
                spacer += " col-sm-12";
            }
            else {
                spacer += " hidden-sm";
            }
            if((printed % 4) === 0) {
                spacer += " col-md-12";
            }
            else {
                spacer += " hidden-md hidden-lg";
            }
            view += "<div class='" + spacer + "'><br></div>";
            printed++;
        }
        view += "<div class='col-xs-12'></div>";
    }
    document.getElementById("sortArea").innerHTML = view;
    revealForm("sortArea");
}

function convertHTML(str) {
  var map = {
    '&': '&amp',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    '\'': '&apos;'
  };
  return str.replace(/[&<>"']/g, function(m) { return map[m]; });
}

function parseString(input) {
    var parsed = input.split(".");
    var output = "";
    for(var i = 0; i < parsed.length; i++) {
        output += String.fromCharCode(parsed[i]);
    }
    return convertHTML(output);
}

function addCardPopup(id, imagePath, username, collectionNum, collectionIdList, collectionNameList, deckNum, deckIdList, deckNameList) {
    var collectionIds = collectionIdList.split("`");
    var collectionNames = collectionNameList.split("`");
    for(i = 0; i < collectionNum; i++) {
        collectionNames[i] = parseString(collectionNames[i]);
    }
    var deckIds = deckIdList.split("`");
    var deckNames = deckNameList.split("`");
    for(i = 0; i < deckNum; i++) {
        deckNames[i] = parseString(deckNames[i]);
    }
    var i;
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='add_card'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                Add Card To Collection Or Deck\
            </p>\
        </h2><br>\
        <div class='hidden-xs hidden-sm col-md-6'>\
            <img class='img-special' style='width: 90%;' src='" + imagePath + "' alt='" + imagePath + "' id='center-img'>\
            <br>\
        </div>\
        <div class='hidden-xs hidden-sm col-md-6' style='position: relative;left: -22px;'>";
        if(username === null || username === "") {
            view += "<h4>\
                In order to add this card to a collection or deck, you must first login or sign up for an account.\
                <div class='col-xs-12'><br></div>\
            </h4>";
        } else {
            view += "<h4>\
                Select the collection and/or deck you would like to add the card to from the drop-down list(s), input the number of cards, and then click the button below. If the card already exists, it will be added to the current card total.\
            </h4><hr>\
            <h4 id='title'>\
                Add <input id='input-field' class='input-number' name='deck_total1' type='number' value='0'> To Deck:<br><br>\
                <select name='deck1' id='input-field'>\
                    <option value=''>Choose deck...</option>";
            for (i = 0; i < deckNum; i++) {
                view += "<option value='" + deckIds[i] + "'>" + deckNames[i] + "</option>";
            }
            view += "</select><br><br>\
                Add <input id='input-field' class='input-number' name='collection_total1' type='number' value='0'> To Collection:<br><br>\
                <select name='collection2' id='input-field'>\
                    <option value=''>Choose collection...</option>";
            for (i = 0; i < collectionNum; i++) {
                view += "<option value='" + collectionIds[i] + "'>" + collectionNames[i] + "</option>";
            }
            view += "</select><br><br>\
                <button title='Add Card To Collection/Deck' id='form-submit' type='submit'>Submit</button>\
                <div class='col-xs-12'><br></div>\
            </h4>";
        }
        view += "</div>\
        <div class='col-xs-12 hidden-md hidden-lg'>";
        if(username === null || username === "") {
            view += "<h4>\
                In order to add this card to a collection or deck, you must first login or sign up for an account.\
                <div class='col-xs-12'><br></div>\
            </h4>";
        } else {
            view += "<h4 id='title'>\
                Add <input id='input-field' class='input-number' name='deck_total2' type='number' value='0'> To Deck:<br><br>\
                <select name='deck2' id='input-field'>\
                    <option value=''>Choose deck...</option>";
            for (i = 0; i < deckNum; i++) {
                view += "<option value='" + deckIds[i] + "'>" + deckNames[i] + "</option>";
            }
            view += "</select><br><br>\
                Add <input id='input-field' class='input-number' name='collection_total2' type='number' value='0'> To Collection:<br><br>\
                <select name='collection1' id='input-field'>\
                    <option value=''>Choose collection...</option>";
            for (i = 0; i < collectionNum; i++) {
                view += "<option value='" + collectionIds[i] + "'>" + collectionNames[i] + "</option>";
            }
            view += "</select><br><br>\
                <button title='Add Card To Collection/Deck' id='form-submit' type='submit'>Submit</button>\
                <div class='col-xs-12'><br></div>\
            </h4>";
        }
        view += "</div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function challengeDeckPopup(id, imagePathTop, imagePathBottom, username, owner, deckNum, deckIdList, deckNameList, prevWon, prevMatches) {
    var deckIds = deckIdList.split("`");
    var deckNames = deckNameList.split("`");
    for(i = 0; i < deckNum; i++) {
        deckNames[i] = parseString(deckNames[i]);
    }
    var i;
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='challenge_deck'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='owner' value='" + owner + "'>\
    <input type='hidden' name='times_prev_won' value='" + prevWon + "'>\
    <input type='hidden' name='times_prev_played' value='" + prevMatches + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                Challenge Deck Request\
            </p>\
        </h2><br>\
        <div class='hidden-xs hidden-sm col-md-6'>\
            <div class='deck-image'>\
                <img width='90%' src='" + imagePathBottom + "' alt='" + imagePathBottom + "' id='center-img'>\
                <img class='img-special cover-special' width='85%' src='" + imagePathTop + "' alt='" + imagePathTop + "' id='center-img'>\
                <br>\
            </div>\
        </div>\
        <div class='hidden-xs hidden-sm col-md-6' style='position: relative;left: -22px;'>";
        if(username === null || username === "") {
            view += "<h4>\
                In order to challenge this deck, you must first login or sign up for an account.\
                <div class='col-xs-12'><br></div>\
            </h4>";
        } else {
            view += "<h4>\
                Select the deck which you used to challenge this deck from the drop-down list below. You must also input the number of times you won out of the number of matches played. Once submitted, the user you challenged can accept or reject the outcome from their Notifications Page.\
            </h4><hr>\
            <h4 id='title'>\
                Your Deck<br><select name='deck1' id='input-field'><br><br>\
                    <option value=''>Choose deck...</option>";
            for (i = 0; i < deckNum; i++) {
                view += "<option value='" + deckIds[i] + "'>" + deckNames[i] + "</option>";
            }
            view += "</select><br><br>\
                You Won <input id='input-field' class='input-number' name='times_won1' type='number' value='0'> Out Of <input id='input-field' class='input-number' name='times_played1' type='number' value='0'> Matches<br><br>\
                Memo: <input id='input-field-alt' name='text' value='Good game!'><br><br>\
                <button title='Submit Challenge Request' id='form-submit' type='submit'>Submit</button>\
                <div class='col-xs-12'><br></div>\
            </h4>";
        }
        view += "</div>\
        <div class='col-xs-12 hidden-md hidden-lg'>";
        if(username === null || username === "") {
            view += "<h4>\
                In order to challenge this deck, you must first login or sign up for an account.\
                <div class='col-xs-12'><br></div>\
            </h4>";
        } else {
            view += "<h4 id='title'>\
                Your Deck<br><select name='deck2' id='input-field'><br><br>\
                    <option value=''>Choose deck...</option>";
            for (i = 0; i < deckNum; i++) {
                view += "<option value='" + deckIds[i] + "'>" + deckNames[i] + "</option>";
            }
            view += "</select><br><br>\
                You Won <input id='input-field' class='input-number' name='times_won1' type='number' value='0'> Out Of <input id='input-field' class='input-number' name='times_played1' type='number' value='0'> Matches<br><br>\
                Memo: <input id='input-field-alt' name='text' value='Good game!'><br><br>\
                <button title='Submit Challenge Request' id='form-submit' type='submit'>Submit</button>\
                <div class='col-xs-12'><br></div>\
            </h4>";
        }
        view += "</div>\
            </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function editCardCommentPopup(id, commentId, username, content) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='edit_card_comment'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='comment_id' value='" + commentId + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                Edit Comment\
            </p>\
        </h2><br>\
        <h4>\
            You may edit your comment using the textbox provided and then by clicking the submit button below.\
            <br><br>\
            <textarea id='input-field' name='comment'>" + content + "</textarea>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-12'>\
            <button title='Submit Edit Comment' id='form-submit' type='submit'>Submit</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function deleteCardCommentPopup(id, commentId, username) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='delete_card_comment'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='comment_id' value='" + commentId + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                <span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;Confirmation Needed&nbsp;&nbsp;<span class='glyphicon glyphicon-alert'></span>\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Do you really want to delete this comment? This action cannot be undone.\
            </p>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-6'>\
            <button title='Confirm' id='form-submit' type='submit'>Yes, Delete</button>\
        </div>\
        <div class='col-xs-6'>\
            <button type='button' title='Cancel' id='form-submit' onclick='hideForm(\"popupForm\");'>No, Cancel</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function editDeckCommentPopup(id, commentId, username, content) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='edit_deck_comment'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='comment_id' value='" + commentId + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                Edit Comment\
            </p>\
        </h2><br>\
        <h4>\
            You may edit your comment using the textbox provided and then by clicking the submit button below.\
            <br><br>\
            <textarea id='input-field' name='comment'>" + content + "</textarea>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-12'>\
            <button title='Submit Edit Comment' id='form-submit' type='submit'>Submit</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function deleteDeckCommentPopup(id, commentId, username) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='delete_deck_comment'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='comment_id' value='" + commentId + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                <span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;Confirmation Needed&nbsp;&nbsp;<span class='glyphicon glyphicon-alert'></span>\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Do you really want to delete this comment? This action cannot be undone.\
            </p>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-6'>\
            <button title='Confirm' id='form-submit' type='submit'>Yes, Delete</button>\
        </div>\
        <div class='col-xs-6'>\
            <button type='button' title='Cancel' id='form-submit' onclick='hideForm(\"popupForm\");'>No, Cancel</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function editCollectionCommentPopup(id, commentId, username, content) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='edit_collection_comment'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='comment_id' value='" + commentId + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                Edit Comment\
            </p>\
        </h2><br>\
        <h4>\
            You may edit your comment using the textbox provided and then by clicking the submit button below.\
            <br><br>\
            <textarea id='input-field' name='comment'>" + content + "</textarea>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-12'>\
            <button title='Submit Edit Comment' id='form-submit' type='submit'>Submit</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function deleteCollectionCommentPopup(id, commentId, username) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='delete_collection_comment'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='comment_id' value='" + commentId + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                <span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;Confirmation Needed&nbsp;&nbsp;<span class='glyphicon glyphicon-alert'></span>\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Do you really want to delete this comment? This action cannot be undone.\
            </p>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-6'>\
            <button title='Confirm' id='form-submit' type='submit'>Yes, Delete</button>\
        </div>\
        <div class='col-xs-6'>\
            <button type='button' title='Cancel' id='form-submit' onclick='hideForm(\"popupForm\");'>No, Cancel</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function deleteUserPopup(username) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='delete_user'>\
    <input type='hidden' name='id' value='" + username + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                <span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;Confirmation Needed&nbsp;&nbsp;<span class='glyphicon glyphicon-alert'></span>\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Do you really want to delete your account? This action cannot be undone.\
            </p><p align='center'>\
                If you do, type in your password below:\
            </p>\
            <div class='col-xs-12'>\
                <input id='input-field' type='text' name='password' placeholder='Input your password...' required>\
            </div>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-6'>\
            <button title='Confirm' id='form-submit' type='submit'>Yes, Delete</button>\
        </div>\
        <div class='col-xs-6'>\
            <button type='button' title='Cancel' id='form-submit' onclick='hideForm(\"popupForm\");'>No, Cancel</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function deleteDeckPopup(id, username) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='delete_deck'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                <span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;Confirmation Needed&nbsp;&nbsp;<span class='glyphicon glyphicon-alert'></span>\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Do you really want to delete this deck? This action cannot be undone.\
            </p>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-6'>\
            <button title='Confirm' id='form-submit' type='submit'>Yes, Delete</button>\
        </div>\
        <div class='col-xs-6'>\
            <button type='button' title='Cancel' id='form-submit' onclick='hideForm(\"popupForm\");'>No, Cancel</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function deleteCollectionPopup(id, username) {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='delete_collection'>\
    <input type='hidden' name='id' value='" + id + "'>\
    <input type='hidden' name='username' value='" + username + "'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                <span class='glyphicon glyphicon-alert'></span>&nbsp;&nbsp;Confirmation Needed&nbsp;&nbsp;<span class='glyphicon glyphicon-alert'></span>\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Do you really want to delete this deck? This action cannot be undone.\
            </p>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-6'>\
            <button title='Confirm' id='form-submit' type='submit'>Yes, Delete</button>\
        </div>\
        <div class='col-xs-6'>\
            <button type='button' title='Cancel' id='form-submit' onclick='hideForm(\"popupForm\");'>No, Cancel</button>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}

function forgotPasswordPopup() {
    var view = "<div id='overlay' onclick='hideForm(\"popupForm\");'></div>\
    <input type='hidden' name='action' value='forgot'>\
    <div class='col-xs-12'>\
        <h2>\
            <p align='center'>\
                Forgotten Password\
            </p>\
        </h2><br>\
        <h4>\
            <p align='center'>\
                Did you forget your password? Fill in the following fields with your username and email, and a temporary password will be sent to you. Please change your password upon logging in again.\
            </p>\
            <hr>\
            <div class='col-xs-12 col-sm-3 col-md-2'>\
                <div class='row'>\
                    <p id='title'>Username</p>\
                </div>\
            </div>\
            <div class='col-xs-12 col-sm-9 col-md-10'>\
                <div class='row'>\
                    <input id='input-field' name='username' type='text' placeholder='username' required>\
                </div>\
            </div>\
            <div class='col-xs-12'><br></div>\
            <div class='col-xs-12 col-sm-3 col-md-2'>\
                <div class='row'>\
                    <p id='title'>Email</p>\
                </div>\
            </div>\
            <div class='col-xs-12 col-sm-9 col-md-10'>\
                <div class='row'>\
                    <input id='input-field' name='email' type='text' placeholder='email@example.com' required>\
                </div>\
            </div>\
        </h4><br><hr>\
        <div class='col-xs-12'><br></div>\
        <div class='col-xs-12'>\
            <div class='row'>\
                    <button title='Submit Forgot Password Form' id='form-submit' type='submit'>Submit</button>\
            </div>\
        </div>\
        <div class='col-xs-12'><br></div>\
    </div>";
    document.getElementById("popupForm").innerHTML = view;
    revealForm("popupForm");
}