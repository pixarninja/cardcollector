package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CardInfo implements Serializable{
    
    private static LinkedHashMap cardsById = new LinkedHashMap();
    private static LinkedHashMap cardsByNum = new LinkedHashMap();
    private Connection connection;
    
    private String id;
    private String name;
    private String set_name;
    private String legalities;
    private String frontURI;
    private String backURI;
    
    public CardInfo() {
        try {
            cardsById = new LinkedHashMap();
            cardsByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            int num = 1;
            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table1 + "` ORDER BY viewed DESC");
            while(rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");
                String set_name = rs.getString("set_name");
                String legalities = rs.getString("legalities");
                String frontURI = rs.getString("frontURI");
                String backURI = rs.getString("backURI");
                
                cardsById.put(id, new CardInfo(id, name, set_name, legalities, frontURI, backURI));
                cardsByNum.put(num, new CardInfo(id, name, set_name, legalities, frontURI, backURI));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CardInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CardInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CardInfo(String id, String name, String set_name, String legalities, String frontURI, String backURI) {
        this.id = id;
        this.name = name;
        this.set_name = set_name;
        this.legalities = legalities;
        this.frontURI = frontURI;
        this.backURI = backURI;
    }
    
    public static CardInfo getCardById(String id) {
        return ((CardInfo)cardsById.get(id));
    }
    
    public static CardInfo getCardByNum(int num) {
        return ((CardInfo)cardsByNum.get(num));
    }
    
    public String getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public String getSetName() {
        return set_name;
    }
    
    public String getLegalities() {
        return legalities;
    }
    
    public String[] getImageURLs() {
        HashMap<Object,Object> frontMap;
        HashMap<Object,Object> backMap;
        try {
            frontMap = resource.ScryfallScraper.TranslateImageURI(frontURI);
        } catch(Exception ex) {
            frontMap = null;
        }
        try {
            backMap = resource.ScryfallScraper.TranslateImageURI(backURI);
        } catch(Exception ex) {
            backMap = null;
        }
        return resource.ScryfallScraper.ParseImageURIs(frontMap, backMap);
    }
    
}
