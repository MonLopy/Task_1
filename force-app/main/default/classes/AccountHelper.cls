public class AccountHelper {
  public static void sendMsg(List<Account> accs) {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<EmailTemplate> template = [
      SELECT Id, Body, HtmlValue, Subject,Name
      FROM EmailTemplate
      WHERE Name = 'Delete Account' 
    ];
    List<Opportunity> listOpp = [
      SELECT Name, Id, AccountId
      FROM Opportunity
      WHERE AccountId IN :accs
    ];
    Map<Id, List<Opportunity>> m1 = new Map<Id, List<Opportunity>>{};
    for (Opportunity oo : listOpp) {
      if (!m1.containsKey(oo.AccountId)) {
        m1.put(oo.AccountId, new List<Opportunity>());
      }
      m1.get(oo.AccountId).add(oo);
    }

    for (Id acc : m1.keySet()) {
      //if we delete - create one msg
      Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(template[0].Id, UserInfo.getUserId(), acc);
      String emailSubject = mail.getSubject();
      String emailTextBody = mail.getPlainTextBody();
      mail.setTargetObjectId(UserInfo.getUserId());
      mail.setSubject(emailSubject);
      mail.setSaveAsActivity(false);
      mail.setWhatId(acc);

      // change body
      String plainText =  '<br>';
      Integer i = 1;
      for (Opportunity opp : listOpp) {
        plainText += i + '. ' + opp.Id + ',' + opp.Name + '.<br>';
        i++;
      }
      emailTextBody += plainText;
      mail.setHtmlBody(emailTextBody);
      mails.add(mail);
    }
    Messaging.sendEmail(mails);
    delete listOpp;
  }
}
