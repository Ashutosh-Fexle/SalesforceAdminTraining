@isTest
private class AttendeeTriggerHandlerTest
{
    @TestSetup
    static void makeData()
    {
        List<Attendee__c> listOfAttendee = new List<Attendee__c>();

        for(Integer i=1;i<=10;i++)
        {
            listOfAttendee.add(new Attendee__c(Name='Test'+i,Training_Session_Name__c= 'Apex Training'));
        }

        insert listOfAttendee;

        List<Training_Session__c> listOfTrainingSession = new List<Training_Session__c>();

        for(Integer i=11;i<=12;i++)
        {
            listOfTrainingSession.add(new Training_Session__c(Name='Training'+i));
        }

        insert listOfTrainingSession;

        List<Contact> listOfContact = new List<Contact>();

        for(Integer i=11;i<=15;i++)
        {
            listOfContact.add(new Contact(FirstName='Test', LastName='Contact'+i));
        }

        insert listOfContact;

    }

    @isTest
    static void testAttendeeTrigger()
    {
        List<Attendee__c> listOfAttendee = [SELECT Id, Name, Training_Session_Name__c
                                            FROM Attendee__c
                                            WHERE Name Like 'Test%'];
        System.assertEquals(10, listOfAttendee.size(),'Size should be 10');

        List<Training_Session__c> listOfTrainingSession = [SELECT Id, Name
                                                            FROM Training_Session__c
                                                            WHERE Name Like 'Training%'];
        System.assertEquals(2, listOfTrainingSession.size(),'Size should be 2');

        listOfAttendee[1].Training_Session_Name__c=listOfTrainingSession[0].Name;
        listOfAttendee[3].Training_Session_Name__c=listOfTrainingSession[1].Name;

        Test.startTest();

        update listOfAttendee;

        Test.stopTest();

        List<Contact> updatedContacts = [SELECT Id, Name, Number_of_Sessions__c FROM Contact WHERE LastName LIKE '%Contact%'];
        Assert.areEqual(0,updatedContacts[0].Number_of_Sessions__c);
        Assert.areEqual(2,updatedContacts[1].Number_of_Sessions__c);
        Assert.areEqual(1,updatedContacts[2].Number_of_Sessions__c);
    }
}