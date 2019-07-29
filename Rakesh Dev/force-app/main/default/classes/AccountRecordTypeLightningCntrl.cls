public class AccountRecordTypeLightningCntrl {
    public Map<String,Id> mapofCaseRecordTypeNameandId {set;get;}
    public AccountRecordTypeLightningCntrl(){
        String objectAPIName = 'Account' ; //any object api
        Schema.DescribeSObjectResult sobjectResult = Schema.getGlobalDescribe().get(objectAPIName).getDescribe();
        List<Schema.RecordTypeInfo> recordTypeInfo = sobjectResult.getRecordTypeInfos();
        mapofCaseRecordTypeNameandId = new Map<String,Id>();
        for(Schema.RecordTypeInfo info : recordTypeInfo){
            mapofCaseRecordTypeNameandId.put(info.getName(),info.getRecordTypeId());
        }
    }
}