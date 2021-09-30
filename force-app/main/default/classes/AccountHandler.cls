public class AccountHandler extends TriggerHandler {
  public override void beforeDelete() {
    AccountHelper.sendMsg((List<Account>) Trigger.old);
  }
}
