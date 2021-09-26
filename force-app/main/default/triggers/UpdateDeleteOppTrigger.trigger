trigger UpdateDeleteOppTrigger on Account(before delete) {
  new AccountHandler().run();
}
