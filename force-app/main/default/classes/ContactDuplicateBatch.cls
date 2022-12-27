/* ClassName   : ContactDuplicateBatch
* CreatededBy  : Pavankumar Reddy P
* Created on   : 04/08/2022
* Description  : In Contact list create a duplicates records automatically It will Deleted
* Last Modified on : 04/08/22
* Last Modified by : Pavankumar Reddy P*/

global class ContactDuplicateBatch implements Database.Batchable<sObject>, Database.Stateful
{
    global Database.QueryLocator start(Database.BatchableContext bc)
    {
        String query = 'SELECT Name, Phone FROM Contact';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Contact> conList)
    {  
        Map<String, ID> conMap = new Map<String, ID>();   
        for(Contact con : conList)  
        {
           conMap.put(con.Name +''+con.Phone, con.id);
        }
        
        List<Contact> uniqList = new List<Contact>();
        List<Contact> delList = new List<Contact>();
        
        Set<String> nameOfSet = conMap.keySet();
        Set<ID> uniqSet = new Set<ID>();
        
        for(String str: nameOfSet)    
        { 
            uniqSet.add(conMap.get(str));   
        }
        
        for(Contact conData: conList)    
        {    
            if((uniqSet.contains(conData.id)))
            {
                uniqList.add(conData);               
            }
            else
            {
                delList.add(conData);
            }        
        }
        System.debug('conList--->'+conList);
        delete delList;
        System.debug('conList--->'+conList);  
    }

    global void finish(Database.BatchableContext bc)
    {
        
    }   
}