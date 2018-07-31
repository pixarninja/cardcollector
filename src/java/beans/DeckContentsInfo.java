package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeckContentsInfo implements Serializable{
    
    private static LinkedHashMap contentsById = new LinkedHashMap();
    private static LinkedHashMap contentsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int deckId;
    private String cardId;
    private int cardTotal;
    
    public DeckContentsInfo() {
        try {
            contentsById = new LinkedHashMap();
            contentsByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table13 + "` ORDER BY card_total ASC");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int deckId = rs.getInt("deck_id");
                String cardId = rs.getString("card_id");
                int cardTotal = rs.getInt("card_total");
                
                contentsById.put(id, new DeckContentsInfo(id, deckId, cardId, cardTotal));
                contentsByNum.put(num, new DeckContentsInfo(id, deckId, cardId, cardTotal));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeckContentsInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DeckContentsInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DeckContentsInfo(int id, int deckId, String cardId, int cardTotal) {
        this.id = id;
        this.deckId = deckId;
        this.cardId = cardId;
        this.cardTotal = cardTotal;
    }
    
    public static DeckContentsInfo getContentsById(int id) {
        return ((DeckContentsInfo)contentsById.get(id));
    }
    
    public static DeckContentsInfo getContentsByNum(int num) {
        return ((DeckContentsInfo)contentsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getDeckId() {
        return deckId;
    }
    
    public String getCardId() {
        return cardId;
    }
    
    public int getCardTotal() {
        return cardTotal;
    }
    
}
