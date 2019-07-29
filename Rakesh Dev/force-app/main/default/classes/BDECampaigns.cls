public class BDECampaigns {

    public BDECampaigns(ApexPages.StandardController controller) {
        EditKey = new Map<String, String>();
        BDEMapId = new Map<String, Id>();
        recordsToEdit = new  map<string,Map<String, Resource_Tracker__c>>();
        AllrecKey = new   List<WrapperForEdit>();
        fullRecordURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' ;
        InputResourceMap = new Map<String,Resource_Tracker__c>();
        
        bMap=new map<string,map<string,string>>();
        bMapId=new map<string,map<string,Id>>();
        keyMap=new map<string,wrapperCls>();
        LoadBDECampaigns();
    }


    public PageReference Del(){
        String filterkey = AllrecKey.get(index).key;
    
         String AMorPM = filterkey.substring(19, 21);
         String [] DateToEdit = filterkey.substring(0, 10).split('-');
         system.debug('111'+DateToEdit);
         Date AcDateToEdit = date.parse(DateToEdit[2]+'/'+DateToEdit[1]+'/'+DateToEdit[0]);
         List<Resource_Tracker__c > temp = [SELECT id FROM Resource_Tracker__c WHERE Date__c=: AcDateToEdit AND AM_PM__c=: AMorPM];
         delete temp;
          system.debug('ddd11'+temp);
         //AllrecKey
         //AllrecKey.remove();
         AllrecKey = new   List<WrapperForEdit>();
          system.debug('ddd22'+AllrecKey);
        LoadBDECampaigns();
        system.debug('ddd22'+AllrecKey);
        return null;
    }


    public PageReference Save() {
        String filterkey = AllrecKey.get(index).key;
        EditKey.remove(filterkey);
        List<Resource_Tracker__c> ListRes = new List<Resource_Tracker__c>();
        system.debug('SSS'+recordsToEdit);
        system.debug('FFF'+filterkey);
        map<string,Resource_Tracker__c > sMap=recordsToEdit.get(filterkey);
        for(String s : sMap.keySet()){
            //for(Resource_Tracker__c temp: sMap.get(s)){
            if(sMap.get(s)!= null)
                if(sMap.get(s).Campaign__c != null)
                    ListRes.add(sMap.get(s));
            //}
            
        }
        if(!ListRes.isEmpty())
            upsert ListRes;
        Cancel(); 
        recordsToEdit.remove(filter);
        AllrecKey = new   List<WrapperForEdit>();
        LoadBDECampaigns(); 
        return null;
    }

    public String filter{set;get;}
    
    public PageReference Cancel() {
        String filterkey = AllrecKey.get(index).key;
        recordsToEdit.remove(filterkey);
        for(WrapperForEdit temp: AllrecKey){
         if(temp.key == filterkey)
             temp.Edit = false;
        }
        AllrecKey = new   List<WrapperForEdit>();
        LoadBDECampaigns();
        return null;
    }
     
    public PageReference EditRes() { 
    String filterkey =  AllrecKey.get(index).key;
    EditKey.put(filterkey,filterkey);
     String AMorPM = filterkey.substring(19, 21);
     String [] DateToEdit = filterkey.substring(0, 10).split('-');
     system.debug('111'+DateToEdit);
     Date AcDateToEdit = date.parse(DateToEdit[2]+'/'+DateToEdit[1]+'/'+DateToEdit[0]);
     
     for(Resource_Tracker__c b : [SELECT id,Date__c, AM_PM__c, BDE__c,BDE__r.Name,Campaign__r.Name, Campaign__c FROM Resource_Tracker__c WHERE Date__c=: AcDateToEdit AND AM_PM__c=: AMorPM order by Date__c DESC]){
        //filterkey = b.Date__c+b.AM_PM__c;
         if(recordsToEdit.containsKey(filterkey)){
                recordsToEdit.get(filterkey).put(b.BDE__r.Name,b);
            }else{
                map<string,Resource_Tracker__c > sMap=new map<string,Resource_Tracker__c >();
                sMap.put(b.BDE__r.Name,b);
                recordsToEdit.put(filterkey,sMap);
                
            }
     }
     
     for(WrapperForEdit temp: AllrecKey){
         if(temp.key == filterkey)
             temp.Edit = true;
     }
     for(string s: recordsToEdit.keySet()){
            for(string d:ListBDE){
                if(!recordsToEdit.get(s).containsKey(d)){
                    Resource_Tracker__c temp = new Resource_Tracker__c();
                    temp.Date__c = AcDateToEdit;
                    temp.AM_PM__c = AMorPM;
                    temp.BDE__c= BDEMapId.get(d);
                    system.debug('CCC'+temp);
                    
                    recordsToEdit.get(s).put(d,temp);
                }        
            }
      }
        system.debug('222'+recordsToEdit);
        return null;
    }
     Map<String, Id> BDEMapId {set;get;}
    Map<String, String> EditKey{set;get;}
    public  map<string,Map<String, Resource_Tracker__c>> recordsToEdit{set;get;}
    public String checkName { get; set; }
    public set<string> ListBDE {set;get;}
    public Set<String> BDEs {set;get;}
    public map<string,map<string,string>> bMap{get;set;}
    public map<string,map<string,Id>> bMapId{get;set;}
    public map<string,wrapperCls> keyMap{get;set;}
    public list<Resource_Tracker__c> bdeCamp{get;set;}
    map<date,map<string,set<id>>>dateMap=new map<date,map<string,set<id>>>();
    public map<string,Resource_Tracker__c> bdeMap{get;set;}
    public Map<String, Id> CampIdMap{set;get;}
    public Integer index{set;get;}
    public Map<String ,Resource_Tracker__c> InputResourceMap{set;get;}
    
    public void LoadBDECampaigns(){
            ListBDE = new set<string>();
            BDEs = new Set<String>();
            bdeMap=new map<string,Resource_Tracker__c>();
            CampIdMap = new Map<String, Id>();
        
        for(Resource_Tracker__c b : [SELECT id,Date__c, AM_PM__c, BDE__c,BDE__r.Name,Campaign__r.Name, Campaign__c FROM Resource_Tracker__c order by Date__c DESC]){
            
            BDEMapId.put(b.BDE__r.Name, b.BDE__c);
            system.debug('DDD'+b.Date__c);
            string key=b.Date__c+b.AM_PM__c;
            //string inputKey = b.Date__c+b.AM_PM__c+b.BDE__r.Name;
            InputResourceMap.put(b.Campaign__c , b);
            BDEs.add(key);
            
            ListBDE.add(b.BDE__r.Name);
            if(bMap.containsKey(key)){
                bMap.get(key).put(b.BDE__r.Name,b.Campaign__r.Name);
            }else{
                map<string,string> sMap=new map<string,string>();
                sMap.put(b.BDE__r.Name,b.Campaign__r.Name);
                bMap.put(key,sMap);
                
            }
            
            if(bMapId.containsKey(key)){
                bMapId.get(key).put(b.BDE__r.Name,b.Campaign__c);
            }else{
                map<string,string> sMap=new map<string,string>();
                sMap.put(b.BDE__r.Name,b.Campaign__c);
                bMapId.put(key,sMap);                
            }
            
            if(!keyMap.containsKey(key)){
               keyMap.put(key,new wrapperCls(b.date__c,b.AM_PM__c,b));
            }
            if(!CampIdMap.containsKey(b.Campaign__r.Name))
                CampIdMap.put(b.Campaign__r.Name, b.Campaign__c);
        }
        Integer tempindex = 0;
        for(String s : BDEs){
            system.debug('SSS'+s);
            system.debug('Filter'+filter);
            if(recordsToEdit.get(s) == null){//if(s != filter){ 
                WrapperForEdit temp = new WrapperForEdit(s, false, tempindex );
                AllrecKey.add(temp);
                
            }
            else{ 
                WrapperForEdit temp = new WrapperForEdit(s, true, tempindex );
                AllrecKey.add(temp);
                
            }
            tempindex ++;
        }
        for(string s: bMap.keySet()){
            for(string d:ListBDE){
                if(!bMap.get(s).containsKey(d)){
                    bMap.get(s).put(d,'');
                }        
            }
        }
        system.debug('----'+bMap);
        for(string s:bMapId.keySet()){
            for(string d:ListBDE){
                if(!bMapId.get(s).containsKey(d)){
                    bMapId.get(s).put(d,'');
                }        
            }
        }
        
       
    }
    
    public List<WrapperForEdit> AllrecKey {set;get;}
    public class WrapperForEdit{
        public Boolean edit {set;get;}
        public String key{set;get;}
        public Integer i{set;get;}
        public WrapperForEdit(String k, Boolean b, Integer ind){
            key = k;
            edit = b;
            i = ind;
        }
    }
    
    public class wrapperCls{
        public date dDate{get;set;}
        public string AMPM{get;set;}
        public Resource_Tracker__c bdes{get;set;}
        public wrapperCls(date d,string s,Resource_Tracker__c bd){
            dDate=d;
            AMPM=s;
            bdes=bd;    
        }
    }  
    public String fullRecordURL {set;get;}
   
}