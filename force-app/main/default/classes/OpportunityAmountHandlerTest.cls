@isTest
public class OpportunityAmountHandlerTest {
  @isTest
  public static void highAccoutPriorityTest() {
    Account testAcc = new Account(Name = 'testAcc');
    insert testAcc;
    List<Opportunity> testOpp = [
      SELECT AccountId, Amount
      FROM Opportunity
      WHERE AccountId = :testAcc.Id
    ];
    for (Opportunity o : testOpp) {
      o.Amount = 50000000;
      Test.startTest();
      Database.update(testOpp, false);
      Test.stopTest();

      Account TrigeredAcc = [
        SELECT Priority__c
        FROM Account
        WHERE Id = :o.AccountId
      ];
      System.assertEquals('high', TrigeredAcc.Priority__c);
    }
  }
  public static void lowAccoutPriorityTest() {
    Account testAcc = new Account(Name = 'testAcc');
    insert testAcc;
    List<Opportunity> testOpp = [
      SELECT AccountId, Amount
      FROM Opportunity
      WHERE AccountId = :testAcc.Id
    ];
    for (Opportunity o : testOpp) {
      o.Amount = 500;
      Test.startTest();
      Database.update(testOpp, false);
      Test.stopTest();

      Account TrigeredAcc = [
        SELECT Priority__c
        FROM Account
        WHERE Id = :o.AccountId
      ];
      System.assertEquals('low', TrigeredAcc.Priority__c);
    }
  }
}
