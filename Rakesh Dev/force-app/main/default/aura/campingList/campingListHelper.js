({
    createItem :function(component, camp) {
        var action = component.get("c.saveItem");
        action.setParams({
            "camp": camp
        });
        $A.enqueueAction(action);
        action.setCallback(this, function(response){
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
               
            }
            else 
                console.log("Unknown error");
        });
        component.set("v.newCampItem",{ 'sobjectType': 'Camping_Item__c',
                    'Name': '',
                    'Vlabs__Price__c': 0,
                    'Vlabs__Quantity__c': 0,
                    'Vlabs__Packed__c': false });
    },
    
        createCamp : function(component, camp) {
            var action = component.get("c.saveItem");
            action.setParams({
                "camp": camp
            });
            alert(camp.Price__c);
             alert(camp.Quantity__c);
            $A.enqueueAction(action);
            action.setCallback(this, function(response){
                var state = response.getState();

                if (component.isValid() && state === "SUCCESS") {
                    var ListCamps = component.get("v.items");
                    ListCamps.push(response.getReturnValue());
                    component.set("v.items", ListCamps);
                }
                else{
                   
                     var errors = response.getError();
                if (errors) {
                    alert(errors[0].message);
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }

                }
            });
            
    	},
})