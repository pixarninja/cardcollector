function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) === 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function checkCookie() {
    var username = getCookie("username");
    if (username !== "") {
        alert("Welcome again " + username);
    } else {
        username = prompt("Please enter your name:", "");
        if (username !== "" && username !== null) {
            setCookie("username", username, 365);
        }
    }
}

function addToDeck() {
    var name = prompt("Deck Name:", "");
    if (name !== "" && name !== null) {
        setCookie("name", name, 365);
        alert("Set name: " + name);
    }
    var name2 = prompt("Collection Name:", "");
    if (name2 !== "" && name2 !== null) {
        setCookie("name", name2, 365);
        alert("Set name: " + name2);
    }
}

function revealForm(formId, imageId, imagePath) {
    document.getElementById(formId).style.display = "block";
    document.getElementById("insert-id").innerHTML = "<input type='hidden' name='id' value='" + imageId + "'>";
    document.getElementById("insert-image").innerHTML = "<img class='img-special' width='85%' src='" + imagePath + "' alt='" + imagePath + "' id='center-img' style='position: relative;left: 5px;'></img>"
}

function hideForm(formId) {
    document.getElementById(formId).style.display = "none";
}