public class ConatctListController {
    
   @AuraEnabled
    public static ContactListWrapper getContactData(Integer pageNumber, Integer pageSize) 
    {     
        Integer offset = (pageNumber - 1) * pageSize; 
       
        Integer totalRecords = [SELECT COUNT() FROM Contact];
        Integer recordEnd = pageSize * pageNumber;
        
        ContactListWrapper conList =  new ContactListWrapper();  
        conList.pageSize = pageSize;
        conList.pageNumber = pageNumber;
        conList.recordStart = offset + 1;
        conList.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords; // exp1 operator exp2 ? val1 if true : val2 if false
        conList.totalRecords = totalRecords;
        conList.contactList = [SELECT Name, Title, Birthdate, Phone, Email FROM Contact ORDER BY Name LIMIT :pageSize OFFSET :offset];
        return conList;
    }
    
    public class ContactListWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Contact> contactList {get;set;}
    }
}