/*************************************************************************
 * Class : DogBreedController 
 * Description : Used to fetch all dog breeds from external system into salesforce to display
 * Author : XXXXXX
 * Version : 0.0.18.1
 **************************************************************************/
public class DogBreedController {
    
    // Wrapper class map used in VF page to display dogs breed information
    public Map<String, WrapperClass> countSubBreedsMap {set;get;}
    
    // Method to fetch dog breeds data from external system
    public void loadData(){
        countSubBreedsMap = new Map<String, WrapperClass>();
        
        // Callout external system
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndPoint('https://dog.ceo/api/breeds/list/all');
        req.setMethod('POST');
        
        // Handling response
        HttpResponse res = http.send(req);
        String resString = res.getBody();
        Map<String, Object> resMap = (Map<String, Object>)JSON.deserializeUntyped(resString);
        
        // If response message is success
        if(resMap.get('status') == 'success'){
            Map<String, Object> resMessage = (Map<String, Object>)resMap.get('message');
            for(String breedGroup : resMessage.keySet()){
                List<Object> subBreeds = (List<Object>)resMessage.get(breedGroup);
                WrapperClass wrapObj = new WrapperClass(subBreeds.size(), subBreeds);
                countSubBreedsMap.put(breedGroup, wrapObj);
            }
        }
    }
    
    // Wrapper class used to store dog breeds structure
    public class WrapperClass{
        public Integer count{set;get;}
        public List<Object> subBreeds{set;get;}
        WrapperClass(Integer count, List<Object> subBreeds){
            this.count = count;
            this.subBreeds = subBreeds;
        }
    }
  
}