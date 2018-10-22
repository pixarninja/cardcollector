package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CardInfo implements Serializable{
    
    private static LinkedHashMap cardsByName = new LinkedHashMap();
    private static LinkedHashMap cardsById = new LinkedHashMap();
    private Connection connection;
    
    private String id;
    private String game;
    private String name;
    private String set_name;
    private String set_id;
    private String rarity;
    private String front;
    private String back;
    private String mc;
    private float cmc;
    private String colors;
    private String type;
    private String text;
    private String flavor;
    private String power;
    private String toughness;
    private String loyalty;
    private String revMc;
    private String revColors;
    private String revName;
    private String revType;
    private String revText;
    private String revFlavor;
    private String revPower;
    private String revToughness;
    private String revLoyalty;
    private String artist;
    private String year;
    private int multiverse;
    private String legalities;
    private String kingdom;
    private String usd;
    private Boolean digital;
    
    public CardInfo() {
        try {
            cardsByName = new LinkedHashMap();
            cardsById = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table1 + "`");
            while(rs.next()) {
                String id = rs.getString("id");
                String game = rs.getString("game");
                String name = rs.getString("name");
                String set_name = rs.getString("set_name");
                String set_id = rs.getString("set_id");
                String rarity = rs.getString("rarity");
                String front = rs.getString("front");
                String back = rs.getString("back");
                String mc = rs.getString("mc");
                float cmc = rs.getFloat("cmc");
                String colors = rs.getString("colors");
                String type = rs.getString("type");
                String text = rs.getString("text");
                String flavor = rs.getString("flavor");
                String power = rs.getString("power");
                String toughness = rs.getString("toughness");
                String loyalty = rs.getString("loyalty");
                String revMc = rs.getString("rev_mc");
                String revColors = rs.getString("rev_colors");
                String revName = rs.getString("rev_name");
                String revType = rs.getString("rev_type");
                String revText = rs.getString("rev_text");
                String revFlavor = rs.getString("rev_flavor");
                String revPower = rs.getString("rev_power");
                String revToughness = rs.getString("rev_toughness");
                String revLoyalty = rs.getString("rev_loyalty");
                String artist = rs.getString("artist");
                String year = rs.getString("year");
                int multiverse = rs.getInt("multiverse");
                String legalities = rs.getString("legalities");
                String kingdom = rs.getString("kingdom");
                String usd = rs.getString("usd");
                Boolean digital = false;
                if(rs.getInt("digital") == 1) {
                    digital = true;
                }
                
                cardsByName.put(name, new CardInfo(id, game, name, set_name, set_id, rarity, front, back, mc, cmc, colors, type, text, flavor, power, toughness, loyalty, revMc, revColors, revName, revType, revText, revFlavor, revPower, revToughness, revLoyalty, artist, year, multiverse, legalities, kingdom, usd, digital));
                cardsById.put(id, new CardInfo(id, game, name, set_name, set_id, rarity, front, back, mc, cmc, colors, type, text, flavor, power, toughness, loyalty, revMc, revColors, revName, revType, revText, revFlavor, revPower, revToughness, revLoyalty, artist, year, multiverse, legalities, kingdom, usd, digital));
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CardInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CardInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CardInfo(String id, String game, String name, String set_name, String set_id, String rarity, String front, String back, String mc, float cmc, String colors, String type, String text, String flavor, String power, String toughness, String loyalty, String revMc, String revColors, String revName, String revType, String revText, String revFlavor, String revPower, String revToughness, String revLoyalty, String artist, String year, int multiverse, String legalities, String kingdom, String usd, Boolean digital) {
        this.id = id;
        this.game = game;
        this.name = name;
        this.set_name = set_name;
        this.set_id = set_id;
        this.rarity = rarity;
        this.front = front;
        this.back = back;
        this.mc = mc;
        this.cmc = cmc;
        this.colors = colors;
        this.type = type;
        this.text = text;
        this.flavor = flavor;
        this.power = power;
        this.toughness = toughness;
        this.loyalty = loyalty;
        this.revMc = revMc;
        this.revColors = revColors;
        this.revName = revName;
        this.revType = revType;
        this.revText = revText;
        this.revFlavor = revFlavor;
        this.revPower = revPower;
        this.revToughness = revToughness;
        this.revLoyalty = revLoyalty;
        this.artist = artist;
        this.year = year;
        this.multiverse = multiverse;
        this.legalities = legalities;
        this.kingdom = kingdom;
        this.usd = usd;
        this.digital = digital;
    }
    
    public static String printCards() {
        String s = "";
        Iterator it = cardsById.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry pair = (Map.Entry)it.next();
            s = s + pair.getKey() + ": " + pair.getValue() + "\n";
            it.remove();
        }
        return s;
    }
    
    public static CardInfo getCardByName(String name) {
        return ((CardInfo)cardsByName.get(name));
    }
    
    public static CardInfo getCardById(String id) {
        return ((CardInfo)cardsById.get(id));
    }
    
    public String getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public String getGame() {
        return game;
    }
    
    public String getSetName() {
        return set_name;
    }
    
    public String getSetId() {
        return set_id;
    }
    
    public String getRarity() {
        return rarity;
    }
    
    public String getFront() {
        return front;
    }
    
    public String getBack() {
        return back;
    }
    
    public String getManaCost() {
        return mc;
    }
    
    public float getConvertedManaCost() {
        return cmc;
    }
    
    public String getColors() {
        return colors;
    }
    
    public String getType() {
        return type;
    }
    
    public String getText() {
        return text;
    }
    
    public String getFlavor() {
        return flavor;
    }
    
    public String getPower() {
        return power;
    }
    
    public String getToughness() {
        return toughness;
    }
    
    public String getLoyalty() {
        return loyalty;
    }
    
    public String getRevManaCost() {
        return revMc;
    }
    
    public String getRevColors() {
        return revColors;
    }
    
    public String getRevName() {
        return revName;
    }
    
    public String getRevType() {
        return revType;
    }
    
    public String getRevText() {
        return revText;
    }
    
    public String getRevFlavor() {
        return revFlavor;
    }
    
    public String getRevPower() {
        return revPower;
    }
    
    public String getRevToughness() {
        return revToughness;
    }
    
    public String getRevLoyalty() {
        return revLoyalty;
    }
    
    public String getArtist() {
        return artist;
    }
    
    public String getYear() {
        return year;
    }
    
    public int getMultiverse() {
        return multiverse;
    }
    
    public String getLegalities() {
        return legalities;
    }
    
    public String getKingdom() {
        return kingdom;
    }
    
    public String getUsd() {
        return usd;
    }
    
    public Boolean getDigital() {
        return digital;
    }
    
}
