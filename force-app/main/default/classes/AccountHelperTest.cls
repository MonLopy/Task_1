@isTest
public  class AccountHelperTest {
    @isTest
    public static void sendMsgTest() {
        Account acc = new Account(Name='Test1');
        insert acc;
        List<Opportunity> oppList = new List<Opportunity>();
        oppList.add(
            new Opportunity(Name ='test2', AccountId=acc.Id,
             CloseDate=Date.today(),StageName='Closed Won')
        );
        if(oppList.size()>0){
        insert oppList;
        }
        Test.startTest();
        delete acc;
        Test.stopTest();
        Integer count = [SELECT COUNT() FROM Opportunity 
        WHERE AccountId =: acc.Id];
        System.assertEquals(0, count);

    }
}
