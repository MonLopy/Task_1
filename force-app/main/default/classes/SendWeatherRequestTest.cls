@isTest
public with sharing class SendWeatherRequestTest {
  @TestSetup
  static void makeData() {
    Weather_Setting__c setting = new Weather_Setting__c(
      Name = 'test',
      City_name__c = 'Lviv',
      Language__c = 'en'
    );
    insert setting;
  }
  @isTest
  static void TestCreateRecord() {
    Test.startTest();
    // Schedule the test job
    String jobId = System.schedule(
      'SendWeatherRequest',
      SendWeatherRequest.CRON_EXP,
      new SendWeatherRequest()
    );
    // Verify the scheduled job has not run yet.
    List<Weather__c> lt = [SELECT Id FROM Weather__c];
    System.assertEquals(0, lt.size());
    Test.stopTest();
    System.assertEquals(0, lt.size());
  }
}
