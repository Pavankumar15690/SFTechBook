trigger StudentTrigger on Student__c (after update) 
{
    if(trigger.isAfter && trigger.isUpdate)
    {
            StudentEmail.SendEmailNotification(trigger.new);
    }  
}