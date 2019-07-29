({
	getGalleryImages: function(component, event, helper) {
        var resourceName = component.get("v.resourceName");
        var resourceType = component.get("v.resourceType");
        if($A.util.isEmpty(resourceName) || $A.util.isEmpty(resourceType)) return;
        var resourceUrl = $A.get('$Resource.'+resourceName);

        var action = component.get("c.getFileNames");
        action.setParams({  resourceName: resourceName,
                            resourceType: resourceType });

		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var images = response.getReturnValue().sort();
                var urls = [];
                for(var i=0; i<images.length; i++){
                    var url = images[i];
                    urls.push(url);
    			}
                if(images.length > 0){
    				component.set("v.images", urls);
				}
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error('error in loading gallery'+errors);
                if($A.get("e.force:showToast")){
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        type : "error",
                        message : "Could not fetch images"
                    });
                    resultsToast.fire();
                }
            }

        });
		$A.enqueueAction(action);
	},

	hideModal: function(component) {
	    $A.util.addClass(component.find("imageModal"), "slds-hide");
	},

	showModal: function(component, image) {
	    component.set("v.modal_image", image);
	    $A.util.removeClass(component.find("imageModal"), "slds-hide");
	}
})