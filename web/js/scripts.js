var mana = [false, false, false, false, false];

function refresh() {
    selectMana("", -1);
}

function reveal(imageId, containerId, capsuleId) {
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
    var ypos = rect.top - cap.top - (2 * height / 3);
    
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
        }
        else {
            document.getElementById(id).style.background = "url(images/white_off.png)";
        }
        if(mana[1]) {
            document.getElementById(id).style.background = "url(images/blue_on.png)";
        }
        else {
            document.getElementById(id).style.background = "url(images/blue_off.png)";
        }
        if(mana[2]) {
            document.getElementById(id).style.background = "url(images/black_on.png)";
        }
        else {
            document.getElementById(id).style.background = "url(images/black_off.png)";
        }
        if(mana[3]) {
            document.getElementById(id).style.background = "url(images/red_on.png)";
        }
        else {
            document.getElementById(id).style.background = "url(images/red_off.png)";
        }
        if(mana[4]) {
            document.getElementById(id).style.background = "url(images/green_on.png)";
        }
        else {
            document.getElementById(id).style.background = "url(images/green_off.png)";
        }
    }
    switch(num) {
    case 0:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/white_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById(id).style.background = "url(images/white_on.png)";
            mana[num] = true;
        }
        break;
    case 1:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/blue_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById(id).style.background = "url(images/blue_on.png)";
            mana[num] = true;
        }
        break;
    case 2:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/black_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById(id).style.background = "url(images/black_on.png)";
            mana[num] = true;
        }
        break;
    case 3:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/red_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById(id).style.background = "url(images/red_on.png)";
            mana[num] = true;
        }
        break;
    case 4:
        if(mana[num]) {
            document.getElementById(id).style.background = "url(images/green_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById(id).style.background = "url(images/green_on.png)";
            mana[num] = true;
        }
        break;
    default:
        mana = [false, false, false, false, false];
        document.getElementById("white-mana-1").style.background = "url(images/white_off.png)";
        document.getElementById("white-mana-2").style.background = "url(images/white_off.png)";
        document.getElementById("white-mana-3").style.background = "url(images/white_off.png)";
        document.getElementById("blue-mana-1").style.background = "url(images/blue_off.png)";
        document.getElementById("blue-mana-2").style.background = "url(images/blue_off.png)";
        document.getElementById("blue-mana-3").style.background = "url(images/blue_off.png)";
        document.getElementById("black-mana-1").style.background = "url(images/black_off.png)";
        document.getElementById("black-mana-2").style.background = "url(images/black_off.png)";
        document.getElementById("black-mana-3").style.background = "url(images/black_off.png)";
        document.getElementById("red-mana-1").style.background = "url(images/red_off.png)";
        document.getElementById("red-mana-2").style.background = "url(images/red_off.png)";
        document.getElementById("red-mana-3").style.background = "url(images/red_off.png)";
        document.getElementById("green-mana-1").style.background = "url(images/green_off.png)";
        document.getElementById("green-mana-2").style.background = "url(images/green_off.png)";
        document.getElementById("green-mana-3").style.background = "url(images/green_off.png)";
    }
}