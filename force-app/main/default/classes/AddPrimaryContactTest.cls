@isTest
private class AddPrimaryContactTest 
{
    @testSetup
    static void setupTestData() 
    {
        List<Account> nyAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) 
        {
            nyAccounts.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
        }
        System.debug('nyAccounts:'+nyAccounts);
        insert nyAccounts;

        List<Account> caAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) 
        {
            caAccounts.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }
        System.debug('caAccounts:'+caAccounts);
        insert caAccounts;
    }

    @isTest
    static void testAddPrimaryContact() 
    {
        Contact sampleContact = new Contact(FirstName = 'Test', LastName = 'Contact');
        System.debug('sampleContact:'+sampleContact);

        AddPrimaryContact job = new AddPrimaryContact(sampleContact, 'CA');
        System.debug('job:'+job);
		
        Test.startTest();
        System.debug('Entering the Test');

            System.enqueueJob(job);
        
        System.debug('Exiting the Test');
        Test.stopTest();

        List<Contact> insertedContacts = [SELECT Id, AccountId, FirstName, LastName, Email FROM Contact WHERE Account.BillingState = 'CA'];
        System.debug('insertedContacts'+insertedContacts);
        System.assertEquals(50, insertedContacts.size(), 'There should be 50 Contacts inserted for CA Accounts.');

        for (Contact contact : insertedContacts) 
        {
            System.assertEquals('Test', contact.FirstName);
            System.assertEquals('Contact', contact.LastName);
        }
    }
}