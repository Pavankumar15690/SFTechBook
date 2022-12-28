@isTest
public class ContactDuplicateBatchTest {

    @isTest
    public static void TestData()
    {
        List<Contact> conList = new List<Contact>();
        Contact conData = new Contact();
        conData.LastName = 'Pavan';
        conData.Email = 'pavankumar15690@gmail.com';
        conData.Phone = '1234567890';
        conList.add(conData);
        insert conList;
        Test.startTest();
            ContactDuplicateBatch DupData = new ContactDuplicateBatch();
            Database.executeBatch(DupData);
        Test.stopTest();
        
        //Contact cont = [select id,Name from Contact];
        //system.assertEquals(conList[0].Name,cont.Name);
    }
}