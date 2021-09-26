trigger CustomReportTrigger on Customer_Report__c(
  before insert,
  before update
) {
  new CustomerReportHandler().run();
}
