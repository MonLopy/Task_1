public with sharing class GetCustomFields {
    @AuraEnabled(cacheable=true)
    public static List<String> getContactFields(){
        SObjectType contactType = Schema.getGlobalDescribe().get('Customer_report__c');
        Map<String,Schema.SObjectField> mfields = contactType.getDescribe().fields.getMap();

        List<String> sObjectDetailsList = new List<String>();
        for(String s : mfields.keySet()){
            sObjectDetailsList.add(String.valueOf(mfields.get(s)));
        }
        return sObjectDetailsList;
    }
}
