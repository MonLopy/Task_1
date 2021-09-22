public class DeleteOppHandler extends TriggerHandler {
  public override void beforeDelete() {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<Opportunity> list_opp_all = new List<Opportunity>();
    //user email
    String userName = UserInfo.getUserName();
    User activeUser = [
      SELECT Email, Name
      FROM User
      WHERE Username = :userName
      LIMIT 1
    ];
    String userEmail = activeUser.Email;
    //all deleted account
    for (Account acc : (List<Account>) Trigger.old) {
      List<Opportunity> list_opp = [
        SELECT Name, Id
        FROM Opportunity
        WHERE AccountId = :acc.Id
      ];
      list_opp_all.addAll(list_opp);
      //if we delete - create one msg
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      mail.setToAddresses(new List<String>{ 'mamchak2000@gmail.com' });
      mail.setSenderDisplayName('MAIL');
      mail.setSubject('Account was deleted');
      String body = 'Hi ' + UserName + ', <br>';
      body +=
        'Due to deletion of Account ' +
        acc.Name +
        ' all next related Opportunities were deleted as well:<br>';
      Integer i = 1;
      for (Opportunity opp : list_opp) {
        body += i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
        i++;
      }
      mail.setHtmlBody(body);
      mails.add(mail);
    }
    Messaging.sendEmail(mails);
    delete list_opp_all;
  }
}
