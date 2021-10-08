public class ColdLead implements Database.Batchable<sObject>, Database.Stateful {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator(
      [SELECT Id, Status FROM Lead WHERE Status LIKE 'Closed - Not Converted']
    );
  }
  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    // process each batch of records
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<Lead> leads = scope;
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(new List<String>{'mamchak2000@gmail.com'});
    email.setSenderDisplayName('MAIL');
    email.setSubject('Cold Lead were deleted');
    String body='Hi'+'<br>';
    body+='All Lead with Status Cold were deleted';
    email.setHtmlBody(body);
    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
    delete leads;
  }
  public void finish(Database.BatchableContext bc) {
  }
}
