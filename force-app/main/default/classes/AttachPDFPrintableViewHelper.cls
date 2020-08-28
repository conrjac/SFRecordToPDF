public with sharing class AttachPDFPrintableViewHelper {
    
    public enum ShareType {V, C, I}
    public enum Visibility {AllUsers,InternalUsers,SharedUsers}
    
    public static void getRecordAndAttachAsFile(id recordId, string fileName, ShareType cdShareType, Visibility cdVisibility)
    {
        Schema.SObjectType sObjectType = recordId.getSObjectType();
        
        string path = Page.PDFPrintableView.getUrl() + '?id=' + recordId;
        PageReference pr = new PageReference(path);
        
        SObject record = sObjectType.newSObject(null, true);
        String queryString = 'SELECT Id, Name FROM ' + recordId.getSObjectType() + ' WHERE Id = :recordId';
        record = Database.query(queryString);
        
        string recordName = (String)record.get('Name');
        
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; // to use S specify this document is in Salesforce, to use E for external files
        conVer.PathOnClient = 'testing.pdf'; // The files name, extension is very important here which will help the file in preview.
        conVer.Title = 'Testing PDF'; // Display name of the files
        conVer.VersionData = pr.getContentAsPDF();
        insert conVer;    //Insert ContentVersion
        
        // First get the Content Document Id from ContentVersion Object
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
        ContentDocumentLink conDocLink = New ContentDocumentLink();
        
        conDocLink.LinkedEntityId = recordId;
        conDocLink.ContentDocumentId = conDoc;
        
        if(cdShareType != null) conDocLink.shareType = cdShareType.name();
        else conDocLink.shareType = 'V'; 


        if(cdVisibility != null) conDocLink.visibility = cdVisibility.name();
        else conDocLink.shareType = 'InternalUsers'; 

        insert conDocLink;
    } 
}