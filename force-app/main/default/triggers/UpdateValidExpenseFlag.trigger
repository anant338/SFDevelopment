trigger UpdateValidExpenseFlag on Expense_Type__c (after update) {
    list<Expense__c> Ex_V1,Ex_V,Ex_NV,Ex_NV1,Ex_NV2 = new list<Expense__c>();

    for (Expense_Type__c et:Trigger.new) {
        Date StartDate = et.Start_Date__c;
        Date EndDate = et.End_Date__c;
        
   //Update Valid Flag if Expense Date is between Start Date and End Date     
    if  (StartDate!=NULL && EndDate!=NULL) {
    Ex_V = [SELECT id,Valid__c from Expense__c where Expense_Type__c = :et.id 
                          AND Expense_Date__c >= :StartDate 
                          AND Expense_Date__c <= :EndDate ] ;
                          
    Ex_NV = [SELECT id,Valid__c from Expense__c where Expense_Type__c = :et.id 
                          AND (Expense_Date__c < :StartDate 
                          OR Expense_Date__c > :EndDate) ] ;  
   for (Expense__c EX_l : Ex_V) {
        EX_l.Valid__c =True;
    }   
        
   for (Expense__c EX_l : Ex_NV) {
        EX_l.Valid__c =False;
    }
   update Ex_V; 
   update Ex_NV;
    } 
     //Update Valid Flag if  End Date Null
      
    if  (StartDate!= NULL && EndDate == NULL) {
    Ex_V1 = [SELECT id,Valid__c from Expense__c where Expense_Type__c = :et.id 
                          AND Expense_Date__c >= :StartDate ] ;
                          
    Ex_NV1 = [SELECT id,Valid__c from Expense__c where Expense_Type__c = :et.id 
                          AND Expense_Date__c < :StartDate ] ;
        
     for (Expense__c EX_l : Ex_V1) {
        EX_l.Valid__c =True;
    }  
    
         
    for (Expense__c EX_l : Ex_NV1) {
        EX_l.Valid__c =False;
    } 
    update Ex_V1;  
    update Ex_NV1;    
    }
     
   //Update Valid Flag to False if Start Date is Null
    if  (StartDate== NULL) {
    Ex_NV2 = [SELECT id,Valid__c from Expense__c where Expense_Type__c = :et.id] ;
    
    for (Expense__c EX_l : Ex_NV2) {
        EX_l.Valid__c =False;
    } 
    update Ex_NV2;    
     }  
  
     } 
   
    
}