package functions;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.messaging.Message;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.function.Function;

@SpringBootApplication
public class JavaFunction {

    public static void main(String[] args) {
        SpringApplication.run(JavaFunction.class, args);
    }

    @Bean
    public Function<Message<String>, String> handler() {
        final ObjectMapper mapper = new ObjectMapper();

        return (inputMessage) -> {
            final String body = inputMessage.getPayload();

            final Map<String, String> finalMap = new HashMap<>();
            final Map<String, String> jsonMap = new HashMap<>();
            String jsonString = "";
            String output = "";

            if (body != null && (!body.isBlank())) {
                try {
                    JsonNode root = mapper.readTree(body);
                    Iterator<Map.Entry<String, JsonNode>> iterator = root.fields();

                    while (iterator.hasNext()) {
                        Map.Entry<String, JsonNode> elem = iterator.next();
                        jsonMap.put(elem.getKey(), elem.getValue().asText());
                    }
                    
                    jsonString = mapper.writeValueAsString(jsonMap);
                    jsonString = mapper.writeValueAsString(root);

                    finalMap.put("data", jsonString);
                    finalMap.put("n. elem", String.valueOf(root.size()));
                    finalMap.put("bytes", String.valueOf(jsonString.getBytes().length));

                    output = mapper.writeValueAsString(finalMap);
                } catch (final JsonProcessingException e){
                    output = "Invalid JSON content.";
                    e.printStackTrace();
                }
            }

            return output;
        };
    }
}
