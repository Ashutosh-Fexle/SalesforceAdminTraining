@isTest
private class LeadProcessorTest 
{
    @testSetup
    static void setupTestData() 
    {
        List<Lead> leadsToInsert = new List<Lead>();
        System.debug('leadsToInsert: '+leadsToInsert);

        for (Integer i = 0; i < 50; i++) 
        {
            leadsToInsert.add(new Lead(FirstName = 'Test', LastName = 'Lead' + i, Company = 'Test Company' + i));
        }
        System.debug('leadsToInsert: '+leadsToInsert);

        insert leadsToInsert;
    }

    
    
    @isTest
    static void testLeadProcessorBatch() 
    {
        Map<Id, Lead> leadsBeforeBatch = new Map<Id, Lead>([SELECT Id, LeadSource FROM Lead WHERE LeadSource != 'Dreamforce']);
        System.assertEquals(50, leadsBeforeBatch.size(), 'All Leads should be in initial state.');
        System.debug('Lead Records: '+leadsBeforeBatch);

        List<Id> leadIds = new List<Id>(leadsBeforeBatch.keyset());
        System.debug('Initial leadIds: '+leadIds);

        
        System.debug('Filled leadIds: '+leadIds);

        Test.startTest();

            System.debug('Calling the Batch Class .');
            
            LeadProcessor batch = new LeadProcessor();
            Database.executeBatch(batch);
            
            System.debug('Called the Batch Class.');

        Test.stopTest();

        List<Lead> leadsAfterBatch = [SELECT Id, LeadSource FROM Lead];
        System.debug('leadsAfterBatch: '+leadsAfterBatch);

        for (Lead lead : leadsAfterBatch) 
        {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to Dreamforce.');
        }
    }
}