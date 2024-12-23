trigger ContactTrigger on Contact (before insert, before update) 
{
	new TriggerHandlerClass().run();
}