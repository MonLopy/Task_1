public class OpportunityControllerExtension {
	Opportunity oppt;
    public OpportunityControllerExtension(ApexPages.StandardController controller){
        this.oppt = (Opportunity) controller.getRecord();
    }
     public List<OpportunityLineItem> getChildOpps(){
            return [SELECT 
                Name, Quantity, UnitPrice, TotalPrice 
                FROM OpportunityLineItem
                WHERE OpportunityId = :oppt.Id];
    }
}