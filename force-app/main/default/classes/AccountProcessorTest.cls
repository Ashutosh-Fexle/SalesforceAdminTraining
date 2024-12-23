@isTest
private class AccountProcessorTest {
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'Test Account');
        System.debug('Account to be inserted: '+acc);
        insert acc;

        Contact con1 = new Contact(LastName = 'Test Contact 1', AccountId = acc.Id);
        Contact con2 = new Contact(LastName = 'Test Contact 2', AccountId = acc.Id);
        System.debug('Contact1 to be inserted: '+con1);
        System.debug('Contact2 to be inserted: '+con2);

        insert con1;
        insert con2;

    }
    @isTest
    static void testCountContacts() {
        Map<Id, Account> accMap = new Map<Id, Account>([SELECT Id, Name, Number_Of_Contacts__c FROM Account WHERE Name LIKE 'Test%']);
        System.debug('accRecords: '+accMap);

        List<Id> accIds = new List<Id>(accMap.keySet());
        System.debug('Initial accIds: '+accIds);
        //for(Account acc: accRecords) {
        //    accIds.add(acc.Id);
        //}
        System.debug('Filled accIds: '+accIds);
        Test.startTest();
        System.debug('Calling the future method.');
        AccountProcessor.countContacts(accIds);
        System.debug('Called future method.');

        Test.stopTest();

        List<Account> updatedAccRecords = [SELECT Id, Name, Number_Of_Contacts__c FROM Account WHERE Name LIKE 'Test%'];
        System.debug('updatedAccRecords: '+updatedAccRecords);

        Assert.areEqual(2, updatedAccRecords[0].Number_Of_Contacts__c);

    }
}