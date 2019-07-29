@RestResource(urlMapping = '/accountInfo/*')

global class AccountInformation{
    
    @HttpGet
    global static Account getAccountInfo(){
        String accountId = RestContext.request.params.get('Id');
        system.debug('IIID '+accountId);
        Account acc = [SELECT Name, Owner.Name, Phone, Rating FROM Account WHERE Id =: accountId LIMIT 1];
        return acc;
        
    }
}