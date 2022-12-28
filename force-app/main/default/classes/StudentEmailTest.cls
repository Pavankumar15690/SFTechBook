@isTest
public class StudentEmailTest 
{ 
    static testMethod void SendEmailNotificationTest()
    {
        list<Student__c> stuList = new list<Student__c>();
        Student__c Stu = new Student__c();
        stu.Name = 'Pavan';
        stu.Email_Sent__c = true;
        stu.Description__c = 'Something went wrong for send email';
        stu.Parent_Email__c = 'pavankumarreddy.pula@raagvitech.com';
        stuList.add(stu);
        insert stuList;
        StudentEmail.sendMail(stuList[0].Parent_Email__c,'aaa','hi hello');
        update stuList;
    }
}