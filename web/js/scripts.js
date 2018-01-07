var mana = [false, false, false, false, false];

function refresh() {
    selectMana("", -1);
}

function reveal(imageId, detailsId, textId, arrowId, containerId, capsuleId) {
    var image = document.getElementById(imageId);
    var details = document.getElementById(detailsId)
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
    
    details.style.position = "absolute";
    details.style.left = (xpos) + "px";
    details.style.top = (ypos + container.clientWidth * 1.4) + "px";
    details.style.display = "block";
    details.style.width = (container.clientWidth + 1) + "px";
    
    arrow.style.position = "absolute";
    arrow.style.left = (xpos + container.clientWidth) + "px";
    arrow.style.top = (ycoor + 85) + "px";
    arrow.style.display = "block";
}

function conceal(imageId, detailsId, arrowId) {
    var image = document.getElementById(imageId);
    var details = document.getElementById(detailsId);
    var arrow = document.getElementById(arrowId);
    
    image.style.display = "none";
    details.style.display = "none";
    arrow.style.display = "none";
}

function  selectMana(id, num) {
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