package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CardFavoriteInfo implements Serializable{
    
    private static LinkedHashMap favoritesById = new LinkedHashMap();
    private static LinkedHashMap favoritesByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String cardId;
    private String user;
    
    public CardFavoriteInfo() {
        try {
            favoritesById = new LinkedHashMap();
            favoritesByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table4 + "`");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String cardId = rs.getString("card_id");
                String user = rs.getString("user");
                
                favoritesById.put(id, new CardFavoriteInfo(id, cardId, user));
                favoritesByNum.put(num, new CardFavoriteInfo(id, cardId, user));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CardFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CardFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CardFavoriteInfo(int id, String cardId, String user) {
        this.id = id;
        this.cardId = cardId;
        this.user = user;
    }
    
    public static CardFavoriteInfo getFavoriteById(String id) {
        return ((CardFavoriteInfo)favoritesById.get(id));
    }
    
    public static CardFavoriteInfo getFavoriteByNum(int num) {
        return ((CardFavoriteInfo)favoritesByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public String getCardId() {
        return cardId;
    }
    
    public String getUser() {
        return user;
    }
    
}
