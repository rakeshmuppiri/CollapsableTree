public class SessionPartitionController {
  
   // Name of a partition in the local namespace
   String partitionInput = 'vlabsdev-dev-ed--vlabs.visualforce.com.myPartition';
   // Name of the key
   String counterKeyInput = 'counter';
   // Key initial value
   Integer counterInitValue = 0;
   // Session partition object
   Cache.SessionPartition sessionPartition;
               
    // Constructor of the controller for the Visualforce page. 
    public SessionPartitionController() {  
    }
            
    // Adds counter value to the cache.
    // This method is called when the Visualforce page loads.
    public void init() {
        // Create the partition instance based on the partition name
        sessionPartition = getPartition();
        
        // Add counter to the cache with an initial value 
        //  or increment it if it's already there.
        if (!sessionPartition.contains(counterKeyInput)) {
            sessionPartition.put(counterKeyInput, counterInitValue);
        } else {
            sessionPartition.put(counterKeyInput, getCounter() + 1);
        }        
    }
    
    // Returns the session partition based on the partition name
    // given in the Visualforce page or the default value.
    private Cache.SessionPartition getPartition() {
       if (sessionPartition == null) {
            sessionPartition = Cache.Session.getPartition(partitionInput);
       }
       
       return sessionPartition;
     }
        
    // Return counter from the cache.
    public Integer getCounter() {
        return (Integer)getPartition().get(counterKeyInput);
    }
    
    // Invoked by the Submit button to save input values
    //  supplied by the user.
    public PageReference save() {
        // Reset the initial key value in the cache
        getPartition().put(counterKeyInput, counterInitValue);

        return null;
    }
   
    // Method invoked by the Rerender button on the Visualforce page.
    // Updates the values of various cached values.
    // Increases the values of counter and the MyData counter if those 
    //   cache values are still in the cache.
    public PageReference go() {
        // Get the partition object
        sessionPartition = getPartition();
        // Increase the cached counter value or set it to 0 
        //  if it's not cached.        
        if (sessionPartition.contains(counterKeyInput)) {
            sessionPartition.put(counterKeyInput, getCounter() + 1);
        } else {
            sessionPartition.put(counterKeyInput, counterInitValue);
        }        
    
        return null;
    }
    
    // Method invoked by the Remove button on the Visualforce page.
    // Removes the datetime cached value from the session cache.
    public PageReference remove() {
        getPartition().remove(counterKeyInput);

        return null;
    }
    
    // Get and set methods for accessing variables
    // that correspond to the input text fields on
    // the Visualforce page.
    public String getPartitionInput() {
        return partitionInput;
    }
    
    public String getCounterKeyInput() {
        return counterKeyInput;
    }
    
    public Integer getCounterInitValue() {
        return counterInitValue;
    }
    
    public void setPartitionInput(String partition) {
        this.partitionInput = partition;
    }
    
    public void setCounterKeyInput(String keyName) {
        this.counterKeyInput = keyName;
    }
    
    public void setCounterInitValue(Integer counterValue) {
        this.counterInitValue = counterValue;
    }
}