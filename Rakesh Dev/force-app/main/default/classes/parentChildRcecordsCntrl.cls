public class parentChildRcecordsCntrl {
    public Map<Id, List<Vlabs__Review__c>> JobReviewMap {set;get;}
    List<Id> JobIDs = new List<ID>();
    public List<JobWrapper> listWrap {set;get;}
    public parentChildRcecordsCntrl (){
        JobReviewMap = new Map<Id, List<Vlabs__Review__c>>();
        listWrap = new List<JobWrapper>();
        Integer i=0;
        for(Vlabs__Job_Application__c j : [SELECT Id, Name FROM Vlabs__Job_Application__c]){
            JobIDs.add(j.Id);
            JobWrapper temp = new JobWrapper(j, i);
            listWrap.add(temp);
            i++;
        }
        
        for(Vlabs__Review__c rev: [SELECT ID, Vlabs__Job_Application__r.Id, Name FROM Vlabs__Review__c]){
            List<Vlabs__Review__c> tempRev = new List<Vlabs__Review__c>();
            if(JobReviewMap.get(rev.Vlabs__Job_Application__r.Id) != null){
                tempRev = JobReviewMap.get(rev.Vlabs__Job_Application__r.Id);                
            }
            tempRev.add(rev);
            JobReviewMap.put(rev.Vlabs__Job_Application__r.Id, tempRev);
        }
        for(Id JobId : JobIDs){
            if(JobReviewMap.get(JobId) == null)
                JobReviewMap.put(JobId, new List<Vlabs__Review__c>());
        }
    }
    public class JobWrapper{
        public Vlabs__Job_Application__c jobObj {set;get;}
        public Integer i {set;get;}
        JobWrapper(Vlabs__Job_Application__c obj, Integer j){
            jobObj = obj;
            i = j;
        }
    }
    
}