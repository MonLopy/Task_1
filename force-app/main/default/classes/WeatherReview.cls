public with sharing class WeatherReview {
  @AuraEnabled(cacheable=true)
  public static List<Weather__c> getWeatherDataReview() {
    return [
      SELECT
        Name,
        City_name__c,
        Date__c,
        Humidity__c,
        Temperature__c,
        Temp_feels_like__c,
        Weather_description__c,
        pressure__c,
        Latitude__c,
        Longitude__c
      FROM Weather__c
    ];
  }
}