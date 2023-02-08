public class adobeSignController {
    @AuraEnabled
    public static string getAdobeSignPageUrl(String masterId,String templateId){
        Pagereference pg = Page.echosign_dev1__AgreementTemplateProcess;
        pg.getParameters().put('masterId',masterId);
        pg.getParameters().put('templateId',templateId);
        return pg.getUrl();
    }

}