public with sharing class WeatherData {
  public static HttpResponse getWeather() {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint(
      'api.openweathermap.org/data/2.5/weather?q=Lviv&appid=399fff2a85811608c3de584ecda87438'
    );
    request.setMethod('GET');
    HttpResponse response = new HttpResponse();
    System.debug(response);
    return response;
  }
}
