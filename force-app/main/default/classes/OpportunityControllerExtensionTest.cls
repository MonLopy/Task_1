@isTest
public class OpportunityControllerExtensionTest {
@isTest
static void testOpportunityProd(){    
       Opportunity opp = new Opportunity(Name = 'Test Opp',
       StageName='Prospecting',CloseDate=Date.newInstance(2021, 12, 12));   
       insert opp;       
      //test8 is the Visualforce page created
       PageReference testPage = Page.test8; 
       Test.setCurrentPage(testPage);
       testPage.getParameters().put('Id', String.valueOf(opp.Id));
        
       ApexPages.StandardController sc = new  ApexPages.StandardController(opp);     
       OpportunityControllerExtension oce = new OpportunityControllerExtension(sc);         
         
       System.debug(oce.getChildOpps()); 
       List<Opportunity> al = [Select Name from Opportunity where Name LIKE '%Test%' LIMIT 1];
       System.assertEquals(1, al.size());
   } 
}