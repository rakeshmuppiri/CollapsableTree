({
    handleCancel : function(component, event, helper) {
        if($A.get("e.force:closeQuickAction ")){
            $A.get('e.force:closeQuickAction ').fire();
        }
    }
})