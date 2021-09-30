trigger LeadMailTrigger on Lead (before insert,before update) {
    new  LeadMailHandler().run();
}