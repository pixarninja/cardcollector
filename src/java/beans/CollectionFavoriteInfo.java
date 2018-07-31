package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CollectionFavoriteInfo implements Serializable{
    
    private static LinkedHashMap favoritesById = new LinkedHashMap();
    private static LinkedHashMap favoritesByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private int collectionId;
    private String user;
    
    public CollectionFavoriteInfo() {
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

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table9 + "`");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                int collectionId = rs.getInt("collection_id");
                String user = rs.getString("user");
                
                favoritesById.put(id, new CollectionFavoriteInfo(id, collectionId, user));
                favoritesByNum.put(num, new CollectionFavoriteInfo(id, collectionId, user));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CollectionFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CollectionFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CollectionFavoriteInfo(int id, int collectionId, String user) {
        this.id = id;
        this.collectionId = collectionId;
        this.user = user;
    }
    
    public static CollectionFavoriteInfo getFavoriteById(int id) {
        return ((CollectionFavoriteInfo)favoritesById.get(id));
    }
    
    public static CollectionFavoriteInfo getFavoriteByNum(int num) {
        return ((CollectionFavoriteInfo)favoritesByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public int getCollectionId() {
        return collectionId;
    }
    
    public String getUser() {
        return user;
    }
    
}
