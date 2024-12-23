@isTest
private class TriggerHandlerClassTest {
    @testSetup
    static void setupTestData() 
    {
        Account acc1 = new Account(Name = 'Account 1', Domain__c = 'example.com');
        Account acc2 = new Account(Name = 'Account 2', Domain__c = 'test.com');
        insert new List<Account>{ acc1, acc2 };
    }

    @isTest
    static void testBeforeInsert() {
        List<Account> accounts = [SELECT Id, Domain__c FROM Account];

        
        Contact validContact = new Contact(FirstName = 'Valid', LastName = 'Contact', Email = 'valid@example.com', AccountId = accounts[0].Id);
        Contact invalidContact = new Contact(FirstName = 'Invalid', LastName = 'Contact', Email = 'invalid@wrong.com', AccountId = accounts[0].Id);

        Test.startTest();
        
        insert validContact;

        
        try {
            insert invalidContact;
            System.assert(false, 'The invalid contact should have thrown an exception.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Please enter correct Domain in Email .'));
        }
        Test.stopTest();
    }

    @isTest
    static void testBeforeUpdate() {
        List<Account> accounts = [SELECT Id, Domain__c FROM Account];

        
        Contact validContact = new Contact(FirstName = 'Valid', LastName = 'Contact', Email = 'valid@example.com', AccountId = accounts[0].Id);
        insert validContact;

        
        validContact.Email = 'invalid@wrong.com';

        Test.startTest();
        
        try {
            update validContact;
            System.assert(false, 'The update should have thrown an exception.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Please enter correct Domain in Email .'));
        }
        Test.stopTest();
    }

    @isTest
    static void testBeforeDelete() {
        List<Account> accounts = [SELECT Id, Domain__c FROM Account];

        
        Contact contactToDelete = new Contact(FirstName = 'To Delete', LastName = 'Contact', Email = 'todelete@example.com', AccountId = accounts[0].Id);
        insert contactToDelete;

        Test.startTest();
        
        delete contactToDelete;
        Test.stopTest();
    }
}