@isTest
public class TestBatchApex {
  @TestSetup
  static void setup() {
    List<Lead> ld = new List<Lead>();
    for (Integer i = 0; i <= 2; i++) {
      ld.add(
        new Lead(
          FirstName = 'Lead' + i,
          LastName = 'Last',
          Status = 'Closed - Not Converted',
          LeadSource = 'Web',
          Email = 'mamchak1805@gmail.com',
          Company = 'Test' + 1,
          Interested_Product__c='Cloud'
        )
      );
    }
    ld.add(
      new Lead(
        FirstName = 'Lead' + 3,
        LastName = 'Last',
        Status = 'Closed Won',
        LeadSource = 'Web',
        Email = 'mamchak1805@gmail.com',
        Company = 'Test' + 1,
        Interested_Product__c='Cloud'
      )
    );
    insert ld;
  }
  @isTest
  static void test() {
    Test.startTest();
    ColdLead cl = new ColdLead();
    Id batchId = Database.executeBatch(cl);
    Test.stopTest();
    System.assertEquals(
      1,
      [SELECT COUNT() FROM Lead WHERE State != 'Closed - Not Converted']
    );
  }
}
