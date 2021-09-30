public class LeadMailHelper {
  public static void LeadMail(List<Lead> led) {
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    List<User> usr = [
      SELECT Id, Name, UserRole.Name, Email
      FROM User
      WHERE UserRole.Name LIKE 'Sales manager'
    ];
    List<EmailTemplate> emailTemplates = [
      SELECT Id, Name
      FROM EmailTemplate
      WHERE Name LIKE 'Hot Lead V2'
    ];
    List<Id> listIs = new List<Id>();
    for (Lead o : (List<Lead>) led) {
        if (o.Status == 'Working - Contacted') {
          listIs.add(o.Id);
      }
    }
      List<Lead> leads = [
      SELECT Id, Name, LeadSource
      FROM Lead
      WHERE Id =:listIs
    ];
    for (Lead l : leads) {
        Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(
          emailTemplates[0].Id,
          usr[0].Id,
          l.Id
        );
        String emailSubject = email.getSubject();
        String emailTextBody = email.getPlainTextBody();
        email.setTargetObjectId(usr[0].Id);
        email.setSubject(emailSubject);
        email.setPlainTextBody(emailTextBody);
        email.saveAsActivity = false;
        mails.add(email);
      }
    Messaging.sendEmail(mails);
  }
}
