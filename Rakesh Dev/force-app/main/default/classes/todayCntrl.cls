public class todayCntrl {

    public todayCntrl(ApexPages.StandardController controller) {

    }
    public list<Account> ListAcc {set;get;}
    
    public list<Account> getListAcc(){
        list<Account> Lacc = [SELECT ID, Name From Account LIMIT 10];
        system.debug('----'+Lacc);
        return Lacc;
    }
    public PageReference DelAcc(){
    return null;
    }

}