public class QueueableClass implements Queueable {
    
    public void execute(QueueableContext context)
    {
        List<Account> lstToUpdate = new List<Account>();
        for(Account obj : [Select Id, Type From Account Where Type = 'Customer - Direct'])
        {
            obj.type = 'Prospect';
            lstToUpdate.add(obj);
        }
        if(!lstToUpdate.isEmpty())
        {
            Update lstToUpdate;
        }
    }

}