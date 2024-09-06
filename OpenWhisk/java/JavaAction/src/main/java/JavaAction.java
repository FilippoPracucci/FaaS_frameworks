package main.java;

import com.google.gson.*;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class JavaAction {
    public static JsonObject main(JsonObject args) {
        JsonObject response = new JsonObject();

        Gson gson = new Gson();

        Iterator<Map.Entry<String, JsonElement>> iterator = args.entrySet().iterator();
        Map<String, String> jsonMap = new HashMap();

        while (iterator.hasNext()) {
            Map.Entry<String, JsonElement> elem = iterator.next();
            jsonMap.put(elem.getKey(), elem.getValue().getAsString());
        }

        String jsonString = gson.toJson(jsonMap);

        response.addProperty("data", jsonString);
        response.addProperty("n. elem", String.valueOf(jsonMap.size()));
        response.addProperty("bytes", String.valueOf(jsonString.getBytes().length));
    
        return response;
    }
}