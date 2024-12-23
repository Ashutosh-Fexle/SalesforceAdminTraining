global class LeadProcessorScheduler implements Schedulable 
{
	global void execute(SchedulableContext ctx)
    {
        LeadProcessor batch = new LeadProcessor();
        
        Database.executeBatch(batch);
    }
}


/*
String sch = '0 21 16 20 12 ? 2024';
LeadProcessorScheduler lps = new LeadProcessorScheduler();
System.schedule('Schedule LeadProcessor', sch, lps);*/