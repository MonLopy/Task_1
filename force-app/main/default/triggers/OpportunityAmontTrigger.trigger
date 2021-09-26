trigger OpportunityAmontTrigger on Opportunity (before insert, before update) {
    new OpportunityAmountHandler().run();
}