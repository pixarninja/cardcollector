package resource;



import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;
import org.json.*;
import com.fasterxml.jackson.databind.ObjectMapper;

public class HttpConnection {
	
    private final String USER_AGENT = "Mozilla/5.0";
    public HttpConnection() {}
	
    public Map<Object, Object> requestObject(String url) throws IOException {
		
        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        con.setRequestProperty("User-Agent", USER_AGENT);
        int responseCode = con.getResponseCode();
        if(responseCode != 200) {
            return null;
        }
        //System.out.println("Sending 'GET' request to URL : " + url);
        //System.out.println("Response Code : " + responseCode);

        BufferedReader in = new BufferedReader(
            new InputStreamReader(con.getInputStream()));
        String output;
        StringBuffer response = new StringBuffer();

        while ((output = in.readLine()) != null) {
            response.append(output);
        }
        in.close();

        /* return response */
        @SuppressWarnings("unchecked")
        HashMap<Object,Object> result = new ObjectMapper().readValue(response.toString(), HashMap.class);
        return result;
	
    }
	
    public ArrayList<Map<String, Object>> requestList(String url) throws IOException {

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();

        con.setRequestProperty("User-Agent", USER_AGENT);
        int responseCode = con.getResponseCode();
        System.out.println("Sending 'GET' request to URL : " + url);
        System.out.println("Response Code : " + responseCode);

        BufferedReader in = new BufferedReader(
            new InputStreamReader(con.getInputStream()));
        String output;
        StringBuffer response = new StringBuffer();

        while ((output = in.readLine()) != null) {
            response.append(output);
        }
        in.close();

        /* return response */
        ArrayList<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        String[] parsedResponse = (response.substring(42)).split("},");
        System.out.println(parsedResponse.length);

        for(String s : parsedResponse) {
            String test = s + "}";
            @SuppressWarnings("unchecked")
            HashMap<String, Object> item = new ObjectMapper().readValue(test, HashMap.class);
            list.add(item);
            System.out.println("Added: " + item);
        }

        return list;
    }

}