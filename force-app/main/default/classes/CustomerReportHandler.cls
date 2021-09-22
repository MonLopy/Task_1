public class CustomerReportHandler extends TriggerHandler {
  public override void beforeUpdate() {
    updateAccountWebsite();
  }
  public override void beforeInsert() {
    updateAccountWebsite();
  }
  public override void afterInsert() {
    addingNamesInNotes();
  }
  public override void afterUpdate() {
    addingNamesInNotes();
  }
  // If  Frequency in Custom object contains - D, we assign link to Website in Account
  public void updateAccountWebsite() {
    if (TriggerHandler.isBypassed('TriggerHandler')) {
      return;
    }
    List<Id> listIs = new List<Id>();
    for (Customer_report__c o : (List<Customer_report__c>) Trigger.new) {
      if (o.Frequency__c != null) {
        if (o.Frequency__c == 'D') {
          listIs.add(o.Account__c);
        }
      }
    }
    List<Account> AccList = [
      SELECT Id, Website
      FROM Account
      WHERE Id = :listIs
    ];
    for (Account acc : AccList) {
      acc.Website = 'https://www.google.com/';
    }
    TriggerHandler.bypass('TriggerHandler');
    update AccList;
    TriggerHandler.clearAllBypasses();
  }
  //Adding Account Name and Company Name into Notes field in Custom report obj
  public void addingNamesInNotes() {
    if (TriggerHandler.isBypassed('TriggerHandler')) {
      return;
    }
    List<Customer_Report__c> CustRep = [
      SELECT Id, Account__r.Name, createdby.CompanyName
      FROM Customer_Report__c
      WHERE Id IN :Trigger.newMap.keySet()
    ];
    for (Customer_Report__c cr : CustRep) {
      cr.Note__c = cr.Account__r.Name + cr.createdby.CompanyName;
    }
    TriggerHandler.bypass('TriggerHandler');
    update CustRep;
    TriggerHandler.clearAllBypasses();
  }
}
