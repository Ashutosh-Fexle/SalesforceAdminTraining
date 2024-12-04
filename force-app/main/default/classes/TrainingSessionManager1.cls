public class TrainingSessionManager1 {

    public static void customLabel(){
        System.debug(Label.Webinar_Success);
        System.debug(Label.Workshop_Success);
    }
//--------------------------------------------------- TASK-2 ----------------------------------------------------------------

    public static void sessionQuery(){
        
	List<Training_Session_c__c> sessionList = new List<Training_Session_c__c>([
        									  SELECT Id , Name 
        									  FROM Training_Session_c__c
        									  WHERE (Session_Date_c__c > Today
        											AND Session_type__c = 'WEBINAR'
        											AND Count_Attendee__c >= 1) 
    ]);
    System.debug(sessionList);
    }


//--------------------------------------------------- TASK-3 ----------------------------------------------------------------


public static void bulkInsertOperate()
{
    
    List<Training_Session_c__c> trainList = new List<Training_Session_c__c> 
    {
        new Training_Session_c__c(Name='Session6',Location__c='Fexle Office',Session_type__c='WEBINAR',Session_Date_c__c=System.Today().addDays(1)),
        new Training_Session_c__c(Name='Session7',Location__c='Fexle Office',Session_type__c='WORKSHOP',Session_Date_c__c=System.Today().addDays(2)),
        new Training_Session_c__c(Name='Session8',Location__c='Fexle Office',Session_type__c='SEMINAR',Session_Date_c__c=System.Today().addDays(3)),
        new Training_Session_c__c(Name='Session9',Location__c='Fexle Office',Session_type__c='WEBINAR',Session_Date_c__c=System.Today().addDays(4)),
        new Training_Session_c__c(Name='Session10',Location__c='Fexle Office',Session_type__c='SEMINAR',Session_Date_c__c=System.Today().addDays(5))                
    };
    
    Database.SaveResult[] srList = Database.insert(trainList,false);
    
    for(Database.SaveResult sr : srList)
    {
        if(sr.isSuccess())
        {
            System.debug('Insert Successful for ' + sr.getId());
        }
        else
        {
            for(Database.Error err : sr.getErrors())
            {
                System.debug('The error is :-');
                System.debug(err.getStatusCode() + ':' + err.getMessage());
            }
        }
    }
}
    
    
    
    
    public static void bulkUpdateOperate()
    {
		List<Training_Session_c__c> sessionsToUpdate = [SELECT Id, Name, Location__c 
                                                                    FROM Training_Session_c__c 
                                                                    WHERE Session_Date_c__c > Today];
       
        for(Training_Session_c__c session : sessionsToUpdate)
        {
            session.Location__c = 'Microsoft Office'; 
        }

		//Database.update(sessionsToUpdate, false); 

        
        Database.SaveResult[] srList = Database.update(sessionsToUpdate,false);

        for(Database.SaveResult sr : srList)
    	{
        	if(sr.isSuccess())
        	{
            	System.debug('Update Successful for ' + sr.getId());
        	}
        	else
        	{
            	for(Database.Error err : sr.getErrors())
                {
                	System.debug('The error is :-');
                	System.debug(err.getStatusCode() + ':' + err.getMessage());
            	}
        	}
    	}
        
    }
    
public static void bulkDeleteOperate(){
			List<Training_Session_c__c> sessionsToDelete = [
															SELECT Id 
															FROM Training_Session_c__c 
															WHERE Name LIKE 'Session%'
															];

			//Database.delete(sessionsToDelete, false); 
    
    
    
    	Database.DeleteResult[] srList = Database.delete(sessionsToDelete,false);

        for(Database.DeleteResult sr : srList)
    	{
        	if(sr.isSuccess())
        	{
            	System.debug('Delete Successful for ' + sr.getId());
        	}
        	else
        	{
            	for(Database.Error err : sr.getErrors())
                {
                	System.debug('The error is :-');
                	System.debug(err.getStatusCode() + ':' + err.getMessage());
            	}
        	}
    	}
			}
    
}