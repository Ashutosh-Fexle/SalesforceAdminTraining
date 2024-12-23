/** 
*   Purpose         :   (Assignment) Write a trigger on Contact and validate the email. if Contact email address is having Account's Domain, 
*						then allow to save record else restrict user to create Contact record and throw a meaning error. 
*
*   Created Date    :   9/12/24
*
*   Created By      :   Ashutosh Tiwari
*
*   Revision Logs   :   V_1.0   -   Created 
*
**/
public class TriggerHandlerClass extends TriggerHandler
{
    public override void beforeInsert() {
        TriggerHandlerClass.emailCheck((List<Contact>)trigger.new, (Map<Id, contact>)trigger.oldMap);
    }
    
    public override void beforeUpdate() {
        TriggerHandlerClass.emailCheck((List<Contact>)trigger.new, (Map<Id, contact>)trigger.oldMap);
    }
    
    public override void beforeDelete() {
        TriggerHandlerClass.emailCheck((List<Contact>)trigger.new, (Map<Id, contact>)trigger.oldMap);
    }
    
    
    public static void emailCheck(List<Contact> newRecords , Map<Id, Contact> oldRecords)
    {
        if(!newRecords.isEmpty())
           {
               Map<Id, Account> MapOfIdWithAccount = new Map<Id, Account>();
               //
               for(Contact newCon : newRecords)
               {                   
                   if(newCon.AccountId != null && newCon.Email != null &&
                      (oldRecords == null || (newCon.AccountId != oldRecords.get(newCon.Id).AccountId
                     	|| newCon.Email != oldRecords.get(newCon.Id).Email)))
                   {
                       MapOfIdWithAccount.put(newCon.AccountId , new Account());
                   }
               }
               
               if(!MapOfIdWithAccount.KeySet().isEmpty())
               {
                 for(Account acc : [SELECT Id , Domain__c FROM Account WHERE Id IN : MapOfIdWithAccount.keySet()])
                   {
                       MapOfIdWithAccount.put(acc.Id, acc);
                   }
               }
               
               for(Contact newCon : newRecords)
               {
                   if(newCon.Email != null && newCon.AccountId != null)
                   {
                       String domainName = MapOfIdWithAccount.get(newCon.AccountId).Domain__c;
                       
                       System.debug('domainName@@@' +domainName);
                           
                       String emailDomain = newCon.Email.subStringAfter('@').toLowerCase();
                       
                       if(domainName != emailDomain)
                       {
                           newCon.addError('Please enter correct Domain in Email .');
                       }
                   }
               }
           }        
    }
}