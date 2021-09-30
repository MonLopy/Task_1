public class LeadMailHandler extends TriggerHandler {
    public override void beforeUpdate(){
        LeadMailHelper.LeadMail((List<Lead>) Trigger.new);
    }
    public override void beforeInsert(){
        LeadMailHelper.LeadMail((List<Lead>) Trigger.new);
 
    }
    
}
