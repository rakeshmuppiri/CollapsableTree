//Generated by wsdl2apex

public class soapSforceComSchemasClassIntegratio {
    public class LogInfo {
        public String category;
        public String level;
        private String[] category_type_info = new String[]{'category','http://soap.sforce.com/schemas/class/integrationwebclass','LogCategory','1','1','false'};
        private String[] level_type_info = new String[]{'level','http://soap.sforce.com/schemas/class/integrationwebclass','LogCategoryLevel','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'category','level'};
    }
    public class createmethodResponse_element {
        public String result;
        private String[] result_type_info = new String[]{'result','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
    public class AllowFieldTruncationHeader_element {
        public Boolean allowFieldTruncation;
        private String[] allowFieldTruncation_type_info = new String[]{'allowFieldTruncation','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'allowFieldTruncation'};
    }
    public class DebuggingHeader_element {
        public soapSforceComSchemasClassIntegratio.LogInfo[] categories;
        public String debugLevel;
        private String[] categories_type_info = new String[]{'categories','http://soap.sforce.com/schemas/class/integrationwebclass','LogInfo','0','-1','false'};
        private String[] debugLevel_type_info = new String[]{'debugLevel','http://soap.sforce.com/schemas/class/integrationwebclass','LogType','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'categories','debugLevel'};
    }
    public class CallOptions_element {
        public String client;
        private String[] client_type_info = new String[]{'client','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'client'};
    }
    public class createmethod_element {
        public String a;
        private String[] a_type_info = new String[]{'a','http://www.w3.org/2001/XMLSchema','string','1','1','true'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'a'};
    }
    public class SessionHeader_element {
        public String sessionId;
        private String[] sessionId_type_info = new String[]{'sessionId','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'sessionId'};
    }
    public class DebuggingInfo_element {
        public String debugLog;
        private String[] debugLog_type_info = new String[]{'debugLog','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass','true','false'};
        private String[] field_order_type_info = new String[]{'debugLog'};
    }
    public class integrationwebclass {
        public String endpoint_x = 'https://ap1.salesforce.com/services/Soap/class/integrationwebclass';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public soapSforceComSchemasClassIntegratio.DebuggingInfo_element DebuggingInfo;
        public soapSforceComSchemasClassIntegratio.AllowFieldTruncationHeader_element AllowFieldTruncationHeader;
        public soapSforceComSchemasClassIntegratio.DebuggingHeader_element DebuggingHeader;
        public soapSforceComSchemasClassIntegratio.CallOptions_element CallOptions;
        public soapSforceComSchemasClassIntegratio.SessionHeader_element SessionHeader;
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/schemas/class/integrationwebclass';
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=http://soap.sforce.com/schemas/class/integrationwebclass';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/schemas/class/integrationwebclass';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/schemas/class/integrationwebclass';
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/schemas/class/integrationwebclass';
        private String[] ns_map_type_info = new String[]{'http://soap.sforce.com/schemas/class/integrationwebclass', 'soapSforceComSchemasClassIntegratio'};
        public String createmethod(String a) {
            soapSforceComSchemasClassIntegratio.createmethod_element request_x = new soapSforceComSchemasClassIntegratio.createmethod_element();
            soapSforceComSchemasClassIntegratio.createmethodResponse_element response_x;
            request_x.a = a;
            Map<String, soapSforceComSchemasClassIntegratio.createmethodResponse_element> response_map_x = new Map<String, soapSforceComSchemasClassIntegratio.createmethodResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/integrationwebclass',
              'createmethod',
              'http://soap.sforce.com/schemas/class/integrationwebclass',
              'createmethodResponse',
              'soapSforceComSchemasClassIntegratio.createmethodResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.result;
        }
    }
}