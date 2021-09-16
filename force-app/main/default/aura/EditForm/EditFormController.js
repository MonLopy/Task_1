({

    handleSubmit: function(component, event, helper) {
        event.preventDefault();       // stop the form from submitting
        var fields = event.getParam('fields');
        component.find('editForm').submit(fields);
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "https://playful-raccoon-geo70l-dev-ed.lightning.force.com/lightning/o/Customer_report__c/list?filterName=00B0900000KxbdlEAB"
        });
        helper.showToast('Success !', 'Record Inserted Successfully', 'success');

        urlEvent.fire();

    },
    handleSuccess: function(component, event) {
        var updatedRecord = JSON.parse(JSON.stringify(event.getParams()));
        console.log('onsuccess: ', updatedRecord.id);

    }


})