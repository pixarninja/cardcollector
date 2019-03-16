var mana = [false, false, false, false, false, false];

function refresh() {
    selectMana("", -1);
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