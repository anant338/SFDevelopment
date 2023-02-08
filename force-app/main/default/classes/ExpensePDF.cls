public class ExpensePDF {
    public Expense__c Expense {get;set;}
    
    public string CurrentId;
    public ExpensePDF(){
        CurrentId=apexpages.currentpage().getparameters().get('id');
        this.Expense =[Select Id,Name from Expense__c
                      Where Id =:CurrentId];
       
    }

}