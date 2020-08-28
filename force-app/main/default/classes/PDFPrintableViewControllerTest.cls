@isTest
private class PDFPrintableViewControllerTest {
    
    @testSetup static void setup() {
        Account a = new Account(Name = 'TestAcct');
        insert a;        
    }
    
    @isTest
    static void testGetPrintableView()
    {
        Id recordId = [Select Id FROM Account LIMIT 1].Id;
        Test.startTest();
        PageReference pageRef = Page.PDFPrintableView;
        pageRef.getParameters().put('id', recordId);
        Test.setCurrentPage(pageRef);
        PDFPrintableViewController cont = new PDFPrintableViewController();
        String returnedValue = cont.getPrintableView();
        Test.stopTest();
        System.assert(returnedValue != Null);
        
    }
    
    @isTest
    static void testGetPrintableView_FailWithNoIdPassed()
    {
        Id recordId = [Select Id FROM Account LIMIT 1].Id;
        Test.startTest();
        PageReference pageRef = Page.PDFPrintableView;
        pageRef.getParameters().put('id', null);
        Test.setCurrentPage(pageRef);
        PDFPrintableViewController cont = new PDFPrintableViewController();
        String returnedValue = cont.getPrintableView();
        Test.stopTest();
        System.assert(returnedValue != Null);
    }
    
}
