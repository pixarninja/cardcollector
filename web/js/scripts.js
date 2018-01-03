var mana = [false, false, false, false, false];

function refresh() {
    selectMana(-1);
}

function reveal(imageId, containerId, event) {
    var image = document.getElementById(imageId);
    var container = document.getElementById(containerId);
    var xOffset = event.clientX - (container.clientWidth + 1);
    var yOffset = event.clientY + (container.clientHeight + 1);
    
    image.style.position = "absolute";
    image.style.left = (event.clientX - xOffset) + "px";
    image.style.top = (event.clientY - yOffset) + "px";
    image.style.display = "block";
    image.style.width = (container.clientWidth + 1) + "px";
}

function conceal(imageId) {
    var image = document.getElementById(imageId);
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