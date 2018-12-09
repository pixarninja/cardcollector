package resource;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

public class ScryfallScraper {
    
    public static Object[] ScrapeImageURIs(int scryId, String setId) throws IOException {
        Object[] imageURIs = new Object[2];
        HttpConnection http = new HttpConnection();
        
        Map<Object, Object> m = http.requestObject("https://api.scryfall.com/sets/" + setId);
        if(!((m.get("mtgo_code") != null || m.get("code") != null) && m.get("card_count") != null)) {
            System.out.println("Set " + setId + "  was NULL!");
            return null;
        }
        
        Map<Object, Object> card = null;

        String code = "";
        if(m.get("mtgo_code") != null) {
            code = (String)m.get("mtgo_code");
        }

        card = http.requestObject("https://api.scryfall.com/cards/" + code + "/" + scryId);

        if(card == null) {
            System.out.println("FAILED AT " + "https://api.scryfall.com/cards/" + code + "/" + scryId);

            if(m.get("code") != null) {
                code = (String)m.get("code");
            }
            /* NULL case */
            else {
                System.out.println("NULL CODE! https://api.scryfall.com/cards/" + code + "/" + scryId + " IS NULL!");
                return null;
            }

            /* try again */
            card = http.requestObject("https://api.scryfall.com/cards/" + code + "/" + scryId);

            /* NULL case */
            if(card == null) {
                System.out.println("https://api.scryfall.com/cards/" + code + "/" + scryId + " IS NULL!");
                return null;
            }
        }

        if(card.get("card_faces") != null) {

            String USER_AGENT = "Mozilla/5.0";
            URL obj = new URL("https://api.scryfall.com/cards/" + setId + "/" + scryId);
            HttpURLConnection con = (HttpURLConnection) obj.openConnection();

            con.setRequestProperty("User-Agent", USER_AGENT);
            System.out.println("Requesting information to process...");

            BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()));
            String output;
            StringBuffer response = new StringBuffer();

            while ((output = in.readLine()) != null) {
                response.append(output);
            }
            in.close();

            String[] buff = response.toString().split("\"object\":\"card_face\",");

            if(buff.length == 3) {
                String first = "{" + buff[1];
                String second = "{" + buff[2].substring(0, buff[2].length() - 2);
                @SuppressWarnings("unchecked")
                HashMap<Object,Object> cardA = new ObjectMapper().readValue(first, HashMap.class);
                @SuppressWarnings("unchecked")
                HashMap<Object,Object> cardB = new ObjectMapper().readValue(second, HashMap.class);

                /* cardA */
                if(cardA.get("image_uris") != null) {

                    imageURIs[0] = cardA.get("image_uris");

                }
                /* else try to get the parent uri */
                else {
                    if(card.get("image_uris") != null) {

                        imageURIs[0] = card.get("image_uris");

                    }
                }

                /* cardB */
                if(cardB.get("image_uris") != null) {

                    imageURIs[1] = cardB.get("image_uris");

                }
            }
        }
        else {
            if(card.get("image_uris") != null) {

                imageURIs[0] = card.get("image_uris");

            }
        }
        
        return imageURIs;
    }
    
    public static HashMap<Object, Object> TranslateImageURI(String imageURI) throws IOException {
        String[] parsed = imageURI.split("=");
        String built = parsed[0];
        built = built.charAt(0) + "\"" + built.substring(1);
        int index;
        for(index = 1; index < parsed.length; index++) {
            built += "\" : \"" + parsed[index];
        }

        parsed = built.split(", ");
        built = parsed[0];
        for(index = 1; index < parsed.length; index++) {
            built += "\", \"" + parsed[index];
        }

        imageURI = built.substring(0, built.length() - 2) + "\"}";
        System.out.println(imageURI);

        @SuppressWarnings("unchecked")
        HashMap<Object,Object> images = new ObjectMapper().readValue(imageURI, HashMap.class);
        return images;
    }
    
    public static String[] ParseImageURIs(HashMap<Object, Object> frontURI, HashMap<Object, Object> backURI) {
        String[] pair = new String[2];
        String front = null;
        String back = null;
        if(frontURI != null) {

            front = (String)frontURI.get("normal");
            if(front == null) {
                front = (String)frontURI.get("small");
            }

        }
        
        if(backURI != null) {

            back = (String)backURI.get("normal");
            if(back == null) {
                back = (String)backURI.get("small");
            }

        }
        
        pair[0] = front;
        pair[1] = back;
        
        return pair;
    }

}