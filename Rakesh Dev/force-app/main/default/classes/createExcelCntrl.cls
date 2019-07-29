public class createExcelCntrl {
    public List<Account> accountList{set;get;}
    public integer totalAcc ;
    public createExcelCntrl(){
        accountList = [SELECT Id, Name from account limit 10];
        totalAcc = accountList.size();
    }
}