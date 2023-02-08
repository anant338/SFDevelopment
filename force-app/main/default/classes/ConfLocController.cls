global with sharing class ConfLocController {
    //use RemoteAction so that this function can be called from Javascript
    @RemoteAction
    global static list<Conference__c> ConferenceList() {
       return [Select id,Conference_Location__c,Location__latitude__s,Location__longitude__s from Conference__c ];
    }

}