trigger AccountTrigger on Account (before insert) {
    
    for(Integer i = 0; i < Trigger.old.size(); i++) {

    // On Account Name update, store old Account Name in "Old_Name__c" field

    if(Trigger.new[i].Name != Trigger.old[i].Name) {

      Account accountUpdate = [SELECT Id FROM Account WHERE Id = :Trigger.new[i].Id];

      

      accountUpdate.Name = Trigger.old[i].Name;
     // update accountUpdate;
    }

  }

}