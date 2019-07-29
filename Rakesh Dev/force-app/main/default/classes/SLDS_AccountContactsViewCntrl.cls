public class SLDS_AccountContactsViewCntrl{
    public Account acc{set;get;}
    public Blob contentfile{set;get;}
    public List<Contact> censusMembersList{set;get;}
    public List<HeaderInfo> headers {set;get;}
    string query = 'SELECT Id';
    public class HeaderInfo{
        public String name {set;get;}
        public String label{set;get;}
        public Boolean isCalculated {set;get;}
        public HeaderInfo(String label, String name, Boolean isCalculated){
            this.label = label;
            this.name = name;
            this.isCalculated = isCalculated;
        }
    }
    public void saveCensusMember(){
    }
    public Id accId{set;get;}
    string sObjectName = 'Contact';
    public SLDS_AccountContactsViewCntrl(){
    headers =  new List<HeaderInfo>();
        accId = ApexPages.currentPage().getParameters().get('Id');
        acc = [SELECT Id, Name, Phone, AccountNumber, AccountSource FROM Account WHERE Id =: accId LIMIT 1];
        
        List<Schema.DescribeSObjectResult> des = Schema.describeSObjects(new String[]{sObjectName});
        Schema.DescribeSObjectResult cenMem = des[0];
        List<Schema.FieldSetMember> fields = cenMem.fieldSets.getMap().get('Vlabs__Censes_member').getFields();
        for (Schema.FieldSetMember field : fields){

            HeaderInfo temp = new HeaderInfo(field.getLabel(), field.getFieldPath(), Schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap().get(field.getFieldPath()).getDescribe().isCalculated());
            headers.add(temp);
        }
        
        for(HeaderInfo obj : headers){
            query = query+', '+obj.name;
        }
        query = query+' FROM Contact WHERE AccountId =\''+accId+'\'';
        censusMembersList = (List<Contact>)Database.query(query);
        
        //censusMembersList = [SELECT Id, Vlabs__Date__c , Birthdate,FirstName, LastName, Title, Email, Vlabs__city__c, Vlabs__State__c, Vlabs__Country__c  FROM Contact WHERE AccountId =: acc.Id];
    }
    public void refreshDate(){
        loadContacts();
    }
    public Integer actionIndex {set;get;}
    public void deleteCensusMember(){
        Contact temp = censusMembersList[actionIndex];
        if(temp.Id != null)
            delete temp;
        censusMembersList.remove(actionIndex);
    }
    public void loadContacts(){
        censusMembersList = (List<Contact>)Database.query(query);
        
    }
    public void addCensusMember(){
        system.debug('aaaa');
        Contact temp = new Contact();
        censusMembersList.add(temp);
        system.debug('bbb'+censusMembersList.size());
    }
}