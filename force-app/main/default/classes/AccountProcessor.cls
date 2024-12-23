public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) 
    {
		System.debug('Coming inside future method');
        if(!accountIds.isEmpty())
        {			
				   List<AggregateResult> agrList = [SELECT AccountId, COUNT(Id) countOfContact
													FROM Contact
													WHERE AccountId IN: accountIds
													GROUP BY AccountId ];
            
            		System.debug('agrList :-' + agrList);
            
					Map<Id, Account> mapOfAccountIds = new Map<Id, Account>();
					
            		if(!agrList.isEmpty())
					{
						for(AggregateResult agr : agrList)
						{
							String AccountId = (Id)agr.get('AccountId');
							Integer Number_Of_Contacts = (Integer)agr.get('countOfContact');
							
							mapOfAccountIds.put(AccountId, new Account(Id = AccountId, Number_Of_Contacts__c = Number_Of_Contacts));
						}
					}
					
            		System.debug('values of mapOfAccountIds :-' + mapOfAccountIds.values());		
            
					update mapOfAccountIds.values();
				}
				System.debug('Exiting from future method');
    }
}

/*	Anonymous Test :-
List<Account> accList = [SELECT Id, Name FROM Account LIMIT 10];
List<Id> accIds = new List<Id>();

for(Account acc : accList)
{
    accIds.add(acc.Id);
}

AccountProcessor.countContacts(accIds);
*/