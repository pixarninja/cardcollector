package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CollectionInfo implements Serializable{
    
    private static LinkedHashMap collectionsById = new LinkedHashMap();
    private static LinkedHashMap collectionsByNum = new LinkedHashMap();
    private Connection connection;
    
    private int id;
    private String name;
    private String user;
    private String top;
    private String middle;
    private String bottom;
    private int entries;
    private int total;
    private java.util.Date dateUpdated;
    private String description;
    
    public CollectionInfo() {
        try {
            collectionsById = new LinkedHashMap();
            collectionsByNum = new LinkedHashMap();
            String driver = secure.DBConnection.driver;
            Class.forName(driver);
            String dbURL = secure.DBConnection.dbURL;
            String username = secure.DBConnection.username;
            String password = secure.DBConnection.password;
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `" + secure.DBStructure.table5 + "` ORDER BY name ASC");
            int num = 1;
            while(rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String user = rs.getString("user");
                String top = rs.getString("top");
                String middle = rs.getString("middle");
                String bottom = rs.getString("bottom");
                int entries = rs.getInt("entries");
                int total = rs.getInt("total");
                java.util.Date dateUpdated = rs.getDate("date_updated");
                String description = rs.getString("description");
                
                collectionsById.put(id, new CollectionInfo(id, name, user, top, middle, bottom, entries, total, dateUpdated, description));
                collectionsByNum.put(num, new CollectionInfo(id, name, user, top, middle, bottom, entries, total, dateUpdated, description));
                num++;
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CollectionInfo.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CollectionInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public CollectionInfo(int id, String name, String user, String top, String middle, String bottom, int entries, int total, java.util.Date dateUpdated, String description) {
        this.id = id;
        this.name = name;
        this.user = user;
        this.top = top;
        this.middle = middle;
        this.bottom = bottom;
        this.entries = entries;
        this.total = total;
        this.dateUpdated = dateUpdated;
        this.description = description;
    }
    
    public static CollectionInfo getCollectionById(int id) {
        return ((CollectionInfo)collectionsById.get(id));
    }
    
    public static CollectionInfo getCollectionByNum(int num) {
        return ((CollectionInfo)collectionsByNum.get(num));
    }
    
    public int getId() {
        return id;
    }
    
    public String getName() {
        return name;
    }
    
    public String getUser() {
        return user;
    }
    
    public String getTop() {
        return top;
    }
    
    public String getMiddle() {
        return middle;
    }
    
    public String getBottom() {
        return bottom;
    }
    
    public int getEntries() {
        return entries;
    }
    
    public int getTotal() {
        return total;
    }
    
    public java.util.Date getDateUpdated() {
        return dateUpdated;
    }
    
    public String getDescription() {
        return description;
    }
    
}
