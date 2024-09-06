package com.openfaas.function;

import com.openfaas.model.IHandler;
import com.openfaas.model.IResponse;
import com.openfaas.model.IRequest;
import com.openfaas.model.Response;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Handler extends com.openfaas.model.AbstractHandler {

    public IResponse Handle(IRequest req) {
        Response res = new Response();

        Map<String, String> finalMap = new HashMap<>();
        Map<String, String> jsonMap = new HashMap();
        String jsonString = "";
        String output = "";
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(req.getBody());
            Iterator<Map.Entry<String, JsonNode>> iterator = root.fields();

            while (iterator.hasNext()) {
                Map.Entry<String, JsonNode> elem = iterator.next();
                jsonMap.put(elem.getKey(), elem.getValue().asText());
            }
            
            jsonString = mapper.writeValueAsString(jsonMap);

            finalMap.put("data", jsonString);
            finalMap.put("n. elem", String.valueOf(root.size()));
            finalMap.put("bytes", String.valueOf(jsonString.getBytes().length));

            output = mapper.writeValueAsString(finalMap);
        } catch (JsonProcessingException e) {

            throw new RuntimeException(e);

        }

        res.setBody(output);

	    return res;
    }
}
