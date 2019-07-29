({
    doInit : function(component, event, helper) {
        // Prepare a new record from template
        component.set("v.Spinner", true);
        component.find("leadRecordCreator").getNewRecord(
            "Lead", // sObject type (objectApiName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newLead");
                var error = component.get("v.newLeadError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                    return;
                }
                console.log("Record template initialized: " + rec.sobjectType);
            })
        );
		
        setTimeout(function(){ 
         
        helper.fetchPickListVal(component, 'LeadSource', 'leadSource');
        helper.fetchPickListVal(component, 'Status', 'leadStatus');
        helper.fetchPickListVal(component, 'Salutation', 'leadSalutation');
        helper.fetchPickListVal(component, 'Industry', 'leadIndustry');
        helper.fetchPickListVal(component, 'Rating', 'leadRating');
		helper.fetchPickListVal(component, 'Corporate_Language__c', 'leadCorpLang');
        helper.fetchPickListVal(component, 'Monitoring_Trust_Status__c', 'leadMonTrustStatus');
        helper.fetchPickListVal(component, 'CurrencyIsoCode', 'leadcurrency');
        helper.fetchPickListVal(component, 'Services_of_Interest__c', 'serviceOfInterest');
        helper.fetchPickListVal(component, 'Type_of_Debtors__c', 'leadTypeOfDebtors');
            component.set("v.Spinner", false);
            console.log('loaded1');
        }, 100);
    },
     handleSaveLead : function(component, event, helper) {
         if(component.get("v.newLeadFields.LastName") == '' || component.get("v.newLeadFields.LastName") == null){
             component.set("v.newLeadFields.LastName", 'Unknown');
         }
        component.find("leadRecordCreator").saveRecord($A.getCallback(function(saveResult) {
            console.log('saveResult'+JSON.stringify(saveResult));
             if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved.",
                        "type":"success"
                    });
                    resultsToast.fire();

                var sObjectEvent = $A.get("e.force:navigateToSObject");
                sObjectEvent.setParams({
                    "recordId": saveResult.recordId,
                    "slideDevName": "detail"
                });
                sObjectEvent.fire();
/*
                 var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": saveResult.recordId
        });
        editRecordEvent.fire();
                 */
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
				var errMsg = '';
                for(var msg in saveResult.error) {
					errMsg+=JSON.stringify(saveResult.error[msg].message);
                }
                errMsg = errMsg.replace('\\n','');
                var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Error",
                        "message": errMsg,
                        "type":"error"
                    });
                    resultsToast.fire();
                
            } else {
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        }));
    },
    closeModel: function(component, event, helper) { 
      window.location = "/lightning/o/Lead/list";
      /*
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Lead"
        });
        createRecordEvent.fire();
        */
    }
})