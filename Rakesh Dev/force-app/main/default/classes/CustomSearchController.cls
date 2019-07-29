public class CustomSearchController {
    @AuraEnabled
    public static List<sObject> search(String searchText, String searchObject, List<String> searchFields, List<String> returnFields, List<sObject> excludeRecords) {
    	String return_Fields = String.join(returnFields, ',');
        List<String> searchValues = formatSeachValues(searchText);
        String soql = 'SELECT '+return_Fields;
        soql= soql+' FROM '+searchObject+' WHERE (';
        
        List<String> searchFieldFormat = new List<String>();
        system.debug('searchFields:'+searchFields);
         system.debug('searchValues:'+searchValues);
        
        for(String searchField: searchFields){
            for(String searchValue: searchValues){
                searchFieldFormat.add(searchField+' LIKE '+searchValue);
            }
           
            //String.escapeSingleQuotes(companyName)
        }
        soql= soql+''+String.join( searchFieldFormat, ' OR ' );
        soql = soql+') AND Id NOT IN: excludeRecords';
        soql = soql+' LIMIT 1000';
        system.debug('soql='+soql);
        List<sObject> searchResults = database.Query(soql);
        system.debug('searchResults:'+searchResults);
        return searchResults;
    }
    
    public static List<String> formatSeachValues(String searchText){
        List<String> returnValues = new List<String>();
        List<String> searchValues = searchText.split(',');
        for(String str: searchValues){
            str = str.trim();
            if(!String.isEmpty(str)){
                str = '\'%'+str+'%\'';
                returnValues.add(str);
            }
            
        }
        return returnValues;
    }
}