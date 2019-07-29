public class AddAccountLookupController {
    @AuraEnabled
    public static void linkRecords(Id contactID, Id AccountId){
       AccountContactRelation prodJudg = new AccountContactRelation();
        prodJudg.contactID = contactID;
        prodJudg.AccountId = AccountId;

        insert prodJudg;

    }
    
}