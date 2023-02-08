trigger SpeakerBookedCheck on EventSpeakers__c (before insert,before update) {
    //Get the Speaker Id and Event id for the current Speaker Event
    list<id> speakerId = new list<id>();
    list<id> eventId = new list<id>();
    for (EventSpeakers__c es:Trigger.new) {
    speakerId.add(es.Speaker__c);
    eventId.add(es.Event__c); 
    }
     Map<Id,DateTime> speakerBooking =new Map<Id ,DateTime>();
     //Get the Event Start Time of current Event for Speaker
     List<Event__c> eventTime = [Select Id,Start_DateTime__c from Event__c 
                                    where Id in :eventId];
    for(Event__c et :eventTime ) {
        speakerBooking.put(et.Id,et.Start_DateTime__c);
    }
    
    //Fetch all the Events for the Speaker
    list<EventSpeakers__c> speakerEvents = [Select Id, Event__c from EventSpeakers__c
                                           where Speaker__c in :speakerId
                                           and Event__c not in :eventId ];
    //If Speaker has more than one Events then check if there is any other Event with the same Start Date Time
    if(speakerEvents.size()>0)    {
        for(EventSpeakers__c spkevts : speakerEvents) {
            list<Event__c> Overlap = [Select Id,Name from Event__c
                                      where Id = :spkevts.Event__c
                                      and Start_DateTime__c = :eventTime[0].Start_DateTime__c];
            
             if(Overlap.size()>0){
                 for (EventSpeakers__c es:Trigger.new){    
                      es.Speaker__c.adderror('Speaker is already booked for other Event:' + Overlap[0].Name + ' at the sametime' );  
                  }
             }
         } 
        
       
      }
  }