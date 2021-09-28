public class CustomerReportHandler extends TriggerHandler {
  public override void beforeInsert(){
   AddingLinkInAccount(); 
}
public override void beforeUpdate(){
   AddingLinkInAccount();
   
} 
public override void afterInsert(){
    ChangeNotesInCustRep();
} 
public override void afterUpdate(){
    ChangeNotesInCustRep();
} 
//Create note From Account name and company name
public void ChangeNotesInCustRep(){
    if (TriggerHandler.isBypassed('TriggerHandler')){return;}
    List<Customer_Report__c> CustRep = [SELECT Id, Account__r.Name, createdby.CompanyName FROM Customer_Report__c WHERE Id IN :Trigger.newMap.keySet()];
    for (Customer_Report__c cr : CustRep) {
        cr.Note__c = cr.Account__r.Name + cr.createdby.CompanyName;
    }
    TriggerHandler.bypass('TriggerHandler');
    update CustRep;
    TriggerHandler.clearAllBypasses();
}
//If Frequency hac D - Account Site gets URL
public void AddingLinkInAccount(){
    if (TriggerHandler.isBypassed('TriggerHandler')){return;}
    List<Id> listIs = new List<Id>();
    for(Customer_Report__c CustRep : (List<Customer_Report__c>) Trigger.new) {
        if(CustRep.Frequency__c != null ){
            if(CustRep.Frequency__c.contains('D')){
                listIs.add(CustRep.Account__c);
            }
        }
      }
      List<Account> AccList = [SELECT Id, Site FROM Account WHERE Id IN :listIs];
        for (Account acc : AccList) {
            acc.Site = 'https://www.google.com/';
        } 
        update AccList;
}
}
