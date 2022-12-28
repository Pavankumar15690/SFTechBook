/* ClassName   : StudentEmailHandler
* CreatededBy  : Pavankumar Reddy P
* Created on   : 27/07/2022
* Description  : Student details update to Date & Message in Click checkbox through sent Parent Email
* Last Modified on : 28/07/22
* Last Modified by : Pavankumar Reddy P*/

public class StudentEmail
{
    public static void SendEmailNotification(List<Student__c> stulist)
    {
        for(Student__c stList : stuList)
        {
            try
            {  	
                String msg='Dear '+stList.Father_Name__c+' / '+stList.Mother_Name__c+'<br><br><B> We Are From GHS,BANGALORE </B><BR><BR> Your Son / Daughter : <b>'+stList.Name+'</b><BR><BR> Studied At My School,So that We Inviting You For <br><br> <b>'+stList.Message__c+'</b><br><br> On '+stList.Date__c+'<BR>Thankyou';
                Boolean isChecked = stList.Email_Sent__c;
                if(isChecked)
                {
                    sendMail(stList.Parent_Email__c,'Invitation From GHS,BANGALORE',msg);
                }
            } 
            catch(Exception e)
            { 
                stList.Description__c ='Something went wrong for send email';       
            }     
        }
    }
    public static void sendMail(String address, String subject, String body) 
    { 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {address};
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setHtmlBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}