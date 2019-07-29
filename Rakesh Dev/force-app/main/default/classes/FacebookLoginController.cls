public class FacebookLoginController {
    @future(callout = true)
    public static void loginToApp() {
        Http http=new Http();
         HttpRequest req=new HttpRequest();
         String AppId = '484195551679269';
         String AppSecret='8cd4969c242aa21f807f4196e923ae4b';
         
         String accesstoken='CAAG4X4ZCcEyUBACZAzWvx8ZBfYqZACK78zR7agXsdAgxWok13g61rQPsawlkZCQZAqhxKmGTGMR1iwrSVWmZAl5prFYXK9YUqdAjc9ON8VDLQp9ZAkLO1hJlMLt1UFfcVn7e5W8Xeac9l6FcSbInMRr46WTxIbyPDdO0s9t847QCkeHkjweh0ilu&expires=5178175';
         //String url='https://www.facebook.com/dialog/oauth?client_id=484195551679269&redirect_uri=https://c.ap1.visual.force.com/apex/FacebookLogin&scope=user_about_me,read_mailbox,read_insights,user_photos,friends_photos,publish_stream,read_friendlists,read_insights,read_requests,read_stream,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,&state=SOME555555';
         //String ur='https://c.ap1.visual.force.com';
         //String url='https://www.facebook.com/dialog/apprequests?app_id=165465460327225&message=Facebook%20Dialogs%20are%20so%20easy!&redirect_uri=https://c.ap1.visual.force.com/apex/FacebookLogin';
         /*String url='https://graph.facebook.com/oauth/access_token?client_id=484195551679269&redirect_uri=https://c.ap1.visual.force.com/apex/FacebookLogin&client_secret=8cd4969c242aa21f807f4196e923ae4b&code=AQAiJizo-VNRaHLIa3GV8aGFTvO6_wYwHoA7QJ8ADf7CSyTs9eCy70yHGLcZxVynNPnj4iCSygwleDVO8-7GnRzu8RivQGw9L_zw0q5zL-PwN6qqveSRqg35szbkArd13rsyw0cEPpt_161ONi5CIjthqWceqk3xqh1SvC3E2CXNar1sWwY7V46dtnwUA2c9NdOaxAy3hg9sAxHGOn1zFiqbaBAY4P5n6drZy0nbuE0lU2XPBTlVMfcUeEnOM1PUGShyIsMRpGgJXBMLhRMU_8_uhu2IH6e_cm9KkA58KO-u9jvAz9GsT3bvrtdrebeQf2A&state=SOME555555#_=_';
                     
         req.setMethod('POST');
         req.setEndpoint(url);
         
         //req.setMethod('GET');
         HttpResponse res=http.send(req);
         system.debug('-----------Response------------'+res.getBody());
         */
         HttpRequest req1=new HttpRequest();
        req1.setMethod('GET');
        req1.setEndpoint('https://graph.facebook.com/me?access_token='+accesstoken);
        HttpResponse res1= http.send(req1);
         system.debug('-----------Response2------------'+res1.getBody());
        JSONParser parser = JSON.createParser(res1.getBody());
    while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&  (parser.getText() == 'username')) 
            {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                
                username = parser.getText();
                system.debug('-----------------------'+username);
            }
        } 
        req1.setEndpoint('https://graph.facebook.com/'+username +'/feed?access_token='+accesstoken);
        res1= http.send(req1);
         system.debug('-----------Response3------------'+res1.getBody());
    }

        public static String username{set;get;}
    
    //public FaceBookUser fb{get;set;}
   // public FacebookUser fb = new FacebookUser();
    @future(callout = true)
    public static void loginToFacebook() 
    {
         Http http=new Http();
         HttpRequest req=new HttpRequest();
         String AppId = '165465460327225';
         String AppSecret='cbe231e119d7d5b123ce8e215f68eb40';
         String accesstoken='CAACWfW38QzkBAELtFXEdUaaqZA7ZAmc3J61hrZA2oUaJLEWMdx4AbouVhD4GxMldN4UdKndl9aWRpfFNaX2bZA1jwICc4dWKbj8GfkXbLG3r1Fwlt5ZCvaTqDZCGpwh0qJDVCbSOHS0JGTT37WTSRr3ugLr6jAY7wQRyuov6CjxryOdZCW0Jw1lEuX9TNtLWqwZD&expires=5183193';
         String url='https://www.facebook.com/dialog/oauth?client_id=165465460327225&redirect_uri=https://c.ap1.visual.force.com/apex/FacebookLogin&scope=user_about_me,read_mailbox,read_insights,user_photos,friends_photos,publish_stream,read_friendlists,read_insights,read_requests,read_stream,xmpp_login,ads_management,create_event,manage_friendlists,manage_notifications,&state=SOME555555';
         String ur='https://c.ap1.visual.force.com';
         //String url='https://www.facebook.com/dialog/apprequests?app_id=165465460327225&message=Facebook%20Dialogs%20are%20so%20easy!&redirect_uri=https://c.ap1.visual.force.com/apex/FacebookLogin';
         //String url='https://graph.facebook.com/oauth/access_token?client_id=165465460327225&redirect_uri='+ur+'&client_secret=2aa72d0d60722a716ae7c4445b69b29c&code=AQBezjmjN5UIrDA2dh8PYVq5oJqVXOzo9Uwti2sr6IkIqFuZlUoQ_P_TP6YrOKvf-e8g8rbZXwDsWUAMJ75XcGoeiWpibEH2__nqv_dv2Tzgqt_rLKObVBzO9HPGkn7GNydKqzWqjuxqvJruo34921Wns2OKjkPSbD6RoUpMSLdu52mTYrf37NCxakCvA5KE2bY#_=_';
         //req.setMethod('GET');
         //req.setEndpoint('https://graph.facebook.com/oauth/access_token?client_id=165465460327225&redirect_uri=https://c.ap1.visual.force.com/apex/FacebookLogin&client_secret=cbe231e119d7d5b123ce8e215f68eb40&code=AQDQGbcn75YFmWrfMYbLV9pUNO-KRmEGdaMSkFiPHS3G4TZuJsIgViHCkCuKCL0-N2QtfFeIT3VHFgmL3v8CIncORXSuHlJwXD38AzC-IYOicnrXTL94RF34KrG0qehKkmufUofypJcif7XqdGs1Zbsyi3AJ8tAk6adISTitopWGoAm9jF_fCDjGSm2sdQ6oQLUbwQaBtFk5HZEPK2hKcl281tPxy_DGMFBdYq4pTm4IHermHmY0ZQr5-D6WvQiKhYhaWbG6M9CEUSAkzDLOIzRTj0razuqGFpXwmaRcjFoeFHVSrN_sBVfRNIlggofuDZk&state=SOME555555#_=_');
         
         //req.setMethod('GET');
         //HttpResponse res=http.send(req);
         //system.debug('-----------Response------------'+res.getBody());
         
         HttpRequest req1=new HttpRequest();
        req1.setMethod('GET');
        req1.setEndpoint('https://graph.facebook.com/me?access_token='+accesstoken);
        HttpResponse res= http.send(req1);
         system.debug('-----------Response2------------'+res.getBody());
        JSONParser parser = JSON.createParser(res.getBody());
    while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&  (parser.getText() == 'username')) 
            {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                
                username = parser.getText();
                system.debug('-----------------------'+username);
            }
        } 
        
    }

}