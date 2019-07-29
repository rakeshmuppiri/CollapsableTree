public class exampleCon {
    Integer count = 0;
                        
    public PageReference incrementCounter() {
        count++;
        if(count == 5){
            return (new PageReference('/apex/facebookPractise') );
        }
        return null;
    }
                        
    public Integer getCount() {
        return count;
    } 

    String uname;

    public String getUsername() {
        return uname;
    }
            
    public PageReference sayHello() {
        uname = UserInfo.getName();
        return null;
    }
            
    public void setState(String n) {
        state = n;
    }
            
    public String getState() {
        return state;
    }
            
    public PageReference methodOne() {
        return null;
    }
            
    private String state = 'no';
}