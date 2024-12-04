public class TrainingSessionManager {
    
    
    public static void demonstrationOfListSetMap()
    {
        //List<Integer> listOfIntegers = new List<Integer>{ 12 , 34 , 23 , 45 , 67 , 98 , 87 , 64 , 41 , 1 };
            
        //Map :-

        map<string , list<string>> departmentEmployee = new map<string , list<string>>();
        
        departmentEmployee.put('Sales',new List<string>{'ashutosh' , 'ashutosh1' , 'ashutosh2'});
        departmentEmployee.put('Account',new List<string>{'ashutosh' , 'ashutosh1' , 'ashutosh2'});
        
        System.debug('Department and Employee :' + departmentEmployee);


        //Set :- 
        
        set<string> set1 = new set<string>{'red' , 'blue' , 'green' , 'black'};
            
        set<string> set2 = new set<string>{'red' , 'blue' , 'violet' , 'orange' };
        
        
        // UNION 
        
        set<string> UnionSet = new set<string>(set1);
        UnionSet.addALL(set2);
		System.debug(UnionSet);


		//INTERSECTION
		set<string> IntersectionSet = new set<string>(set1);
		IntersectionSet.retainALL(set2);
		System.debug(IntersectionSet);

		//DIFFERENCE
		set<string> DifferenceSet = new set<string>(set1);
		DifferenceSet.removeALL(set2);
		System.debug(DifferenceSet);


        //List :- 
        
        
        list<Integer> NumberList = new list<Integer>{ 10 , 22 , 56 , 45 , 85 , 47 , 96 , 24 , 32 ,1 };
            
        System.debug('Original List :-' + NumberList);
        
        NumberList.sort();
        
        System.debug('Ascending Order :-' + NumberList);
    }
    
    
    //------------------------------- TASK-1 ----------------------------------------------------
    
public static void createSessionRecord(List<Training_Session_c__c> listToInsert){

// Create a new sObject TrainingSession of the type Training_session_c__c and create its new instance using "new" Keyword .
//Training_Session_c__c TrainingSession = new Training_Session_c__c();        
//In this RHS are the parameters that are passed to this method and LHS is the fields of the object Training_session_c__c in salesforce . 

//Training_Session_c__c trainingSession = new Training_Session_c__c(Name = trainingSessionName ,
//  									Session_Date_c__c = trainingSessionDate ,Location__c = trainingSessionLocation);

//Insert the record in the Database from the memory 
//insert trainingSession;
//System.debug('Record Id :- ' + trainingSession.Id);
    try
    	{
			insert listToInsert;
        	System.debug('Records :- ' + listToInsert.size());
        }
    catch(exception e)
    	{
        	System.debug('exception :-' + e.getMessage());
    	}
}



public static void readSessionRecord(){

//List<Training_Session_c__c> GetTrainingSession = new List<Training_Session_c__c>(); 

//List<Training_Session_c__c> GetTrainingSession = new List<Training_Session_c__c>{[SELECT Id , Name , Session_Date_c__c FROM Training_Session_c__c]};

//List<Training_Session_c__c> GetTrainingSession = [SELECT Id , Name , Session_Date_c__c FROM Training_Session_c__c];

List<Training_Session_c__c> GetTrainingSession = new List<Training_Session_c__c>([SELECT Id , Name , Session_Date_c__c 
FROM Training_Session_c__c 
WHERE Session_Date_c__c > TODAY]);

System.debug(GetTrainingSession);
}



public static void updateSessionRecord(){
  
    //METHOD-1 :- If particular ID is given .
    
/*
Training_Session_c__c session = new Training_Session_c__c();
session.Id = RecordId; // this id comess from the method
session.Location__c = 'Google Office';

update session ;
*/
    
    
    //METHOD-2 :- If multiple Id's were given 
    // In this passing parameter will change from "String RecordId" to "List<Training_Session_c__c" .
 try
 {
	List<Training_Session_c__c> listToUpdate = new List<Training_Session_c__c>([SELECT Id, Name FROM Training_Session_c__c WHERE Name LIKE 'Session%']);
     System.debug(listToUpdate.size());
	for(Training_Session_c__c var : listToUpdate)
	{
		var.Name = 'Updated'  + var.Name;
	}
 	update listToUpdate;
 }
 catch(exception e)
 {
     System.debug('Exception :-' + e.getMessage());
 }
}



public static void deleteSessionRecord(){

    try{
        List<Training_Session_c__c> recordToDelete = new List<Training_Session_c__c>([SELECT Id FROM Training_Session_c__c WHERE Name LIKE '%Session%']);
		Delete recordToDelete;
    }
    catch(exception e){
        System.debug('Exception :-' + e.getMessage());
    }
}    



    //--------------------------------------------- TASK-2 --------------------------------------------------------
    
    
    /*
public static void addAttendees(Id recordID , String recordName , Email__c recordEmail){

Set<Attendee__c> attendees = new Set<Attendee__c>([SELECT Id , Name ,Email__c FROM Attendee__c ]);

Set<Attendee__c> Record = new Set<Attendee__c>(Id=recordID , Name=recordName , Email__c=recordEmail);

attendees.addALL(Record);
}*/
    
    public static void addAttendee(){
        
        List<Training_Session_c__c> sessionRecord = new List<Training_Session_c__c>([SELECT Id , Session_Date_c__c FROM Training_Session_c__c WHERE Session_Date_c__c > Today]);
        
        
        Set<Attendee__c> attendeeForSession = new Set<Attendee__c>{
                                              new Attendee__c(Name='Ashutosh',Email__c='dfdsafds@gmail.com',Attendee_Name__c=sessionRecord[0].Id),
                                              new Attendee__c(Name='Ashtosh',Email__c='dfdsafds@gmail.com',Attendee_Name__c=sessionRecord[0].Id),
                                              new Attendee__c(Name='Abhishek',Email__c='ddsafds@gmail.com',Attendee_Name__c=sessionRecord[0].Id)
        };
            
            if(!attendeeForSession.isEmpty()){
                List<Attendee__c> newAttendee = new List<Attendee__c>();
                newAttendee.addAll(attendeeForSession);
                
                insert(newAttendee);
                System.debug(newAttendee.size());

            } 
    } 
    
    
    //------------------------------------------------------- TASK-3 ---------------------------------------------------------------------
    
    
    
    public enum TrainingSession {
        WEBINAR,
            WORKSHOP,
            SEMINAR
            }
    
    public static void sessionTrainee(){
        
        List<Training_Session_c__c> session = new List<Training_Session_c__c>{
            new Training_Session_c__c(Name='Session1',Session_Date_c__c=System.Today().addDays(5), RecordTypeId = '012NS000002C4t7YAC', Session_type__c=TrainingSessionManager.TrainingSession.WEBINAR.Name()),
            new Training_Session_c__c(Name='Session2',Session_Date_c__c=System.Today().addDays(6),RecordTypeId = '012NS000002C51BYAS', Session_type__c=TrainingSessionManager.TrainingSession.WORKSHOP.Name())
        };
            
         insert session;
    }
    
    
    
    
    
    
    //------------------------------------------------------- TASK-4 ---------------------------------------------------------------------
    
    
    public static void 	getSessionAndAttendeeRecords(){
        
        List<Training_Session_c__c> sessionRecord = new List<Training_Session_c__c>(
            [
                SELECT Id , Name,  
                (SELECT Id , Name FROM Attendees__r)
                FROM Training_Session_c__c
            ]
        );
        
        for(Training_Session_c__c sess : sessionRecord)
        {
            System.debug(sess?.Name)  ;
        }
    }
    
    
    
    //------------------------------------------------------- TASK-5 ---------------------------------------------------------------------
        
    public static void getRecords(){
        List<Training_Session_c__c> trainingRecords = new List<Training_Session_c__c>([
            										  SELECT Id , Name ,
            												(SELECT Id,Name FROM Attendees__r )
            										  FROM Training_Session_c__c
        ]);
        
        System.debug(trainingRecords);
    }
    
    //------------------------------------------------------- TASK-6 ---------------------------------------------------------------------
    
    // Q) How to add exception handling in the above code of Task-1 .
    
}