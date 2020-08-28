global class AttachPDFPrintableViewHelper {
    
    global enum ShareType {V, C, I}
    global enum Visibility {AllUsers,InternalUsers,SharedUsers}
    
    global static void getRecordAndAttachAsFile(id recordId, string fileName, ShareType cdShareType, Visibility cdVisibility)
    {
        Schema.SObjectType sObjectType = recordId.getSObjectType();
        
        string path = Page.PDFPrintableView.getUrl() + '?id=' + recordId;
		PageReference pr = new PageReference( path );
        
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
        //create ContentDocumentLink  record 
        ContentDocumentLink conDocLink = New ContentDocumentLink();
        conDocLink.LinkedEntityId = recordId; // Specify RECORD ID here i.e Any Object ID (Standard Object/Custom Object)
        conDocLink.ContentDocumentId = conDoc;  //ContentDocumentId Id from ContentVersion
        conDocLink.shareType = 'V';
        insert conDocLink;
    } 
}