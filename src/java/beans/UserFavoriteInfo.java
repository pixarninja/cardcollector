package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserFavoriteInfo implements Serializable{
    
    private static LinkedHashMap favoritesById = new LinkedHashMap();
    private static LinkedHashMap favoritesByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String userId;
    private String user;
    
    public UserFavoriteInfo() {
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

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table17 + "`");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String userId = rs.getString("user_id");
                String user = rs.getString("user");
                
                favoritesById.put(id, new UserFavoriteInfo(id, userId, user));
                favoritesByNum.put(num, new UserFavoriteInfo(id, userId, user));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserFavoriteInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public UserFavoriteInfo(int id, String userId, String user) {
        this.id = id;
        this.userId = userId;
        this.user = user;
    }
    
    public static UserFavoriteInfo getFavoriteById(int id) {
        return ((UserFavoriteInfo)favoritesById.get(id));
    }
    
    public static UserFavoriteInfo getFavoriteByNum(int num) {
        return ((UserFavoriteInfo)favoritesByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public String getUser() {
        return user;
    }
    
}
