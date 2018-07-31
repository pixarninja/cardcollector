package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CollectionContentsInfo implements Serializable{
    
    private static LinkedHashMap contentsById = new LinkedHashMap();
    private static LinkedHashMap contentsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int collectionId;
    private String cardId;
    private int cardTotal;
    
    public CollectionContentsInfo() {
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

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table8 + "` ORDER BY card_total ASC");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int collectionId = rs.getInt("collection_id");
                String cardId = rs.getString("card_id");
                int cardTotal = rs.getInt("card_total");
                
                contentsById.put(id, new CollectionContentsInfo(id, collectionId, cardId, cardTotal));
                contentsByNum.put(num, new CollectionContentsInfo(id, collectionId, cardId, cardTotal));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CollectionContentsInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CollectionContentsInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CollectionContentsInfo(int id, int collectionId, String cardId, int cardTotal) {
        this.id = id;
        this.collectionId = collectionId;
        this.cardId = cardId;
        this.cardTotal = cardTotal;
    }
    
    public static CollectionContentsInfo getContentsById(int id) {
        return ((CollectionContentsInfo)contentsById.get(id));
    }
    
    public static CollectionContentsInfo getContentsByNum(int num) {
        return ((CollectionContentsInfo)contentsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getCollectionId() {
        return collectionId;
    }
    
    public String getCardId() {
        return cardId;
    }
    
    public int getCardTotal() {
        return cardTotal;
    }
    
}
