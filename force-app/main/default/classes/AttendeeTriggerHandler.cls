/** 
*   Purpose         :   (Assignment) Create a Number field on Contact. populate the number of session for which contact is enrolled as attendee.
*
*   Created Date    :   9/12/24
*
*   Created By      :   Ashutosh Tiwari
*
*   Revision Logs   :   V_1.0   -   Created 
*
**/

public with sharing class AttendeeTriggerHandler extends TriggerHandler
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
    
    public static void updateContactSessionCount( List<Attendee__c> newList, List<Attendee__c> oldList, Map<Id , Attendee__c> oldMap ) 
    {
	Map<Id , Contact> mapOfContact = new Map<Id , Contact>();
        
            for (Attendee__c attendee : newList != null ? newList : oldList) 
            {
                

                Attendee__c oldAttendee =  oldMap != null ? oldMap.get(attendee.Id) : null ;
                if (attendee.LookupOfContactOnAttendee__c != null && attendee.Training_Session_Name__c != null && 
                    (newList == null || oldMap == null ||
                     (attendee.LookupOfContactOnAttendee__c != oldAttendee.LookupOfContactOnAttendee__c || 
                      attendee.Training_Session_Name__c != oldAttendee.Training_Session_Name__c)))
                		{
                            if(attendee.LookupOfContactOnAttendee__c != null)
                            {
                                mapOfContact.put(attendee.LookupOfContactOnAttendee__c, 
                                                 new contact(Id = attendee.LookupOfContactOnAttendee__c, Number_of_Sessions__c = 0));
                            }
                            if(oldAttendee != null && oldAttendee.LookupOfContactOnAttendee__c != null)
                            {
                                mapOfContact.put(oldAttendee.LookupOfContactOnAttendee__c, 
                                                 new Contact(Id = oldAttendee.LookupOfContactOnAttendee__c, Number_of_Sessions__c = 0));
                            }
                		}
            }
        


        if (!mapOfContact.isEmpty()) 
        {
            
            for (AggregateResult result : [SELECT LookupOfContactOnAttendee__c, COUNT_DISTINCT(Id) attendeeCount
                                            FROM Attendee__c
                                            WHERE LookupOfContactOnAttendee__c IN :mapOfContact.keySet()
                                            GROUP BY LookupOfContactOnAttendee__c]) 
            {
               Id ContactId = (Id)result.get('LookupOfContactOnAttendee__c');
               Integer totalattendeeCount = (Integer)result.get('attendeeCount');
               mapOfContact.put(ContactId, new Contact(Id = ContactId, Number_of_Sessions__c = totalattendeeCount));
            }
            
            if(!mapOfContact.values().isEmpty()){
                
                update mapOfContact.values();
            }
        }

        
    }
}