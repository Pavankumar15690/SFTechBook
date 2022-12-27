public class ClubHandler {
    
    public static void ClubDetails(List<Student__c> stulist )
    {  
        List<Club__c> clublist = new List<Club__c>(); 
        System.debug('stulist--- >'+stulist);
        for(Student__c stlist : stulist) 
        {   
            Club__c clubs = new Club__c();
            clubs.Name = stlist.Select_Club1__c;
            clubs.Name = stlist.Select_Club2__c;
            clubs.Name = stlist.Select_Club3__c;
            clubs.Student_Name__c = stlist.Name;
            clubs.Registered__c = true;
            clublist.add(clubs);
            System.debug('--- >>'+clublist);
            if(stlist.Select_Club1__c == stlist.Select_Club2__c || stlist.Select_Club1__c == stlist.Select_Club3__c)
            {
                stlist.Select_Club1__c.addError('You Cannot Choose Same value');
            }
            else if(stlist.Select_Club2__c == stlist.Select_Club3__c)
            {
                stlist.Select_Club2__c.addError('You Cannot Choose Same value');
            }
            
        }
        if(!clublist.isEmpty())
        {
            insert clublist; 
        }   
    } 
}