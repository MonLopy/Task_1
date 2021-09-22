trigger UpdateDeleteOppTrigger on Account(before delete) {
  new DeleteOppHandler().run();
}
