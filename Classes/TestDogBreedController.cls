/*************************************************************************
 * Class : TestDogBreedController 
 * Description : Used to test code coverage for DogBreedController
 * Author : XXXXXX
 * Version : 0.0.18.1
 **************************************************************************/
@isTest
private class TestDogBreedController {
    
    // test method to fetch dog breeds data
     static testMethod void testDogBreeds() {
         Test.startTest();
         System.Test.setMock(HttpCalloutMock.class, DogBreedCalloutMock.getMockBreedsResponse());
         DogBreedController obj = new DogBreedController();
         obj.loadData();
         Test.stopTest();
     }
    
}