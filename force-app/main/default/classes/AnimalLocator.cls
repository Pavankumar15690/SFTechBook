public class AnimalLocator {
    public static String getAnimalNameById(Integer x){
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' +x);
        req.setMethod('GET');
        Map<String, Object> animal = new Map<String, Object>();
        // Send the request, and return a response
        HTTPResponse res = http.send(req);
        if(res.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            animal = (Map<String, Object>) results.get('animal');
        }
        return (String)animal.get('name');        
    }
}