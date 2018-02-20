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
    var height = width * 1.4;
    if(width > 250) {
        width = 250;
    }
    var xpos = rect.left - cap.left - width + 15;
    var ypos;
    if(target === "your_decks") {
        ypos = rect.top - cap.top - (2 * height / 3);
    } else if(target === "your_collections") {
        ypos = rect.top - cap.top - (2 * height / 3);
    } else if(target === "edit_deck") {
        ypos = rect.top - cap.top - (4 * height / 5);
        xpos = xpos - 20;
    } else if(target === "edit_collection") {
        ypos = rect.top - cap.top - (4 * height / 5);
        xpos = xpos - 20;
    }
    else {
        ypos = rect.top - cap.top;
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

function addCardPopup(id, imagePath, username, collectionNum, collectionIdList, collectionNameList, deckNum, deckIdList, deckNameList) {
    var collectionIds = collectionIdList.split("`");
    var collectionNames = collectionNameList.split("`");
    var deckIds = deckIdList.split("`");
    var deckNames = deckNameList.split("`");
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
                Add <input id='input-field' class='input-number' name='collection_total' type='number' value='0'> To Collection:<br><br>\
                <select name='collection' id='input-field'>\
                    <option value=''>Choose collection...</option>";
            for (i = 0; i < collectionNum; i++) {
                view += "<option value='" + collectionIds[i] + "'>" + collectionNames[i] + "</option>";
            }
            view += "</select><br><br>\
                    Add <input id='input-field' class='input-number' name='deck_total' type='number' value='0'> To Deck:<br><br>\
                    <select name='deck' id='input-field'>\
                        <option value=''>Choose deck...</option>";
            for (i = 0; i < deckNum; i++) {
                view += "<option value='" + deckIds[i] + "'>" + deckNames[i] + "</option>";
            }
            view += "</select>\
                <br><br>\
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
                Add <input id='input-field' name='collection_total' type='number' style='width: 40px;' placeholder='0'> To Collection:<br><br>\
                <select name='collection' id='input-field'>\
                    <option value=''></option>";
            for (i = 0; i < collectionNum; i++) {
                view += "<option value='" + collectionIds[i] + "'>" + collectionNames[i] + "</option>";
            }
            view += "</select><br><br>\
                Add <input id='input-field' name='deck_total' type='number' style='width: 40px;' placeholder='0'> To Deck:<br><br>\
                <select name='deck' id='input-field'>\
                    <option value=''></option>";
            for (i = 0; i < deckNum; i++) {
                view += "<option value='" + deckIds[i] + "'>" + deckNames[i] + "</option>";
            }
            view += "</select>\
                <br><br>\
                <button title='Add Card To Collection/Deck' id='form-submit' type='submit'><span class='glyphicon glyphicon-plus'></span></button>\
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
    <input type='hidden' name='id' value='" + username + "'>\\n\
    <input type='hidden' name='username' value=''>\
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