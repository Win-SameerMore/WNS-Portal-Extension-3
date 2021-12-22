codeunit 50053 "Attachment Preview"
{
    trigger OnRun()
    begin

    end;

    procedure ConvertMediaIntoBase64(DocumentAttchment: Record "Document Attachment") ReturnBase64: text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        MediaInstream: InStream;
        Mediafile: file;
        OutS: OutStream;
    begin
        TempBlob.CreateOutStream(OutS);
        DocumentAttchment."Document Reference ID".ExportStream(OutS);
        TempBlob.CreateInStream(MediaInstream);
        ReturnBase64 := base64.ToBase64(MediaInstream);
    end;

    procedure ConvertMediaIntoBase64Image(EcomImgaes: Record "Ecommerce Images") ReturnBase64: text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        MediaInstream: InStream;
        Mediafile: file;
        OutS: OutStream;
    begin
        TempBlob.CreateOutStream(OutS);
        EcomImgaes.Image.ExportStream(OutS);
        TempBlob.CreateInStream(MediaInstream);
        ReturnBase64 := base64.ToBase64(MediaInstream);
    end;

    [ServiceEnabled]
    procedure ConvertBase64IntoMedia(Base64String: text; TableID: Integer; DocumentType: Integer; DocumentNo: code[20]; FileName: Text; FileExtension: Text): Boolean
    var
        Base64Codeunit: Codeunit "Base64 Convert";
        MediaInstream: InStream;
        ReturnValue: text;
        DocumentAttchment: Record "Document Attachment";
        rDocumentAttchment: Record "Document Attachment";
        tempBlob: Codeunit "Temp Blob";
        OStream: OutStream;
    // rtempBlob: Record TempBlob temporary;
    begin
        //***********DocumentType Values WIN504***********>>
        // enum 1173 "Attachment Document Type"
        // {
        //     value(0; "Quote") { Caption = 'Quote'; }
        //     value(1; "Order") { Caption = 'Order'; }
        //     value(2; "Invoice") { Caption = 'Invoice'; }
        //     value(3; "Credit Memo") { Caption = 'Credit Memo'; }
        //     value(4; "Blanket Order") { Caption = 'Blanket Order'; }
        //     value(5; "Return Order") { Caption = 'Return Order'; }
        // }
        //***********DocumentType Values WIN504***********<<

        tempBlob.CreateOutStream(OStream);
        Base64Codeunit.FromBase64(Base64String, OStream);
        //MediaInstream.ReadText(ReturnValue);

        OStream.WriteText(ReturnValue);
        tempBlob.CreateInStream(MediaInstream);

        rDocumentAttchment.Reset();
        if rDocumentAttchment.FindLast() then;

        DocumentAttchment.init();
        DocumentAttchment."Table ID" := TableID;
        DocumentAttchment."Document Type" := DocumentType;
        DocumentAttchment."No." := DocumentNo;
        DocumentAttchment.ID := rDocumentAttchment.ID + 1;
        DocumentAttchment.Validate("File Name", FileName);
        DocumentAttchment.Validate("File Extension", FileExtension);
        DocumentAttchment."Attached Date" := CurrentDateTime;

        rDocumentAttchment.Reset();
        rDocumentAttchment.SetRange("Table ID", TableID);
        rDocumentAttchment.SetRange(ID, DocumentAttchment.ID);
        rDocumentAttchment.SetRange("No.", DocumentNo);
        if rDocumentAttchment.FindLast() then;

        DocumentAttchment."Line No." := rDocumentAttchment."Line No." + 10000;
        DocumentAttchment."Document Reference ID".ImportStream(MediaInstream, '');
        if DocumentAttchment.Insert(true) then
            exit(true)
        else
            exit(false);
    end;

    procedure AttachmentPreviewPortal(TableID: Integer; DocumentNo: Code[20]): Text
    var
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
        FIleName: text;
        DocStream: InStream;
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", TableID);
        DocumentAttachment.SetRange("No.", DocumentNo);
        DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
        if DocumentAttachment.FindFirst() then begin
            if DocumentAttachment.ID = 0 then
                exit;
            // Ensure document has value in DB
            if DocumentAttachment."Document Reference ID".HasValue then begin
                FullFileName := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
                TempBlob.CreateOutStream(DocumentStream);
                DocumentAttachment."Document Reference ID".ExportStream(DocumentStream);
                //exit(FileManagement.BLOBExport(TempBlob, FullFileName, true)); //WIN
            end;
        end;
    end;

    procedure AttachmentPreviewPortalItem(TableID: Integer; DocumentNo: Code[20]): Text
    var
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
        FIleName: text;
        DocStream: InStream;
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", TableID);
        DocumentAttachment.SetRange("No.", DocumentNo);
        //DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
        if DocumentAttachment.FindFirst() then begin
            if DocumentAttachment.ID = 0 then
                exit;
            // Ensure document has value in DB
            if DocumentAttachment."Document Reference ID".HasValue then begin
                FullFileName := DocumentAttachment."File Name" + '.' + DocumentAttachment."File Extension";
                TempBlob.CreateOutStream(DocumentStream);
                DocumentAttachment."Document Reference ID".ExportStream(DocumentStream);
                //FileManagement.BLOBExport(TempBlob, FullFileName, true);//WIN
                // exit(FileManagement.BLOBExport(TempBlob1, FullFileName, true));
            end;
        end;
    end;

    // procedure DownloadPdfPurchaseOrderPortal(DocumentNo: code[20])
    // var
    //     recRef: RecordRef;
    //     OStream: OutStream;
    //     IStream: InStream;
    //     TempBlob: Codeunit "Temp Blob";
    //     PurchaseHeader: Record "Purchase Header";
    //     ReportParameters: text;
    //     FileManagement: Codeunit "File Management";
    // begin
    //     PurchaseHeader.Reset();
    //     PurchaseHeader.SetRange("No.", DocumentNo);
    //     PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
    //     if PurchaseHeader.FindFirst() then begin
    //         recRef.Gettable(PurchaseHeader);
    //         TempBlob.CreateOutstream(OStream);
    //         ReportParameters := Report.RunRequestPage(Report::"Purchase - Order SSE");
    //         REPORT.SAVEAS(Report::"Purchase - Order SSE", ReportParameters, REPORTFORMAT::Pdf, OStream, recRef);
    //         FileManagement.BLOBExport(TempBlob,Report::purcahse - order)
    //         //TempBlob.CreateInStream(IStream);
    //     end;
    // end;

    var
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';
        FromRecRef: RecordRef;
        SalesDocumentFlow: Boolean;
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        ImportTxt: Label 'Attach a document.';
        SelectFileTxt: Label 'Select File...';
        PurchaseDocumentFlow: Boolean;
        FlowToPurchTxt: Label 'Flow to Purch. Trx';
        FlowToSalesTxt: Label 'Flow to Sales Trx';
        FlowFieldsEditable: Boolean;
        TempBlob1: Codeunit "Temp Blob";
}