@isTest
public class OpportunityControllerTest {
    @isTest
    public static void OpportunityControllerTest() {
        Opportunity opp = new Opportunity(
            Name='Test',
            StageName = 'Prospecting',
            CloseDate = Date.newInstance(2022, 8, 8),
            Amount = 300000
        );
        insert opp;
        List<Opportunity> oc = OpportunityController.getOppRecords() ;
        System.assert(oc!=null);
    }
}
