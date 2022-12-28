trigger ClubTrigger on Student__c (after update) {

    if(trigger.isAfter && trigger.isUpdate)
    {
        ClubHandler.ClubDetails(trigger.new);
    } 
}