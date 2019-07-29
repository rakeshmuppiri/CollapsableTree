public class CampingListController {
	@AuraEnabled
    public static List<Camping_Item__c> getItems() {
        return [SELECT Id, Name, Price__c, Quantity__c, Packed__c
                FROM Camping_Item__c];
    }
    
    @AuraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c camp) {
        upsert camp;
        return camp;
    }
}