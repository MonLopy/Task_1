public with sharing class OpportunityController {
  @AuraEnabled(cacheable=true)
  public static List<Opportunity> getOppRecords() {
    return [
      SELECT Id, Name, StageName, CloseDate, Amount
      FROM Opportunity
      WHERE NOT StageName LIKE 'Close%'
      ORDER BY Amount DESC NULLS LAST
      LIMIT 5
    ];
  }
}
// test
