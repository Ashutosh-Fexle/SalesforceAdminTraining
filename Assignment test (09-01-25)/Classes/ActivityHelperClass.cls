/*
 * Purpose 		:	Update the Fields on Account Object .
 * 
 * Created By 	:	Ashutosh Tiwari
 * 	
 * Create Date 	:	9/1/25
 * 
 * Version 		:	v1.0 - Created 
 */

public class ActivityHelperClass 
{
	public static void updateActivityCountOnAccount(List<Task> newTaskList, Map<Id, Task> oldTaskMap)
    {
        Map<Id, Account> mapOfAccountIds = new Map<Id, Account>();
        
        for(Task tk : newTaskList != null ? newTaskList : oldTaskMap.values())
        {
            if(tk.AccountId != null && ((oldTaskMap == null || newTaskList == null ||  
                                         (!oldTaskMap.isEmpty() && 
                                          (tk.AccountId != oldTaskMap.get(tk.Id).AccountId || tk.status != tk.oldTaskMap.get(tk.Id).status)))))
            {
           		mapOfAccountIds.put(tk.AccountId, new Account(Id = tk.AccountId, Total_Activities__c = 0));
                
            	if(!oldTaskMap.isEmpty() && (tk.AccountId != oldTaskMap.get(tk.Id).AccountId || tk.status != tk.oldTaskMap.get(tk.Id).status))
                {
                    mapOfAccountIds.put(tk.AccountId, new Account(Id = tk.AccountId, Total_Activities__c = 0));
                }
            }
        }
        
        // Fetching Count related to a Account .
        List<AggregateResult> agrList = [SELECT Id, AccountId, COUNT(Id) activityCount, Status
                                         FROM Task
                                         WHERE AccountId IN: mapOfAccountIds.keyset()
                                         GROUP BY Name];
        
        // Now i want to update different fields 
        for(AggregateResult agr : agrList)
        {
            Integer TotalActivity = (Integer)agr.get('activityCount');
            
            Id accId = (Id)agr.get('AccountId');
            
            if(agr.Status == 'In Progress' || agr.Status == 'Waiting on someone else' || agr.Status == 'Deferred')
            {
                Integer openActivity = openActivity + 1;
            }
            if(agr.Status == 'Completed')
            {
                Integer closeActivity = closeActivity + 1;
            }
            
            mapOfAccountIds.put(AccountId, new Account(Id = AccountId, Total_Activity__c = totalActivity, Total_Open_Activity__c = openActivity,
                                                       Total_Close_Activity__c = closeActivity));
        }
        
        update mapOfAccountIds.values();
    }
}