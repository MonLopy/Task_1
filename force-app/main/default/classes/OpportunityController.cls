public with sharing class OpportunityController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOppRecords(){
        return [SELECT 	Id, Name,StageName, CloseDate,Amount FROM Opportunity WHERE (StageName !='%losed%' AND Amount !=NULL) ORDER BY Amount DESC LIMIT 5];
    }
}
