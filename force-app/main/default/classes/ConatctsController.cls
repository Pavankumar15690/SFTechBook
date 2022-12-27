public class ConatctsController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> showContacts()
    { 
        List<Contact> contactList = new List<Contact>();
        contactList = [SELECT Id, Name, Phone, Image_URL__c FROM Contact limit 6];
        return contactList;  
    }
}