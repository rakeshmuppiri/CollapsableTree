({
	saveAccountJudgmentRecord : function(component, event, helper) {
		var judgId = component.get("v.recordId");
        var selectedProducts = [];
        var nonSelectedProducts = [];
        var searchResults = component.get('v.searchResults');
         console.log('searchResults'+searchResults.length);
        for(var obj in searchResults){
            console.log('adding'+obj);
            if(searchResults[obj].isSelected == true){
                delete searchResults[obj]['isSelected'];
                selectedProducts.push(searchResults[obj]);
            }else{
                nonSelectedProducts.push(searchResults[obj]);
            }
        }
        
        if(!$A.util.isEmpty(selectedProducts)){
            var action = component.get("c.saveAccountJudgmentRecord");
            action.setParams({
                "AccountList" : selectedProducts,
                "contactId": judgId
            });
			action.setCallback(this, function(response) {
             var state = response.getState();
             if(state == 'SUCCESS'){
                 var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     "type": "success",
                     "title": "Success!",
                     "message": "Account added to Judgment successfully."
                 });
                 toastEvent.fire();
                 component.set('v.searchResults', nonSelectedProducts);
                 this.fetchLinkedAccounts(component);
                 
                 component.set('v.isDisabled',true);
                 component.set('v.showSpinner',false);
             }else{
                 var errorHandling = component.find("errorHandling");
                 component.set("v.serverRespose",response);
                 errorHandling.handleError();
             } 
            });
             $A.enqueueAction(action);
        }
	},
    fetchLinkedAccounts:function(component){
        var judgId = component.get("v.recordId");
        var action = component.get("c.fetchLinkedAccounts");
        action.setParams({
            "contactID" : judgId,
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state == 'SUCCESS'){
                component.set('v.existingLinkedAccounts', response.getReturnValue());
                component.set('v.showSpinner',false);
            }else{
                 var errorHandling = component.find("errorHandling");
                 component.set("v.serverRespose",response);
                 errorHandling.handleError();
             } 
        });
        $A.enqueueAction(action);
    }
})