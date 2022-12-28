/* ClassName   : Attachments
* CreatededBy  : Pavankumar Reddy P
* Created on   : 16/09/2022
* Description  : When I Sending email it's stored related Attachments 
* Last Modified on : 20/09/22
* Last Modified by : Pavankumar Reddy P*/

global class Attachments implements Messaging.InboundEmailHandler
{
    // global String Id;
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        try
        {
            Case emailCase = new Case();
            emailCase.Status = 'New';
            emailCase.Origin = 'Email';
            emailCase.Priority = 'Medium';
            emailCase.Subject = email.Subject;
            emailCase.Description = email.plainTextBody;
            emailCase.SuppliedEmail = email.fromAddress;
            insert emailCase;
            System.debug('Email:'+emailCase.Id);
            
            String Id = emailCase.Id;
            caseEmails(email , Id);  
        }
        catch(Exception e)
        {
            System.debug('Got an exception:'+e);
        }  
        return result;
    }
    global void caseEmails(Messaging.InboundEmail email, String Id)
    {
        try
        {
            EmailMessage emailMessage = new EmailMessage();
            emailMessage.Subject = email.subject;
            emailMessage.FromAddress = email.fromAddress;
            emailMessage.ToAddress = email.toAddresses[0];
            emailMessage.ParentId = Id;
            insert emailMessage;
            System.debug('emailMessage--->'+ emailMessage);
            
            List<Attachment> Attachment = new List<Attachment>();
            if(email.binaryAttachments != null && email.binaryAttachments.isEmpty())
            {
                for (Integer i = 0; i < email.binaryAttachments.size(); i++) 
                {
                    Attachment attach = new Attachment();
                    attach.Name = email.binaryAttachments[i].filename;
                    attach.Body = email.binaryAttachments[i].body;
                    attach.ParentId = Id;
                    Attachment.add(attach);
                }
            }
            
            if(email.textAttachments != null && email.textAttachments.isEmpty())
            {
                for (Integer i = 0; i < email.textAttachments.size(); i++) 
                {
                    Attachment attached = new Attachment();
                    attached.Name = email.textAttachments[i].filename;
                    attached.Body = Blob.valueOf(email.textAttachments[i].body);
                    attached.ParentId = Id;
                    Attachment.add(attached);
                }
            }
            if(attachment.isEmpty())
            {
                insert attachment;
            }
            
        }
        catch(Exception e)
        {
            System.debug('Got an exception:'+e);
        }
    }
}