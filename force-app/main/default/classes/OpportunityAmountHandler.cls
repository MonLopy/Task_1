public class OpportunityAmountHandler extends TriggerHandler{
  public override void beforeUpdate() {
    changeAccoutPriority();
  }
  public override void beforeInsert() {
    changeAccoutPriority();
  }
  public void changeAccoutPriority() {
    String prioritet='';
    List<Id> accId = new List<Id>();
    for (Opportunity opp : (List<Opportunity>) Trigger.new) {
      if (opp.Amount != null) {
        if (opp.Amount <= 5000 && opp.Amount >= 1) {
          accId.add(opp.AccountId);
          prioritet='low';
        } else if (opp.Amount >= 500000) {
          accId.add(opp.AccountId);
          prioritet='high';
        }
      }
    }
    List<Account> AccList = [
      SELECT Id, Priority__c
      FROM Account
      WHERE Id = :accId
    ];
    for (Account acc : AccList) {
      acc.Priority__c = prioritet;
    }
    prioritet='';
    update AccList;
  }
 
}
