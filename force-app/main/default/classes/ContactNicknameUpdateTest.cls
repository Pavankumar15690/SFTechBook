@isTest
public class ContactNicknameUpdateTest {
    
    @isTest
    public static void TestData()
    {
        List<Contact> conList = new List<Contact>();
        Contact conNick = new Contact();
        conNick.FirstName = 'Pavan';
        conNick.LastName = 'Kumar';
        conNick.Nick_Name__c = 'PK';
        conList.add(conNick);
        upsert conList;
        Test.startTest();
            ContactNicknameUpdate conNickName = new ContactNicknameUpdate();
            Database.executeBatch(conNickName);
        Test.stopTest();
        List<Contact> contList = [SELECT Name, FirstName, LastName, Nick_Name__c FROM Contact];
        System.assertEquals(conNick.Nick_Name__c , contList[0].Nick_Name__c);
    }
}