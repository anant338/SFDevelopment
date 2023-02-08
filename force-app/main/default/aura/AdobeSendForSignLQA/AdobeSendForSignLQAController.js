({
	doInit : function(component, event, helper) {
        component.set("v.dontshowAlert",true);
        var urlEvent =$A.get("e.force:navigateToURL");
        let action = component.get("c.getAdobeSignPageUrl");
        var agreementTemplate ="a0q4x0000031L9NAAU";
        action.setParams({
            masterId: component.get("v.recordId"),
            templateId: agreementTemplate   
        });
        action.setCallback(this,function(response){
            console.log("adobeSignPageUrl:",response.getReturnValue());
            component.set("v.adobeSignPageUrl",response.getReturnValue());
            component.set("v.dontshowAlert",false);
            //var recId = component.get("v.recordId");
            urlEvent.setParams({
                "url":component.get("v.adobeSignPageUrl")
            });
                urlEvent.fire();
        });
        $A.enqueueAction(action);
	}
})