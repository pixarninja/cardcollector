package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DeckFavoriteInfo implements Serializable{
    
    private static LinkedHashMap favoritesById = new LinkedHashMap();
    private static LinkedHashMap favoritesByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int deckId;
    private String user;
    
    public DeckFavoriteInfo() {
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

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table14 + "`");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int deckId = rs.getInt("deck_id");
                String user = rs.getString("user");
                
                favoritesById.put(id, new DeckFavoriteInfo(id, deckId, user));
                favoritesByNum.put(num, new DeckFavoriteInfo(id, deckId, user));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeckFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DeckFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public DeckFavoriteInfo(int id, int deckId, String user) {
        this.id = id;
        this.deckId = deckId;
        this.user = user;
    }
    
    public static DeckFavoriteInfo getFavoriteById(int id) {
        return ((DeckFavoriteInfo)favoritesById.get(id));
    }
    
    public static DeckFavoriteInfo getFavoriteByNum(int num) {
        return ((DeckFavoriteInfo)favoritesByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getDeckId() {
        return deckId;
    }
    
    public String getUser() {
        return user;
    }
    
}
