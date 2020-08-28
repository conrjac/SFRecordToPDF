@isTest
private class AttachPDFPrintableViewHelperTest {
   
    
    @testSetup static void setup() {
        
        Account a = new Account(Name = 'TestAcct');
        insert a;        
    }
    
    @isTest
    static void testgetRecordAndAttachAsFile()
    {
        
        Id recordId = [Select Id FROM Account LIMIT 1].Id;
        
        Test.startTest();
        
  
        
        Test.stopTest();
    }
}
