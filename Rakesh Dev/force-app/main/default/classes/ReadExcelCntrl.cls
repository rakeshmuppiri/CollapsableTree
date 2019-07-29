public class ReadExcelCntrl {
    public static void loginSF(){
    }
    @future(callout=true)
    public static void CreateCustomObjectRecords(){
         Http http=new Http();
         String remoteId;
         HttpRequest req=new HttpRequest();
         String clientId='3MVG9Y6d_Btp4xp7B3_Onr.WRGY9esTnU1lQiTZK6ESKkK1SYAGKU6p9aCvf7KjOJ32Vs2cy.I0ukumv78MGk';
         String clientSecret='8449405930031045926';
         String userName='rakesh.mupiri@gmail.com';
         String password='$Dell2014vkzR6AbpTpst4eAC1HKRxuHR7'; // Security Token appended
         String grantType='password';
         //String url='https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id='+clientId+'&redirect_uri=https://india-dell-dev-ed--c.ap1.visual.force.com/apex/SFDCIntegration';
         //return new PageReference(url);
         String url='https://login.salesforce.com/services/oauth2/token?grant_type='+grantType+'&client_id='+clientId+
                    '&client_secret='+clientSecret+'&username='+userName+'&password='+password;
         req.setEndPoint(url);
         req.setMethod('POST');
         HttpResponse res=http.send(req);
         
         system.debug('RRRRR'+res);
         ReadExcelCntrl.loginResponse res1=(ReadExcelCntrl.loginResponse)JSON.deserialize(res.getBody(),ReadExcelCntrl.loginResponse.class);
         String instance_url=res1.instance_url;
         String accountUrl=instance_url+'/services/data/v24.0/sobjects/Custom_Object__c/';
         String access_token=res1.access_token;
         
         //
             req=new HttpRequest();
             String s =instance_url+'/services/data/v24.0/query/?q=SELECT+BODY+FROM+Document+WHERE+name+=+\'test4\'';
             req.setEndPoint(s);
             req.setMethod('GET');
             req.setHeader('Authorization','Bearer '+ access_token);
             res=http.send(req);             

            
                 ReadExcelCntrl.Res resobj=(ReadExcelCntrl.Res)JSON.deserialize(res.getBody(),ReadExcelCntrl.Res.class);
                 List<attributes> records = resobj.records;
                 String fileURL = records[0].Body;
                 system.debug('wwwwwwww'+fileURL);
             s = instance_url+''+fileURL;
             req.setEndPoint(s);
             req.setMethod('GET');
             req.setHeader('Authorization','Bearer '+ access_token);
             res=http.send(req); 
             //Blob b = Blob.valueOF(res.getBody());
             String strUrlUTF8 = EncodingUtil.urlEncode(res.getBody(), 'UTF-8');
             system.debug('11111'+strUrlUTF8 );
             
             Blob b = Blob.valueOf(strUrlUTF8);
             system.debug('22222'+strUrlUTF8 );
             
             String b64 = EncodingUtil.base64Encode(b);
             system.debug('33333'+b64);
             
             b = EncodingUtil.base64Decode(b64);
              system.debug('4444'+b64);
              
             strUrlUTF8 =  b.toString();
             string strOriginal = EncodingUtil.urlDecode(strUrlUTF8, 'UTF-8');
             
             system.debug('aaaaaaaaaaaaaaaaaaaacccs'+strOriginal );
    }
    
    public class Res{
        Integer totalSize {set;get;}
        Boolean done {set;get;}
        List<attributes> records {set;get;}
        Res(Integer totalSize, Boolean done, List<attributes> records){
            this.totalSize= totalSize;
            this.done = done;
             this.records = records;
        }
    }
   
    public class attributes{    
        String type{set;get;}
        String url{set;get;}
        String Body{set;get;}
        attributes(String type, String url, String Body){
            this.type =type;
            this.url = url;
            this.Body= Body;
        }
    }
    public class loginResponse
    {
       public String id{get;set;}
       public String issued_at{get;set;}
       public String instance_url{get;set;}
       public String signature{get;set;}
       public String access_token{get;set;}
    
        public loginResponse(String id, String issued_at, String instance_url, String signature, String access_token)
        {
         this.id=id;
         this.issued_at=issued_at;
         this.instance_url=instance_url;
         this.signature=signature;
         this.access_token=access_token;
        
        }
    }
    
}