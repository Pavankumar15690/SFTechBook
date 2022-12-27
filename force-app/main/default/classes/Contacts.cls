public with sharing class Contacts {
    @AuraEnabled(cacheable=true)
    public static List<Contact> showContacts()
    { 
        //Added comments in repository
        List<Contact> contactList = new List<Contact>();
        contactList = [SELECT Id, Name, Phone, Image_URL__c, Quantity__c FROM Contact limit 6];
        return contactList;  
    }
}