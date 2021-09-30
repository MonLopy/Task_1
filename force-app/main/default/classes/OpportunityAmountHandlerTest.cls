@isTest
public class OpportunityAmountHandlerTest {
  @isTest
  public static void highAccoutPriorityTest() {
    Account testAcc = new Account(Name = 'testAcc');
    insert testAcc;
    Opportunity opp = new Opportunity(AccountId=testAcc.Id,Name='testOpp', Amount=5000000, CloseDate= Date.newInstance(2022, 2, 17),StageName='Prospecting');
    insert opp;
      Test.startTest();
      Database.insert(opp, false);
      Test.stopTest();

      Account TrigeredAcc = [
        SELECT Priority__c
        FROM Account
        WHERE Id = :opp.AccountId
      ];
      System.assertEquals('high', TrigeredAcc.Priority__c);
    }
  @isTest
  public static void lowAccoutPriorityTest() {
    Account testAcc = new Account(Name = 'testAcc');
    insert testAcc;
    Opportunity opp = new Opportunity(AccountId=testAcc.Id,Name='testOpp', Amount=500, CloseDate= Date.newInstance(2022, 2, 17),StageName='Prospecting');
    insert opp;
      Test.startTest();
      Database.insert(opp, false);
      Test.stopTest();

      Account TrigeredAcc = [
        SELECT Priority__c
        FROM Account
        WHERE Id = :opp.AccountId
      ];
      System.assertEquals('low', TrigeredAcc.Priority__c);
    }
  }

