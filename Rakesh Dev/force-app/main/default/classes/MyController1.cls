global class MyController1 implements Schedulable{
    private final Account acc;
    public String Name;
    public String site;
    private Apexpages.StandardController controller;
    global void execute(SchedulableContext sc){}
    public MyController1(){
     try{
             Id aid = ApexPages.currentPage().getParameters().get('Id');
             acc  = [SELECT id, name, site FROM Account where id =: aid];
       }catch(Exception e){}
          
    }
     public Account getAcc(){
            return acc;
     }
     
         public PageReference save(){
        Account acco = new Account(); 
        acco.Name=ApexPages.currentPage().getParameters().get('accname');
          acco.site=ApexPages.currentPage().getParameters().get('Account.site');
           insert acco;   
            return (new pagereference('/'+acco.id)); 
         }    
           
}