@isTest
private class HelloWorldTestClass{
    static testMethod void validateHelloWorld(){
        Book__c b = new Book__c(Name='Behind the cloud', Price__c = 100); 
        System.debug('Price before inserting new Book: '+b.Price__c);
        
        //insert book
        insert b;
        
        //Retrieve the new Book
        b = [SELECT Price__c FROM Book__c WHERE Id=:b.Id];
        System.debug('Price After Trigger fired: '+b.Price__c);
        
        //Test that the trigger correctly updated the price
        System.assertEquals(90, b.Price__c);
    }    
}