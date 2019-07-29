public class CallAnotherOrg{
    @future(callout=true)
    public static void callingFromHere(id s){ 
      
      Account acc = [select Id,Name from Account where id=:s];         
      soapSforceComSchemasClassIntegratio.integrationwebclass iwc =new soapSforceComSchemasClassIntegratio.integrationwebclass();
      
      iwc.SessionHeader = new soapSforceComSchemasClassIntegratio.SessionHeader_element();
      enterpriseSoapSforceCom.Soap sp = new enterpriseSoapSforceCom.soap();
        String username = 'rakesh_muppiri@sfdc.com';
        String password = 'R@kesh561';
        enterpriseSoapSforceCom.LoginResult loginResult = sp.login(username, password);
        iwc.SessionHeader.sessionid=loginResult.sessionid;
        string str =iwc.createmethod(acc.name);
        
        system.debug('accountname@@@@@@:'+str);
    }
    
}