public class ClassCodeCoverage {
    public ClassCodeCoverage(){
    
    }
    public Map<String, Integer> calcualteCode(){
    	String objectIdQuery = 'SELECT ApexClassOrTriggerId, ApexClassOrTrigger.Name, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate WHERE ApexClassOrTriggerId != NULL AND ApexClassOrTrigger.Name != NULL AND (NumLinesCovered > 0 OR NumLinesUncovered > 0) AND NumLinesCovered != NULL AND NumLinesUncovered != NULL ORDER BY ApexClassOrTrigger.Name';
		String q = 'SELECT Coverage FROM ApexCodeCoverage';
        String environmentURL = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v32.0/tooling/query/?q=' + EncodingUtil.urlEncode(q, 'UTF-8');
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(environmentURL);
        req.setMethod('GET');
        
        Http h = new Http();
        system.debug('---'+h.send(req).getBody());

        return null;
    }
}