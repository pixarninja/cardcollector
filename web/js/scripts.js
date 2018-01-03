var mana = [false, false, false, false, false];

function refresh() {
    selectMana(-1);
}

function reveal(imageId, textId, arrowId, containerId, capsuleId) {
    var image = document.getElementById(imageId);
    var text = document.getElementById(textId);
    var arrow = document.getElementById(arrowId);
    var container = document.getElementById(containerId);
    var capsule = document.getElementById(capsuleId);
    
    var rect = container.getBoundingClientRect();
    var textRect = text.getBoundingClientRect();
    var cap = capsule.getBoundingClientRect();
    var xpos = rect.left - cap.left - container.clientWidth + 10;
    var ypos = rect.top - cap.top - container.clientHeight;
    var ycoor = textRect.bottom - cap.top - container.clientHeight;
    
    image.style.position = "absolute";
    image.style.left = (xpos) + "px";
    image.style.top = (ypos) + "px";
    image.style.display = "block";
    image.style.width = (container.clientWidth + 1) + "px";
    
    arrow.style.position = "absolute";
    arrow.style.left = (xpos + container.clientWidth) + "px";
    arrow.style.top = (ycoor + 85) + "px";
    arrow.style.display = "block";
}

function conceal(imageId, arrowId) {
    var arrow = document.getElementById(arrowId);
    var image = document.getElementById(imageId);
    
    arrow.style.display = "none";
    image.style.display = "none";
}

function  selectMana(num) {
    if(mana[0]) {
        document.getElementById("white-mana").style.background = "url(images/white_on.png)";
    }
    else {
        document.getElementById("white-mana").style.background = "url(images/white_off.png)";
    }
    if(mana[1]) {
        document.getElementById("blue-mana").style.background = "url(images/blue_on.png)";
    }
    else {
        document.getElementById("blue-mana").style.background = "url(images/blue_off.png)";
    }
    if(mana[2]) {
        document.getElementById("black-mana").style.background = "url(images/black_on.png)";
    }
    else {
        document.getElementById("black-mana").style.background = "url(images/black_off.png)";
    }
    if(mana[3]) {
        document.getElementById("red-mana").style.background = "url(images/red_on.png)";
    }
    else {
        document.getElementById("red-mana").style.background = "url(images/red_off.png)";
    }
    if(mana[4]) {
        document.getElementById("green-mana").style.background = "url(images/green_on.png)";
    }
    else {
        document.getElementById("green-mana").style.background = "url(images/green_off.png)";
    }
    switch(num) {
    case 0:
        if(mana[num]) {
            document.getElementById("white-mana").style.background = "url(images/white_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById("white-mana").style.background = "url(images/white_on.png)";
            mana[num] = true;
        }
        break;
    case 1:
        if(mana[num]) {
            document.getElementById("blue-mana").style.background = "url(images/blue_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById("blue-mana").style.background = "url(images/blue_on.png)";
            mana[num] = true;
        }
        break;
    case 2:
        if(mana[num]) {
            document.getElementById("black-mana").style.background = "url(images/black_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById("black-mana").style.background = "url(images/black_on.png)";
            mana[num] = true;
        }
        break;
    case 3:
        if(mana[num]) {
            document.getElementById("red-mana").style.background = "url(images/red_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById("red-mana").style.background = "url(images/red_on.png)";
            mana[num] = true;
        }
        break;
    case 4:
        if(mana[num]) {
            document.getElementById("green-mana").style.background = "url(images/green_off.png)";
            mana[num] = false;
        }
        else {
            document.getElementById("green-mana").style.background = "url(images/green_on.png)";
            mana[num] = true;
        }
        break;
    default:
        mana = [false, false, false, false, false];
        document.getElementById("white-mana").style.background = "url(images/white_off.png)";
        document.getElementById("blue-mana").style.background = "url(images/blue_off.png)";
        document.getElementById("black-mana").style.background = "url(images/black_off.png)";
        document.getElementById("red-mana").style.background = "url(images/red_off.png)";
        document.getElementById("green-mana").style.background = "url(images/green_off.png)";
    }
}