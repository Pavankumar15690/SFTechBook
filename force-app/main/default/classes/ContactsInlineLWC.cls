public with sharing class ContactsInlineLWC {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        return[SELECT Name, FirstName, LastName, Email, Phone FROM Contact 
               WHERE Email !=null AND Phone !=null ORDER BY CreatedDate limit 10];
    }
}