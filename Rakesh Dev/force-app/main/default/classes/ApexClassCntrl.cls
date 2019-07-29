public class ApexClassCntrl{

    public PageReference save() {
        insert acc;
        return null;
    }


    public String number2 { get; set; }

    public String number1 { get; set; }
    public List<Account> accountList {set;get;}
    public Account acc {set;get;}
    
    public ApexClassCntrl(){
        acc = new Account();
        accountList = [SELECT Name FROM Account WHERE NAme != null ORDER BY CreatedDate DESC LIMIT 5];
    }
}