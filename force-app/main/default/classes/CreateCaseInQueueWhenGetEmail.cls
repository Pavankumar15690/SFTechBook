global with sharing class CreateCaseInQueueWhenGetEmail implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) 
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        try{
            Id caseId = Cases.getCaseIdFromEmailHeaders(email.headers);
            if (caseId == null) {
                MAP<String,Id> createCase = new MAP<String,Id>();						
                for(Group grp : [select Id,Name from Group where Type='Queue'])			
                {
                    createCase.put(grp.Name,grp.Id);									
                    System.debug('Step1----->'+grp);
                }
                
                List<User> userList = [SELECT Id, Name, Profile.UserLicense.Name FROM User WHERE Profile.UserLicense.Name = 'Salesforce Platform'];
                System.debug('userList-->'+userList);
                Email_Case_Queue__mdt caseMeData1 = Email_Case_Queue__mdt.getInstance('Queue1');
                String createQueueName1 = caseMeData1.Email_Queue__c;
                System.debug('Email 1'+ createQueueName1);
                
                Email_Case_Queue__mdt caseMeData2 = Email_Case_Queue__mdt.getInstance('Queue2');
                String createQueueName2 = caseMeData2.Email_Queue__c;
                System.debug('Email 2'+ createQueueName2);
                
                
                Email_Case_Queue__mdt caseMeDataEmail1 = Email_Case_Queue__mdt.getInstance('Email1');
                List<String> getEmail1 = caseMeDataEmail1.Email_Queue__c.split(',');
                System.debug('getEmail1-----'+getEmail1);
                
                Email_Case_Queue__mdt caseMeDataEmail2 =  Email_Case_Queue__mdt.getInstance('Email2');
                List<String> getEmail2 = caseMeDataEmail2.Email_Queue__c.split(',');
                System.debug('getEmail2-----'+getEmail2);
                //containsAny(inputString)
                
                Case newCase = new Case();
                newCase.Origin = 'Email';
                newCase.Priority = 'None';
                newCase.Status = 'New';
                newCase.Subject = email.Subject;
                newCase.Description = email.plainTextBody;
                
                for(String toAdd : email.toAddresses){
                    if(getEmail1.contains(toAdd)){
                        newCase.OwnerId = createCase.get(createQueueName1);//userList[0].Id;
                    }
                    else if(getEmail2.contains(toAdd)){
                        newCase.OwnerId = createCase.get(createQueueName2);
                    }
                }
                List<Contact> con = [SELECT Id, FirstName, LastName, Email, OwnerId FROM Contact WHERE Email =: email.fromAddress];
                System.debug('con size'+con.size());
                for(Contact cont : con)
                {
                    System.debug('NAme   '+cont.FirstName);
                    if(con.size()>1 && email.fromAddress == cont.Email){
                        newCase.Many_Contacts__c=true;
                    }
                    else if(email.fromAddress == cont.Email){
                        newCase.Many_Contacts__c=false;
                        newCase.ContactId=cont.id;
                    }
                }
                insert newCase;
                System.debug('case ID --'+newCase.Id);
                System.debug('email------'+email);
                if (email.toAddresses != null) {
                    mailCreate(newCase.Id,email);
                }
                attachInCase(email,newCase.Id);
                caseId = newCase.Id;
            }
            String toAddresses;
            EmailMessage em = new EmailMessage(
                Status = '0',
                MessageIdentifier = email.messageId,
                ParentId = caseId,
                // Important fields
                FromAddress = email.fromAddress,
                FromName = email.fromName,
                ToAddress = toAddresses,
                TextBody = email.plainTextBody,
                Subject = email.subject
                // Other fields you wish to add
            );
            insert em;
        }
        catch(Exception e){
            
        }
        return result;
    }
    
    global void attachInCase(Messaging.InboundEmail email,String caseId)
    {
        try
        {
            LIST<Attachment> attch = new LIST<Attachment>();
            Integer attachmentSize = email.binaryAttachments.size();
            System.debug('attachmentSize--->'+attachmentSize);
            System.debug('caseId from method'+caseId);
            System.debug('email from method---'+email);
            System.debug('caseId from method'+caseId);
            System.debug('email from method---'+email);
            
            for(Integer i = 0 ; i < attachmentSize ; i++)
            {
                Attachment att = new Attachment();
                att.Name = email.binaryAttachments[i].fileName;
                att.Body = email.binaryAttachments[i].body;                    
                att.ParentId = caseId;
                System.debug('PArentId ------'+att.ParentId);
                
                attch.add(att);
            }
            if(attch.size() > 0)
                insert attch;
            System.debug('Attachments--->'+attch);
        }
        catch(TypeException te)
        {
            System.debug('TypeInvalid');
        }
    }
    global void mailCreate(Id caseId,Messaging.InboundEmail email)					
    {
        System.debug('step3---->'+caseId);
        try
        {
            System.debug('step4---->'+caseId);
            EmailMessage emailCreate = new EmailMessage();
            emailCreate.Subject =email.subject;
            emailCreate.FromAddress = email.fromAddress;
            emailCreate.ToAddress = String.valueOf(email.toAddresses);
            System.debug('mail3---->'+String.valueOf(email.toAddresses));
            emailCreate.ParentId =CaseId;							
            System.debug('step5---->'+emailCreate);
            insert emailCreate;
            System.debug('step6---->'+emailCreate);
        }
        catch(EmailException em)
        {
            System.debug('error');  
        }
    }
}