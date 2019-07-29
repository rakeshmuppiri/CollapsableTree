public class searchAccountCustomCntrl {
         @AuraEnabled
    public static void saveAccountJudgmentRecord(List<Account> AccountList, Id contactId){

        List<AccountContactRelation> prodJudgList = new List<AccountContactRelation>();
        for(Account prod: AccountList){
            AccountContactRelation profJudg = new AccountContactRelation();
            profJudg.AccountId = prod.ID;
            profJudg.contactId = contactId;
            prodJudgList.add(profJudg);
        }
        if(! prodJudgList.isEmpty()){
            insert prodJudgList;
            //fetchLinkedAccounts();
        }
    }
    
    @AuraEnabled
    public static List<Account>   fetchLinkedAccounts(Id contactID){

        List<Id> prodIds = new List<Id>();
        for(AccountContactRelation accJudg : [SELECT Id,AccountId  FROM AccountContactRelation where contactID =: contactID]){
            prodIds.add(accJudg.AccountId);
        }
        system.debug('prodIds'+prodIds);
		List<Account> existingProdList = [SELECT 	Id,
                            		Name 
                           	FROM 
                            		Account 
                            WHERE Id IN: prodIds];
        return existingProdList;
    }
}