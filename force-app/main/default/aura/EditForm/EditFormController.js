({
    handleSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "variant": "success",
            "title": "Customer_report__c",
            "message": "Record ID: " + event.getParam("id")
        });
        toastEvent.fire();
    }
})