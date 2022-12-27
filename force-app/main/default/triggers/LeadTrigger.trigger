trigger LeadTrigger on Lead (before insert, before update) {
    
    if((Trigger.isInsert || Trigger.isUpdate)&&Trigger.isBefore)
    {
        for(Lead Id : Trigger.new){
            if(Id.Email==null){
                Id.Email.addError('Please Enter the Email Id Value');
            }
            else if(Id.Phone==null){
                Id.Phone.addError('Please Enter the Contact Number');
            }
        }
    }
}