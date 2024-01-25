public with sharing class AnimalLocator {
    public static String getAnimalNameById(Integer id) {
        String result;
        String url = 'https://th-apex-http-callout.herokuapp.com/animals/' + String.valueOf(id);
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> bodyResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> animal = (Map<String, Object>) bodyResult.get('animal');
            result = (String) animal.get('name');
        }
        return result;
    }
}