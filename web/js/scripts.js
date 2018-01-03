$(document).ready(function() {
    var xOffset = 0;
    var yOffset = 0;
    var path = "/images/blank_user.jpg";
    
    $(".text-hover-image").hover(function(e) {
        $("body").append("<p id='image-when-hovering-text'> Derp derp derp <img src='" + path + "'/></p>");
        $("#image-when-hovering-text")
                .css("position", "absolute")
                .css("top", (e.pageY - yOffset) + "px")
                .css("left", (e.pageX - xOffset) + "px")
                .fadeIn("fast");
    },
    
    function () {
        $("#image-when-hovering-text").remove();
    });
    
    $(".text-hover-image").mousemove(function(e) {
        $("#image-when-hovering-text")
                .css("top", (e.pageY - yOffset) + "px")
                .css("left", (e.pageX - xOffset) + "px");
    });
});

var mana = [false, false, false, false, false];

function refresh() {
    selectMana(-1);
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