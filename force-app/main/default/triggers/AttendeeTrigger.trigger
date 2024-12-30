trigger AttendeeTrigger on Attendee__c (before insert , before update, before delete, after insert, after update, after delete) 
{
    
    new AttendeeTriggerHandler().run();
    
    /*if(Trigger.isAfter)
    {
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete)
        {
            AttendeeTriggerHandler.updateContactSessionCount(Trigger.new, Trigger.old, Trigger.oldMap);
        }
    }*/

}