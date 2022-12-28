@isTest
public class AttachmentsTest {
    @isTest
    static void TestinBoundEmail()
    {
        Messaging.InboundEmail email = new Messaging.InboundEmail() ;
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
   
        email.subject = 'Test Data';
        email.fromAddress = 'test@gmail.com';
        email.plainTextBody = 'Hello';
        
        Attachments testAttach = new Attachments ();
        testAttach.handleInboundEmail(email, env);
    }
    
    @isTest
    static void caseEmails()
    {
        //create test value
        //call the method attachment.caseEmail (your test variable)
        //use System.assertEquals method to check 
    }
}