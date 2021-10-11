@isTest
public with sharing class WeatherReviewTest {
    @TestSetup
    static void makeData(){
        List<Weather__c>  weather = new List<Weather__c>();
        weather.add(
            new Weather__c(Name='Test',City_name__c='Lviv'));
        insert weather;
        List<Weather_Setting__c>  setting = new List<Weather_Setting__c>();
        setting.add( new Weather_Setting__c(City_name__c='Lviv',Language__c='en'));
        insert setting;
    }
    @isTest
    public static void WeatherReviewTest() {
        Integer i = [SELECT COUNT() FROM Weather__c WHERE Name LIKE 'Test'];
        Integer j = [SELECT COUNT() FROM Weather_Setting__c WHERE City_Name__c LIKE 'Lviv'];
        System.assertEquals(1, i);
        System.assertEquals(1, j);

    }
}
