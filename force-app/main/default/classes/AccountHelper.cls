public class AccountHelper {
  public void sendMsg() {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<Opportunity> list_opp_all = new List<Opportunity>();
    //user email
    EmailTemplate template=[SELECT Id,Body,HtmlValue,Subject FROM EmailTemplate WHERE Name='Delete Account'];
    String userName = UserInfo.getUserName();
    User activeUser = [
      SELECT Email, Name
      FROM User
      WHERE Username = :userName
      LIMIT 1
    ];
    String userEmail = activeUser.Email;
    //all deleted account
    List<Opportunity> list_opp = new List<Opportunity>{};
    List<Account> ac = [SELECT Id, Name FROM Account WHERE id = :Trigger.old];
    for (Account a : ac) {
      list_opp = [SELECT Name, Id FROM Opportunity WHERE AccountId = :a.Id];
    }
    for (Account acc : ac) {
      list_opp_all.addAll(list_opp);
      //if we delete - create one msg
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      mail.setToAddresses(new List<String>{ 'mamchak2000@gmail.com' });
      mail.setSenderDisplayName('MAIL');
      mail.setSubject('Account was deleted');
      String plainText= template.body;
      // change body
      plainText=plainText.replace('!{Account.Name}', acc.Name);
      plainText+='<br>';
      Integer i = 1;
      for (Opportunity opp : list_opp) {
        plainText+= i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
        i++;
      }
      mail.setHtmlBody(plainText);
      mails.add(mail);
    }
    Messaging.sendEmail(mails);
    delete list_opp_all;
  }
}
