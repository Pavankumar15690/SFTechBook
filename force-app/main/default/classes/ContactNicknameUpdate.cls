/* ClassName   : ContactNicknameUpdate
* CreatededBy  : Pavankumar Reddy P
* Created on   : 06/08/2022
* Description  : In Contact field I'm insert First & Lastname taking first letter to update Nick name Field
* Last Modified on : 06/08/22
* Last Modified by : Pavankumar Reddy P*/

global class ContactNicknameUpdate implements Database.Batchable<sObject>, Database.Stateful
{
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('SELECT Name, FirstName, LastName, Nick_Name__c FROM Contact');
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> conList)
    {  
        for(Contact conNick: conList)
        {
            String[] firstName = conNick.FirstName.split('');
            String[] lastName = conNick.LastName.split('');
            conNick.Nick_Name__c = firstName[0] + lastName[0];  
        }
        upsert conList;      
    }
    
    global void finish(Database.BatchableContext bc)
    {
        
    }  
}