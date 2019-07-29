({
    
	submitForm:function(component, event, helper) {
        var newitem = component.get("v.newCampItem");
        var insertEvent = component.getEvent("addItem");
        insertEvent.setParams({ "item": newitem });
        insertEvent.fire();
    }
})