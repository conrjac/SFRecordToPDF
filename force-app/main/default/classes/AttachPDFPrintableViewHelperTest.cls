@isTest
private class AttachPDFPrintableViewHelperTest {
   
    
    @testSetup static void setup() {
        
        Account a = new Account(Name = 'TestAcct');
        insert a;        
    }
    
    @isTest
    static void testgetRecordAndAttachAsFile_withParmeters()
    {
        
        Id recordId = [Select Id FROM Account LIMIT 1].Id;
        
        Test.startTest();
        
        AttachPDFPrintableViewHelper.getRecordAndAttachAsFile(recordId, 'snazzyfilename', AttachPDFPrintableViewHelper.ShareType.V, AttachPDFPrintableViewHelper.Visibility.InternalUsers);
        
        Test.stopTest();
    }

       @isTest
    static void testgetRecordAndAttachAsFile_withoutParmeters()
    {
        
        Id recordId = [Select Id FROM Account LIMIT 1].Id;
        
        Test.startTest();
        
        AttachPDFPrintableViewHelper.getRecordAndAttachAsFile(recordId, null, null, null);
        
        Test.stopTest();
    }
}
