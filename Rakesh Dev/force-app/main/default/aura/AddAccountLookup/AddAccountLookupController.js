({
	handleOnSuccess : function(component, event, helper) {
        component.set("v.showSpinner", true);
    var record = event.getParam("response");
    var prodId = component.get("v.recordId");
    var action = component.get("c.linkRecords");
    action.setParams({ prodId : prodId, judgId: record.id});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var productRecord = component.get("v.productRecord");
                component.find("notificationsLibrary").showToast({
                    "title": "Saved",
                    "variant": "success",
                    "message": "Judgment {0} is added for Account {1}",
                    "messageData": [
                        {
                            
                            url: '/' + record.id,
                            label: '"'+record.fields.Name.value+'"'
                        },
                        {
                            
                            url: '/' + prodId,
                            label: '"'+productRecord.Name+'"'
                        }
                    ]
                });
                if($A.get("e.force:closeQuickAction ")){
                    $A.get('e.force:closeQuickAction ').fire();
                }
                component.set("v.showSpinner", false);        
            }
            else{
                var errorHandling = component.find("errorHandling");
                component.set("v.serverRespose",response);
                errorHandling.handleError();
            }
        });
    $A.enqueueAction(action);
    },
    saveJudgment:function(component, event, helper){
        component.find("recordViewForm").submit();
    }
})