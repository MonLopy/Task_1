public class CustomerReport extends TriggerHandler {
    public CustomerReport() {
        this.setMaxLoopCount(7);
    }
    public override void beforeUpdate(){
        updateOrInsert();
    }
    public override void beforeInsert(){
        updateOrInsert();
    }
    public override void afterInsert(){
        afterUpdateOrInsert();
    }
    public override void afterUpdate(){
        afterUpdateOrInsert();
    }
    public  void updateOrInsert() {
        if (TriggerHandler.isBypassed('TriggerHandler')){return;}
        List<Id> listIs = new List<Id>();
        for(Customer_report__c o : (List<Customer_report__c>) Trigger.new) {
           if(o.Frequency__c!=null){
            if(o.Frequency__c=='D'){
                listIs.add(o.Account__c);
            } }
        }
        if(!listIs.isEmpty()){
        List<Account> AccList=[SELECT Id, Website FROM Account WHERE Id =:listIs];
        for(Account acc : AccList) {
            acc.Website = 'https://www.google.com/';
        }
        TriggerHandler.bypass('TriggerHandler');
        update AccList;
        TriggerHandler.clearAllBypasses();

      }
    }
    public void afterUpdateOrInsert(){
        if (TriggerHandler.isBypassed('TriggerHandler')){return;}
        List<Customer_Report__c> CustRep = [SELECT Id, Account__r.Name, createdby.CompanyName FROM Customer_Report__c WHERE Id IN :Trigger.newMap.keySet()];
        for (Customer_Report__c cr : CustRep) {
            cr.Note__c = cr.Account__r.Name + cr.createdby.CompanyName;
        }
        TriggerHandler.bypass('TriggerHandler');
        update CustRep;
        TriggerHandler.clearAllBypasses();
         }
}