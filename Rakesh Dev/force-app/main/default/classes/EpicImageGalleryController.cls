public with sharing class EpicImageGalleryController {
    
    @AuraEnabled
    public static List<String> getFileNames(String resourceName, String resourceType){
		List<String> urls = new List<String>();
        if(resourceType == 'Library'){
        	urls = getImagesFromLibrary(resourceName);
        }
        else if(resourceType == 'Static Resource'){
        	urls = getImagesStaticResourceZip(resourceName);
        }
        return urls;
	}
	public static List<String> getImagesStaticResourceZip(String resourceName){
		//String baseUrl = System.Url.getSalesforceBaseURL().toExternalForm();
		String baseUrl = System.Url.getOrgDomainUrl().toExternalForm();
        system.debug('resourceName'+resourceName);
		StaticResource resource = [SELECT Name, Body FROM StaticResource WHERE Name = :resourceName];
        
		Zippex sampleZip = new Zippex(resource.Body);
		Set<String> fileNames = sampleZip.getFileNames();
		List<String> urls = new List<String>();
		for (String fileName : fileNames) {
		    urls.add(baseUrl+'/resource/'+resourceName+'/'+fileName);
		}
		return urls;
	}
	public static List<String> getImagesFromLibrary(String resourceName){
		String baseUrl = System.Url.getSalesforceBaseURL().toExternalForm();
        system.debug(baseUrl+'resourceName ='+resourceName);
		Id folderId = [SELECT Id FROM ContentFolder WHERE Name = :resourceName LIMIT 1].Id;

		List<ContentFolderItem> folderItems = [	
			SELECT 	FileType, Id, Title 
			FROM 	ContentFolderItem
			WHERE 	ParentContentFolderId = :folderId
			AND 	FileExtension IN ('png','jpg')];

		Set<String> itemIds = new Set<String>();
		for(ContentFolderItem item : folderItems) itemIds.add(item.Id);

		List<ContentVersion> contentVersions = [
			SELECT 	ContentDocumentId, FileExtension, FileType, Id, Title 
			FROM 	ContentVersion
			WHERE 	IsLatest = true
			AND 	ContentDocumentId IN :itemIds
			ORDER BY Title ASC];

		List<String> urls = new List<String>();
		for (ContentVersion res  : contentVersions) {
		    urls.add(baseUrl+'/sfc/servlet.shepherd/version/renditionDownload?rendition=ORIGINAL_JPG&versionId='+res.Id);
		}
		return urls;
	}
}