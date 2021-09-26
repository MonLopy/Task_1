public class AccountHandler extends TriggerHandler {
  public override void beforeDelete() {
    DeleteOppHandlerHelper test = new DeleteOppHandlerHelper();
    test.sendMsg();
  }
}
