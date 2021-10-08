public with sharing class BatchApexProgress {
    @AuraEnabled
    public static Id executeBatchJob() {
        Id batchJobId = Database.executeBatch(new ColdLead());
        return batchJobId;
    }
}
