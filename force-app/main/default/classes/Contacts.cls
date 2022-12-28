public with sharing class Contacts {
    @AuraEnabled(cacheable=true)
    public static List<Contact> showContacts()
    {  
        //create list in contact
        List<Contact> contactList = new List<Contact>();
        //In contactList I'm fetching six records
        contactList = [SELECT Id, Name, Phone, Image_URL__c, Quantity__c FROM Contact limit 6];
        return contactList;  
    }
}