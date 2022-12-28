public with sharing class CreateContactController {
    @AuraEnabled
    public static void createContact(String lastName,String email)
    {
        list<Contact> con = new list<contact>();
        contact c=new contact();
        c.LastName=lastName;
        c.Email=email;
        con.add(c);
        insert con;                         
    }
}