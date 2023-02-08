public class ErrorLogHandler {
    public static void doHandleException(system.exception ex, string moduleName){
        Transaction_Error_Log__c err_log = new Transaction_Error_Log__c();
        err_log.Log_Details__c =ex.getMessage()+'<br>'+ex.getCause()+'<br>'+ ex.getLineNumber()+'<br>'+ ex.getTypeName();    
        err_log.Object_Name__c =moduleName;
        insert err_log;
    }
}