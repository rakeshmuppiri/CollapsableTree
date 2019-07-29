@isTest

private class testCallAnotherOrg{
    public static testmethod void testcallingFromHere(){
        Test.startTest();
        Account a = new Account();
        a.name = 'testname';
        insert a;
        CallAnotherOrg.callingFromHere(a.Id);
        Test.stopTest();
    }
}