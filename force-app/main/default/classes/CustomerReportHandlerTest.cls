@isTest
public class CustomerReportHandlerTest {
    @isTest
    public static void TestInsert() {       
        Account testAcct = new Account(Name = 'TestAcct');
        insert testAcct;
        Customer_Report__c Cust = new Customer_Report__c(Account__c = testAcct.Id, Name = '1324', Frequency__c = 'D');
        Test.startTest();
        Database.insert(Cust, false);
        Test.stopTest();
        Account TrigeredAcc = [SELECT Website,  Name FROM Account WHERE id =: Cust.Account__c];
		System.assertEquals('https://www.google.com/', TrigeredAcc.Website);
    }
}