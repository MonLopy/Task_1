global class SendWeatherRequest implements Schedulable {
  public static String CRON_EXP = '0 0 10 * * ?';
  static final String API_KEY = '399fff2a85811608c3de584ecda87438';
  global void execute(SchedulableContext ctx) {
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    Weather_Setting__c setting = [
      SELECT City_name__c, Language__c
      FROM Weather_Setting__c
      LIMIT 1
    ];
    request.setEndpoint(
      'https://api.openweathermap.org/data/2.5/weather?q=' +
      setting.city_name__c +
      '&lang=' +
      setting.language__c +
      '&appid=' +
      API_KEY
    );
    request.setMethod('GET');
    HttpResponse response;
    if (Test.isRunningTest()) {
      response = new HttpResponse();
      response.setBody(
        '{"coord":{"lon":24.0232,"lat":49.8383},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":283.39,"feels_like":281.7,"temp_min":283.18,"temp_max":283.44,"pressure":1020,"humidity":47},"visibility":10000,"wind":{"speed":4,"deg":130},"clouds":{"all":0},"dt":1633945739,"sys":{"type":1,"id":8909,"country":"UA","sunrise":1633927142,"sunset":1633966915},"timezone":10800,"id":702550,"name":"Lviv","cod":200}'
      );
      response.setStatusCode(200);
    } else {
      response = http.send(request);
    }

    if (response.getStatusCode() == 200) {
      Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(
        response.getBody()
      );
      Map<String, Object> coord = (Map<String, Object>) results.get('coord');
      Double parse_lon = Double.valueOf(coord.get('lon'));
      Double parse_lat = Double.valueOf(coord.get('lat'));
      List<Object> weatherlist = (List<Object>) results.get('weather');
      Map<String, Object> weather = (Map<String, Object>) weatherlist[0];
      String parse_description = String.valueOf(weather.get('description'));
      Map<String, Object> main = (Map<String, Object>) results.get('main');
      Double parse_temperature = Double.valueOf(main.get('temp')) - 273.15;
      Double parse_temp_feels_like = Double.valueOf(main.get('feels_like')) - 273.15;
      Double parse_pressure = Double.valueOf(main.get('pressure'));
      Double parse_humidity = Double.valueOf(main.get('humidity'));
      Map<String, Object> wind = (Map<String, Object>) results.get('wind');
      Double parse_wind_speed = Double.valueOf(wind.get('speed'));
      Date dat = Date.valueOf(System.now());

      Weather__c weatherToInsert = new Weather__c(
        Name = setting.city_name__c + String.valueOf(dat),
        city_name__c = setting.city_name__c,
        weather_description__c = parse_description,
        temperature__c = parse_temperature,
        temp_feels_like__c = parse_temp_feels_like,
        pressure__c = parse_pressure,
        humidity__c = parse_humidity,
        wind_speed__c = parse_wind_speed,
        latitude__c = parse_lat,
        longitude__c = parse_lon,
        date__c = dat
      );
      insert weatherToInsert;
    } else {
      System.debug('Error');
    }
  }
}
