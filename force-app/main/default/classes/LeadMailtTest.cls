@isTest
public with sharing class LeadMailtTest {
    @isTest
    public static void  LeadMailtTest() {
        Lead l = new Lead(
            Status='Working - Contacted',
            LeadSource='Web',
            Email='testmail@gmail.com',
            FirstName = 'F1',
            LastName = 'L1',
            Company='Imagine'
        );
        Test.startTest();
        Database.insert(l, false);
        Test.stopTest();
        Integer count = [SELECT COUNT() FROM Lead 
        WHERE Id =: l.Id];
        System.assertEquals(1, count);
    }
}
