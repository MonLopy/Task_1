public class CustomerReportHandler extends TriggerHandler {
  public override void beforeInsert(){
   AddingLinkInAccount(); 
}
public override void beforeUpdate(){
   AddingLinkInAccount();
   
} 
//If Frequency hac D - Account Site gets URL
public void AddingLinkInAccount(){
    List<Id> listIs = new List<Id>();
    for(Customer_Report__c CustRep : (List<Customer_Report__c>) Trigger.new) {
            if(CustRep.Frequency__c != null  && CustRep.Frequency__c.contains('D')){
                listIs.add(CustRep.Account__c);
            }
      }
      List<Account> AccList = [SELECT Id, Website FROM Account WHERE Id IN :listIs];
        for (Account acc : AccList) {
            acc.Website = 'https://www.google.com/';
        }
}
}