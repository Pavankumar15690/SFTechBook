/* ClassName   : EmailServices
* CreatededBy  : Pavankumar Reddy P
* Created on   : 16/09/2022
* Description  : When I Sending email it's stored related emails and change ownerId to Queue
* Last Modified on : 19/09/22
* Last Modified by : Pavankumar Reddy P*/


global class EmailServices implements Messaging.InboundEmailHandler
{
    global String Id;
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        System.debug('result-->'+ result);
        try
        {   
            // Try to find a Case based on the email headers
            Id caseId = Cases.getCaseIdFromEmailHeaders(email.headers);
            // If no Case found, create a New Case
            if (caseId == null) 
            {
                Map<String,Id> caseMap = new Map<String,Id>();
                for(Group grpQue :[SELECT Id, Name, Type FROM Group WHERE Type = 'Queue'])
                {
                    caseMap.put(grpQue.Name, grpQue.Id);
                    System.debug('grpQue-->'+ grpQue);
                }
                
                CaseQue__c cases = CaseQue__c.getInstance('Queue1');
                String caseMails = cases.Name;
                String mailOne = cases.Queue_Email__c.split(',').get(0);
                String mailThree = cases.Queue_Email__c.split(',').get(1);
                
                CaseQue__c casesOne = CaseQue__c.getInstance('Queue2');
                String caseMailsOne = casesOne.Name;
                String mailTwo = casesOne.Queue_Email__c;
                
                Case emailCase = new Case();
                emailCase.Status = 'New';
                emailCase.Origin = 'Email';
                emailCase.Priority = 'Medium';
                emailCase.Subject = email.Subject;
                emailCase.Description = email.plainTextBody;
                emailCase.SuppliedEmail = email.fromAddress;
                
                if(mailOne==email.toAddresses[0] || mailThree == email.toAddresses[0])
                {     
                    emailCase.OwnerId = caseMap.get(caseMails);     
                }
                else if(mailOne==email.toAddresses[0])
                {
                    emailCase.OwnerId = caseMap.get(caseMailsOne); 
                }
                
                List<Contact> cont = [SELECT Id, LastName, Email FROM Contact WHERE Email=:email.fromAddress];
                for(Contact con : cont)
                {
                    if(cont.size()>1 && email.fromAddress==con.Email)
                    {
                        emailCase.Many_Contacts__c = true;
                    }
                    else if(email.fromAddress==con.Email)
                    {   
                        emailCase.Many_Contacts__c = false;
                        emailCase.ContactId=con.Id;
                    }
                }
                System.debug('cont--->'+ cont); 
                insert emailCase;
                System.debug('emailcase--->'+ emailCase);
                caseId = emailCase.Id;    
            } 
            Id = caseId;
            caseEmails(email);
            System.debug('caseId--->'+ caseId);
        }
        catch(Exception e)
        {
            System.debug('Error'+ e); 
        }
        result.success = true;
        return result;
    }
    global void caseEmails(Messaging.InboundEmail email)
    {
        try
        {  
            String toAddresses;
            if (email.toAddresses != null) 
            {
                toAddresses = String.join(email.toAddresses, ';');
                System.debug('toAddresses--->'+ toAddresses);
                EmailMessage emailMessage = new EmailMessage();
                emailMessage.MessageIdentifier = email.messageId;
                emailMessage.FromAddress = email.fromAddress;
                emailMessage.FromName = email.fromName;
                emailMessage.ToAddress = toAddresses;
                emailMessage.TextBody = email.plainTextBody;
                emailMessage.Subject = email.subject;
                emailMessage.ParentId = Id;
                insert emailMessage;
                
                System.debug('emailMessage--->'+ emailMessage);
            }
            List<Attachment> attach = new List<Attachment>();
            if(email.textAttachments != null)
            {
                for (Messaging.Inboundemail.textAttachment textAttach : email.textAttachments) 
                {
                    Attachment attachment = new Attachment();
                    attachment.Name = textAttach.fileName;
                    attachment.Body = Blob.valueOf(textAttach.body);
                    attachment.ParentId = Id;
                    attach.add(attachment);
                }
            }
            
            if(email.binaryAttachments != null)
            {
                for(Messaging.InboundEmail.BinaryAttachment binaryAttach : email.binaryAttachments)
                {
                    Attachment attached = new Attachment();
                    attached.Name = binaryAttach.fileName;
                    attached.Body = binaryAttach.body;
                    attached.ParentId = Id;
                    attach.add(attached);   
                }
            }
            if(attach.isEmpty())
            {
                insert attach;
                System.debug('attach-->'+attach);
            } 
        }
        catch(Exception e)
        {
            System.debug('Error'+ e);   
        }
    }
}