codeunit 50056 "Import Bulk Attachment"
{
    trigger OnRun()
    begin

    end;

    procedure ImportBulkAttachment(ZipFileName: text; Var TotalCnt: Integer; ReplaceMode: Boolean): Text
    var
        myInt: Integer;
        InStream: InStream;
        DataCompression: Codeunit "Data Compression";
        EntryList: list of [Text];
        EntryListKey: Text;
        FileName: Text;
        FileExtension: Text;
        FileSizeKB: Integer;
        Item_L: text;
        OutS: OutStream;
        FileMgt: Codeunit "File Management";
        DocumentAttchment: Record "Document Attachment";
        TempBlob: codeunit "Temp Blob";
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        Variant_No: Text;
        rDocumentAttachment: Record "Document Attachment";
    begin
        if not UploadIntoStream('Upload ZIP File', '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('Not found! Contact system administrator.');
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);
        TotalCnt := 0;
        //Deleteall;
        foreach entrylistKey in entryList do begin
            Clear(EntryInStream);
            Clear(EntryOutStream);
            FileName := '';
            FileExtension := '';
            FileSizeKB := 0;

            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(DocumentAttchment."File Name"));
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(DocumentAttchment."File Extension"));
            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            FileSizeKB := Length;

            if (FileName <> '') and (uppercase(FileExtension) = UpperCase('pdf')) then begin
                Item_L := GetSplitItem(FileName);

                rDocumentAttachment.Reset();
                if rDocumentAttachment.FindLast() then;

                Clear(DocumentAttchment);
                DocumentAttchment.Init();
                DocumentAttchment.Validate(ID, rDocumentAttachment.ID + 1);
                DocumentAttchment.Validate("Table ID", 27);
                DocumentAttchment.Validate("No.", Item_L);
                DocumentAttchment.Validate("File Name", FileName);
                DocumentAttchment.Validate("File Extension", FileExtension);
                DocumentAttchment."Document Reference ID".ImportStream(EntryInStream, '');

                rDocumentAttachment.Reset();
                rDocumentAttachment.SetRange("Table ID", 27);
                rDocumentAttachment.SetRange(ID, DocumentAttchment.ID);
                rDocumentAttachment.SetRange("No.", Item_L);
                if rDocumentAttachment.FindLast() then;

                DocumentAttchment.Validate("Line No.", rDocumentAttachment."Line No." + 1000);
                rItem.Reset();
                if rItem.get(Item_L) then
                    if DocumentAttchment.Insert(true) then
                        TotalCnt += 1;
            end;
        end;
        DataCompression.CloseZipArchive();
        exit(ZipFileName);
    end;

    local procedure GetSplitItem(String: Text): Text
    var
        StringList: list of [Text];
        StringValue: Text;
    begin
        StringList := String.Split('^');
        stringvalue := stringlist.get(1);
        StringValue := ConvertStr(StringValue, '_', '/');
        exit(StringValue);
    end;

    local procedure GetSplitItemSeq(String: Text): Text
    var
        StringList: list of [Text];
        StringValue: Text;
    begin
        StringList := String.Split('^');
        stringvalue := stringlist.get(2);
        exit(StringValue);
    end;

    procedure ImportBulkImages(ZipFileName: text; Var TotalCnt: Integer; ReplaceMode: Boolean): Text
    var
        InStream: InStream;
        DataCompression: Codeunit "Data Compression";
        EntryList: list of [Text];
        EntryListKey: Text;
        FileName: Text;
        FileExtension: Text;
        FileSizeKB: Integer;
        Item_L: text;
        OutS: OutStream;
        FileMgt: Codeunit "File Management";
        TempBlob: codeunit "Temp Blob";
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        Variant_No: Text;
        ECommerceImages: Record "Ecommerce Images";
        rECommerceImages: Record "Ecommerce Images";
        Image_Sequence: Text;
        intImage_Sequence: Integer;
    begin
        if not UploadIntoStream('Upload ZIP File', '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('Not found! Contact system administrator.');
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);
        TotalCnt := 0;
        //Deleteall;
        foreach entrylistKey in entryList do begin
            Clear(EntryInStream);
            Clear(EntryOutStream);
            FileName := '';
            FileExtension := '';
            FileSizeKB := 0;

            FileName := FileMgt.GetFileNameWithoutExtension(EntryListKey);
            FileExtension := FileMgt.GetExtension(EntryListKey);

            TempBlob.CreateOutStream(EntryOutStream);
            DataCompression.ExtractEntry(EntryListKey, EntryOutStream, Length);
            TempBlob.CreateInStream(EntryInStream);

            FileSizeKB := Length;

            if (FileName <> '') and (uppercase(FileExtension) = uppercase('jpg')) then begin
                Item_L := GetSplitItem(FileName);
                Image_Sequence := GetSplitItemSeq(FileName);

                rECommerceImages.Reset();
                if rECommerceImages.FindLast() then;

                Clear(ECommerceImages);
                ECommerceImages.Init();
                ECommerceImages.Validate("Item No.", Item_L);
                Evaluate(ECommerceImages."Item Display Sequence", Image_Sequence);
                ECommerceImages.Image.ImportStream(EntryInStream, '');
                //ECommerceImages.Picture.Import(FileName + '.' + FileExtension);

                rItem.Reset();
                if rItem.get(Item_L) then
                    if ECommerceImages.Insert(true) then
                        TotalCnt += 1;
            end;
        end;
        DataCompression.CloseZipArchive();
        exit(ZipFileName);

    end;

    var
        rItem: Record Item;
}