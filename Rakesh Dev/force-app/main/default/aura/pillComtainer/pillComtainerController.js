({
	fireToEmailClick : function(component, event, helper) {
		var toEmailField = component.find("mailDivForToEmail");
        $A.util.addClass(toEmailField, 'focusBorder');
	}
})