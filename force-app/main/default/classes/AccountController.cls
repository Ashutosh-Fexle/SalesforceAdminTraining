public class AccountController 
{
	@AuraEnabled(cacheable=true)
    public static List<Account> accountRecordsList()
    {
        List<Account> accList = [SELECT Id, Name, AnnualRevenue, Phone, Type, Website FROM Account];
        
        return accList;
    }
}