public class PDFPrintableViewController {
    public String getPrintableView() {
        Id id = ApexPages.currentPage().getParameters().get('id');  
        if(Id == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please ensure that you pass in a record Id as a URL Parameter e.g /PDFPrintableView?id='));
            return '<body><h1>Error: Please ensure that you pass in a record Id as a URL Parameter e.g /PDFPrintableView?id=0063c00001FLQaM</h1></body>';
        }
        else {
            String html;
            if(Test.isRunningTest()){
                html = 'Methods defined as TestMethod do not support getContent call, so returning a this string';
            }else{
               html = new PageReference('/' + id + '/p').getContent().toString();
            }
            return html.substringAfter('</head>').substringBefore('</html>');
        }
    }
}