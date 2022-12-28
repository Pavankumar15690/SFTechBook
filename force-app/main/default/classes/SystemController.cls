public class SystemController {
    @AuraEnabled(cacheable=true)
    public static List<Alert__c> getRecord(){
        List<Alert__c> alertlist = [SELECT Id,Title__c,Body__c FROM Alert__c ORDER BY createdDate ASC];
        return alertlist;
    }
}