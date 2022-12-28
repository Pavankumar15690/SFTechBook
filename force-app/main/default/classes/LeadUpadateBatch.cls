global class LeadUpadateBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT AnnualRevenue FROM Lead]);
    }

    global void execute(Database.BatchableContext bc, List<Lead> lList)
    {
        for(Lead l : lList)
        {
            l.AnnualRevenue = 250000;
        }
        Update lList;
    }
    
    global void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddress = new String[]{'pavankumarreddy.pula@raagvitech.com'};
        mail.setToAddresses(toAddress);
        mail.setSubject('Batch Job Completed');
        mail.setHtmlBody('Hey, The Batch Job is Succesfully Completed');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}