public class LeadProcessor implements Database.Batchable<sObject>, Database.stateful
{
    Integer recordcount =0;
    
	public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator([SELECT Id, Name FROM Lead]);		
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> scope) 
    {
        for(Lead lead : scope)
        {
            lead.LeadSource = 'Dreamforce';
        }
        
        update scope;
        recordCount = recordCount + scope.size();
    }
    
    
    public void finish(Database.BatchableContext bc)
    {
        System.debug('Total records processed' + recordCount);
    }
}