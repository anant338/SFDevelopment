trigger ChildTrigger on Child__c (before insert, before update) {

  /*

    Implement a roll up summary calculation on the Number field Child_Number__c 

    from child object Child__c to Parent__c of all children from within a Trigger. 

    Store the roll up summary calculation onto the Parent__c field Child_Number_Sum__c

  */
 
     list<Id> ParentId = new list<id>();
     for(Child__c childList : Trigger.new){
     parentId.add(childList.Parent__c);
      }

   list<Parent__c> parentList =[Select Id,Child_Number_Sum__c,(Select Child_Number__c  from Child__r) 
                                from Parent__c where Id in  :parentId ];

   if(parentList.size()>0){
      for(Parent__c parent :parentList ){
          Decimal childSum =0;
          for(Child__c child :parent.Child__r) {
             if( child.Child_Number__c == Null){
                  child.Child_Number__c = 0;
               }
                childSum =childSum + child.Child_Number__c  ;
            }
                parent.Child_Number_Sum__c =childSum;
           }    
                update parentList;


  }

}