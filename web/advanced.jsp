<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="beans.*"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = null;
    Cookie cookie = null;
    Cookie[] cookies = null;
    cookies = request.getCookies();
    boolean found = false;

    if( cookies != null ) {
       for (int i = 0; i < cookies.length; i++) {
          cookie = cookies[i];
          if(cookie.getName().equals("username")) {
              username = cookie.getValue();
              found = true;
              break;
          }
       }
    }
    if(!found) {
        if((String)request.getAttribute("username") == null) {
            username = request.getParameter("username");
        }
        else {
            username = (String)request.getAttribute("username");
        }
    }
    if(username == null || username.equals("null")) {
        username = "";
    }
%>
<%@include file="header.jsp"%>
<!-- Add code here -->
<div class="well row">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <h2>Advanced Search</h2><br>
            <%
                if((Integer)request.getAttribute("total") == 0) {
            %>
                <h4>
                    No results were queried. Try checking your spelling or selecting to search inclusively (using "OR" rather than "AND").
                </h4><br><br>
            <%}%>
            <h4>
                Fill in the fields below in order to search our database for cards, decks, or users. If you search without selecting any query items, the database will return all entries in that category.
                <br><br><br><hr>
            </h4>
        </div>
        <div class="col-xs-12 col-md-5">
            <h3>Cards<hr></h3>
            <form id="searchCardsForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="cards">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order By</p>
                    </div>
                    <div class="col-xs-8">
                        <select name="order_by" id="input-field">
                            <option value="name">Name</option>
                            <option value="type">Type</option>
                            <option value="text">Text</option>
                            <option value="colors">Mana Color</option>
                            <option value="mc">Mana Cost</option>
                            <option value="set_name">Edition</option>
                            <option value="rarity">Rarity</option>
                            <option value="power">Power</option>
                            <option value="toughness">Toughness</option>
                            <option value="loyalty">Loyalty</option>
                            <option value="artist">Artist</option>
                            <option value="year">Year</option>
                        </select>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Inclusion</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="exc" checked> Match Exactly ("AND")
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="inc"> Match Any ("OR")
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Edition</p>
                    </div>
                    <div class="col-xs-8">
                        <select name="set_id" id="input-field">
                            <option></option>
                            <option value="rix">Rivals of Ixalan (2018)</option>
                            <option value="ust">Unstable (2017)</option>
                            <option value="e02">Explorers of Ixalan (2017)</option>
                            <option value="v17">From the Vault: Transform (2017)</option>
                            <option value="ima">Iconic Masters (2017)</option>
                            <option value="ddt">Duel Decks: Merfolk vs. Goblins (2017)</option>
                            <option value="xln">Ixalan (2017)</option>
                            <option value="h17">HasCon 2017 (2017)</option>
                            <option value="htr">2016 Heroes of the Realm (2017)</option>
                            <option value="c17">Commander 2017 (2017)</option>
                            <option value="hou">Hour of Devastation (2017)</option>
                            <option value="e01">Archenemy: Nicol Bolas (2017)</option>
                            <option value="cma">Commander Anthology (2017)</option>
                            <option value="akh">Amonkhet (2017)</option>
                            <option value="w17">Welcome Deck 2017 (2017)</option>
                            <option value="dds">Duel Decks: Mind vs. Might (2017)</option>
                            <option value="mm3">Modern Masters 2017 (2017)</option>
                            <option value="aer">Aether Revolt (2017)</option>
                            <option value="pca">Planechase Anthology (2016)</option>
                            <option value="pz2">You Make the Cube (2016)</option>
                            <option value="c16">Commander 2016 (2016)</option>
                            <option value="kld">Kaladesh (2016)</option>
                            <option value="ddr">Duel Decks: Nissa vs. Ob Nixilis (2016)</option>
                            <option value="cn2">Conspiracy: Take the Crown (2016)</option>
                            <option value="v16">From the Vault: Lore (2016)</option>
                            <option value="emn">Eldritch Moon (2016)</option>
                            <option value="ema">Eternal Masters (2016)</option>
                            <option value="soi">Shadows over Innistrad (2016)</option>
                            <option value="w16">Welcome Deck 2016 (2016)</option>
                            <option value="ddq">Duel Decks: Blessed vs. Cursed (2016)</option>
                            <option value="ogw">Oath of the Gatewatch (2016)</option>
                            <option value="pz1">Legendary Cube (2015)</option>
                            <option value="c15">Commander 2015 (2015)</option>
                            <option value="bfz">Battle for Zendikar (2015)</option>
                            <option value="ddp">Duel Decks: Zendikar vs. Eldrazi (2015)</option>
                            <option value="v15">From the Vault: Angels (2015)</option>
                            <option value="ori">Magic Origins (2015)</option>
                            <option value="mm2">Modern Masters 2015 (2015)</option>
                            <option value="tpr">Tempest Remastered (2015)</option>
                            <option value="dtk">Dragons of Tarkir (2015)</option>
                            <option value="ddo">Duel Decks: Elspeth vs. Kiora (2015)</option>
                            <option value="frf">Fate Reforged (2015)</option>
                            <option value="gvl">Duel Decks Anthology: Garruk vs. Liliana (2014)</option>
                            <option value="evg">Duel Decks Anthology: Elves vs. Goblins (2014)</option>
                            <option value="jvc">Duel Decks Anthology: Jace vs. Chandra (2014)</option>
                            <option value="dvd">Duel Decks Anthology: Divine vs. Demonic (2014)</option>
                            <option value="c14">Commander 2014 (2014)</option>
                            <option value="ktk">Khans of Tarkir (2014)</option>
                            <option value="ddn">Duel Decks: Speed vs. Cunning (2014)</option>
                            <option value="v14">From the Vault: Annihilation (2014)</option>
                            <option value="m15">Magic 2015 (2014)</option>
                            <option value="vma">Vintage Masters (2014)</option>
                            <option value="cns">Conspiracy (2014)</option>
                            <option value="md1">Modern Event Deck 2014 (2014)</option>
                            <option value="jou">Journey into Nyx (2014)</option>
                            <option value="ddm">Duel Decks: Jace vs. Vraska (2014)</option>
                            <option value="bng">Born of the Gods (2014)</option>
                            <option value="c13">Commander 2013 (2013)</option>
                            <option value="ths">Theros (2013)</option>
                            <option value="ddl">Duel Decks: Heroes vs. Monsters (2013)</option>
                            <option value="v13">From the Vault: Twenty (2013)</option>
                            <option value="m14">Magic 2014 (2013)</option>
                            <option value="mma">Modern Masters (2013)</option>
                            <option value="dgm">Dragon's Maze (2013)</option>
                            <option value="ddk">Duel Decks: Sorin vs. Tibalt (2013)</option>
                            <option value="gtc">Gatecrash (2013)</option>
                            <option value="cm1">Commander's Arsenal (2012)</option>
                            <option value="rtr">Return to Ravnica (2012)</option>
                            <option value="ddj">Duel Decks: Izzet vs. Golgari (2012)</option>
                            <option value="v12">From the Vault: Realms (2012)</option>
                            <option value="m13">Magic 2013 (2012)</option>
                            <option value="pc2">Planechase 2012 (2012)</option>
                            <option value="avr">Avacyn Restored (2012)</option>
                            <option value="ddi">Duel Decks: Venser vs. Koth (2012)</option>
                            <option value="dka">Dark Ascension (2012)</option>
                            <option value="pd3">Premium Deck Series: Graveborn (2011)</option>
                            <option value="isd">Innistrad (2011)</option>
                            <option value="ddh">Duel Decks: Ajani vs. Nicol Bolas (2011)</option>
                            <option value="v11">From the Vault: Legends (2011)</option>
                            <option value="m12">Magic 2012 (2011)</option>
                            <option value="cmd">Commander 2011 (2011)</option>
                            <option value="td2">Duel Decks: Mirrodin Pure vs. New Phyrexia (2011)</option>
                            <option value="nph">New Phyrexia (2011)</option>
                            <option value="ddg">Duel Decks: Knights vs. Dragons (2011)</option>
                            <option value="mbs">Mirrodin Besieged (2011)</option>
                            <option value="me4">Masters Edition IV (2011)</option>
                            <option value="olgc">Legacy Championship (2011)</option>
                            <option value="pd2">Premium Deck Series: Fire and Lightning (2010)</option>
                            <option value="td0">Magic Online Theme Decks (2010)</option>
                            <option value="som">Scars of Mirrodin (2010)</option>
                            <option value="ddf">Duel Decks: Elspeth vs. Tezzeret (2010)</option>
                            <option value="v10">From the Vault: Relics (2010)</option>
                            <option value="m11">Magic 2011 (2010)</option>
                            <option value="arc">Archenemy (2010)</option>
                            <option value="dpa">Duels of the Planeswalkers (2010)</option>
                            <option value="roe">Rise of the Eldrazi (2010)</option>
                            <option value="dde">Duel Decks: Phyrexia vs. the Coalition (2010)</option>
                            <option value="wwk">Worldwake (2010)</option>
                            <option value="h09">Premium Deck Series: Slivers (2009)</option>
                            <option value="ddd">Duel Decks: Garruk vs. Liliana (2009)</option>
                            <option value="zen">Zendikar (2009)</option>
                            <option value="me3">Masters Edition III (2009)</option>
                            <option value="pc1">Planechase (2009)</option>
                            <option value="v09">From the Vault: Exiled (2009)</option>
                            <option value="m10">Magic 2010 (2009)</option>
                            <option value="arb">Alara Reborn (2009)</option>
                            <option value="ddc">Duel Decks: Divine vs. Demonic (2009)</option>
                            <option value="con">Conflux (2009)</option>
                            <option value="dd2">Duel Decks: Jace vs. Chandra (2008)</option>
                            <option value="ala">Shards of Alara (2008)</option>
                            <option value="me2">Masters Edition II (2008)</option>
                            <option value="drb">From the Vault: Dragons (2008)</option>
                            <option value="eve">Eventide (2008)</option>
                            <option value="shm">Shadowmoor (2008)</option>
                            <option value="mor">Morningtide (2008)</option>
                            <option value="evg">Duel Decks: Elves vs. Goblins (2007)</option>
                            <option value="lrw">Lorwyn (2007)</option>
                            <option value="med">Masters Edition (2007)</option>
                            <option value="10e">Tenth Edition (2007)</option>
                            <option value="fut">Future Sight (2007)</option>
                            <option value="plc">Planar Chaos (2007)</option>
                            <option value="hho">Happy Holidays (2006)</option>
                            <option value="tsp">Time Spiral (2006)</option>
                            <option value="csp">Coldsnap (2006)</option>
                            <option value="dis">Dissension (2006)</option>
                            <option value="gpt">Guildpact (2006)</option>
                            <option value="rav">Ravnica: City of Guilds (2005)</option>
                            <option value="9ed">Ninth Edition (2005)</option>
                            <option value="sok">Saviors of Kamigawa (2005)</option>
                            <option value="bok">Betrayers of Kamigawa (2005)</option>
                            <option value="unh">Unhinged (2004)</option>
                            <option value="chk">Champions of Kamigawa (2004)</option>
                            <option value="5dn">Fifth Dawn (2004)</option>
                            <option value="dst">Darksteel (2004)</option>
                            <option value="mrd">Mirrodin (2003)</option>
                            <option value="8ed">Eighth Edition (2003)</option>
                            <option value="scg">Scourge (2003)</option>
                            <option value="lgn">Legions (2003)</option>
                            <option value="ovnt">Vintage Championship (2003)</option>
                            <option value="ons">Onslaught (2002)</option>
                            <option value="jud">Judgment (2002)</option>
                            <option value="tor">Torment (2002)</option>
                            <option value="dkm">Deckmasters (2001)</option>
                            <option value="od">Odyssey (2001)</option>
                            <option value="ap">Apocalypse (2001)</option>
                            <option value="7e">Seventh Edition (2001)</option>
                            <option value="ps">Planeshift (2001)</option>
                            <option value="in">Invasion (2000)</option>
                            <option value="btd">Beatdown Box Set (2000)</option>
                            <option value="pr">Prophecy (2000)</option>
                            <option value="s00">Starter 2000 (2000)</option>
                            <option value="ne">Nemesis (2000)</option>
                            <option value="brb">Battle Royale Box Set (1999)</option>
                            <option value="mm">Mercadian Masques (1999)</option>
                            <option value="s99">Starter 1999 (1999)</option>
                            <option value="ud">Urza's Destiny (1999)</option>
                            <option value="ptk">Portal: Three Kingdoms (1999)</option>
                            <option value="6ed">Classic Sixth Edition (1999)</option>
                            <option value="ul">Urza's Legacy (1999)</option>
                            <option value="ath">Anthologies (1998)</option>
                            <option value="uz">Urza's Saga (1998)</option>
                            <option value="ugl">Unglued (1998)</option>
                            <option value="ex">Exodus (1998)</option>
                            <option value="p02">Portal: Second Age (1998)</option>
                            <option value="st">Stronghold (1998)</option>
                            <option value="te">Tempest (1997)</option>
                            <option value="wl">Weatherlight (1997)</option>
                            <option value="por">Portal (1997)</option>
                            <option value="5ed">Fifth Edition (1997)</option>
                            <option value="vi">Visions (1997)</option>
                            <option value="itp">Introductory Two-Player Set (1996)</option>
                            <option value="mgb">Multiverse Gift Box (1996)</option>
                            <option value="mi">Mirage (1996)</option>
                            <option value="rqs">Rivals Quick Start Set (1996)</option>
                            <option value="all">Alliances (1996)</option>
                            <option value="hml">Homelands (1995)</option>
                            <option value="chr">Chronicles (1995)</option>
                            <option value="ice">Ice Age (1995)</option>
                            <option value="4ed">Fourth Edition (1995)</option>
                            <option value="fem">Fallen Empires (1994)</option>
                            <option value="drk">The Dark (1994)</option>
                            <option value="sum">Summer Magic / Edgar (1994)</option>
                            <option value="leg">Legends (1994)</option>
                            <option value="3ed">Revised Edition (1994)</option>
                            <option value="atq">Antiquities (1994)</option>
                            <option value="cei">Intl. Collector's Edition (1993)</option>
                            <option value="2ed">Unlimited Edition (1993)</option>
                            <option value="ced">Collector's Edition (1993)</option>
                            <option value="arn">Arabian Nights (1993)</option>
                            <option value="leb">Limited Edition Beta (1993)</option>
                            <option value="lea">Limited Edition Alpha (1993)</option>
                        </select>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Rarity</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="common" type="checkbox" value="rarity">&nbsp;Common
                    </div>
                    <div class="col-xs-4">
                        <input name="uncommon" type="checkbox" value="rarity">&nbsp;Uncommon
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4"></div>
                    <div class="col-xs-4">
                        <input name="rare" type="checkbox" value="rarity">&nbsp;Rare
                    </div>
                    <div class="col-xs-4">
                        <input name="mythic" type="checkbox" value="rarity">&nbsp;Mythic
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Search Name</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="name" type="text">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Search Type</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="type" type="text">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Search Text</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="text" type="text">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Search Flavor Text</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="flavor" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Mana Color</p>
                    </div>
                    <div class="col-xs-8">
                        <div class="col-xs-2" title="White Mana" id="white-mana" onclick="selectMana('white-mana', 0);"></div>
                        <div class="col-xs-2" title="Blue Mana" id="blue-mana" onclick="selectMana('blue-mana', 1);"></div>
                        <div class="col-xs-2" title="Black Mana" id="black-mana" onclick="selectMana('black-mana', 2);"></div>
                        <div class="col-xs-2" title="Red Mana" id="red-mana" onclick="selectMana('red-mana', 3);"></div>
                        <div class="col-xs-2" title="Green Mana" id="green-mana" onclick="selectMana('green-mana', 4);"></div>
                        <div class="col-xs-2" title="Colorless Mana" id="colorless-mana" onclick="selectMana('colorless-mana', 5);"></div>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                    </div>
                    <div class="col-xs-4">
                        <input name="mana_inclusion" type="radio" value="exc" checked> Match All Selected Colors
                    </div>
                    <div class="col-xs-4">
                        <input name="mana_inclusion" type="radio" value="inc"> Match Any Combination
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Also Match Unselected Colors</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="selective" type="radio" value="inc" checked> Yes
                    </div>
                    <div class="col-xs-4">
                        <input name="selective" type="radio" value="exc"> No
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Minimum Mana Cost</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" class="input-number" name="min_cmc" type="number">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Maximum Mana Cost</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" class="input-number" name="max_cmc" type="number">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Minimum Power</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" class="input-number" name="min_power" type="number"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Maximum Power</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" class="input-number" name="max_power" type="number"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Minimum Toughness</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" class="input-number" name="min_toughness" type="number"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Maximum Toughness</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field-alt" class="input-number" name="max_toughness" type="number">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Card Artist</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="artist" type="text"><br><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Year</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="year" type="text"><br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <button title="Search Cards" id="form-submit" type="submit"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Cards</button><br><br><br>
                    </div>
                </div>
            </form><br>
        </div>
        <div class="hidden-xs hidden-sm col-md-1" style="border-right: 1px solid white;position: relative;right: 20px;height: 220%;"></div>
        <div class="col-xs-12 col-md-5">
            <h3>Decks<hr></h3>
            <form id="searchDecksForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="decks">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order By</p>
                    </div>
                    <div class="col-xs-8">
                        <select name="order_by" id="input-field">
                            <option value="name">Name</option>
                            <option value="user">Creator (Username)</option>
                        </select>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Inclusion</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="exc" checked> Exclusive ("AND")
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="inc"> Inclusive ("OR")
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Deck Title</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="name" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Creator (Username)</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="user" type="text"><br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <button title="Search Decks" id="form-submit" type="submit"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Decks</button>
                    </div>
                </div>
            </form><br>
            <h3>Collections<hr></h3>
            <form id="searchCollectionsForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="collections">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order By</p>
                    </div>
                    <div class="col-xs-8">
                        <select name="order_by" id="input-field">
                            <option value="name">Name</option>
                            <option value="user">User</option>
                        </select>
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Inclusion</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="exc" checked> Exclusive ("AND")
                    </div>
                    <div class="col-xs-4">
                        <input name="inclusion" type="radio" value="inc"> Inclusive ("OR")
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Collection Title</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="name" type="text">
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Creator (Username)</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="user" type="text"><br><br>
                    </div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <button title="Search Collections" id="form-submit" type="submit"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Collections</button>
                    </div>
                </div>
            </form><br>
            <h3>Users<hr></h3>
            <form id="searchUsersForm" action="SearchServlet" method="POST">
                <input type="hidden" name="action" value="users">
                <input type="hidden" name="username" value="<%=username%>">
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order</p>
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="asc" checked> Ascending&nbsp;&nbsp;
                    </div>
                    <div class="col-xs-4">
                        <input name="order" type="radio" value="dsc" > Descending
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Order By</p>
                    </div>
                    <div class="col-xs-8">
                        <select name="order_by" id="input-field">
                            <option value="username">Username</option>
                            <option value="name">Name</option>
                        </select>
                    </div>
                    <div class="col-xs-12"><hr></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Name</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="name" type="text">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <p>Username</p>
                    </div>
                    <div class="col-xs-8">
                        <input id="input-field" name="user" type="text">
                    </div>
                    <div class="col-xs-12"><br></div>
                </div>
                <br>
                <div class="row">
                    <div class="hidden-xs col-md-4"></div>
                    <div class="col-xs-12 col-md-8">
                        <button title="Search Users" id="form-submit" type="submit"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;Users</button><br><br>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="js/scripts.js"></script>
<%@include file="footer.jsp"%>