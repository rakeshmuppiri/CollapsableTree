({
	doInit : function(component, event, helper) {
		helper.getGalleryImages(component, event, helper);
	},
	openImg: function(component, event, helper) {
	    helper.showModal(component, event.target.src);
	},
	closeImg: function(component, event, helper) {
	    helper.hideModal(component, event.target.src);
	},
})