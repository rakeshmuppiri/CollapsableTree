({
    handleAddItem : function(component, event, helper) {
        var newItem = event.getParam("item");
        helper.createItem(component, newItem);
    },
    doInit: function(component, event, helper) {

        // Create server request
        var action = component.get("c.getItems");
    	
        // Send server request
        $A.enqueueAction(action);
        
        // Handle server response
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });      
    },
    
     clickCreateCamping: function(component, event, helper) {

        // Simplistic error checking
        var validExpense = true;

        // Name must not be blank
        var nameField = component.find("campName");
        var campName = nameField.get("v.value");
        if ($A.util.isEmpty(campName)){
            validExpense = false;
            nameField.set("v.errors", [{message:"Expense name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
        
        // price  must not be blank
        var priceField = component.find("price");
        var price = priceField.get("v.value");
        if ($A.util.isEmpty(price)){
            validExpense = false;
            priceField.set("v.errors", [{message:"Expense name can't be blank."}]);
        }
        else {
            priceField.set("v.errors", null);
        }
		
        // quantity  must not be blank
        var quantityField = component.find("quantity");
        var quantity = quantityField.get("v.value");
        if ($A.util.isEmpty(quantity)){
            validExpense = false;
            quantityField.set("v.errors", [{message:"Expense name can't be blank."}]);
        }
        else {
            quantityField.set("v.errors", null);
        }

        // ... hint: more error checking here ...

        // If we pass error checking, do some real work
        if(validExpense){
            // Create the new expense
            var newCamping = component.get("v.newItem");
            //helper.createCamp(component, newCamping);
            var action = component.get("c.saveItem");
            action.setParams({
                "camp": newCamping
            });
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
            
			/*
            var campingList = component.get("v.items");
            campingList.push(newCamping);
            component.set("v.items",campingList);
            */
    
            
        }
    }
})