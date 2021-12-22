tableextension 50068 "Extended Text Header Ext" extends "Extended Text Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Product Overview"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    procedure SetProductOverview(NewProductOverview: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Product Overview");
        "Product Overview".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewProductOverview);
        Modify;
    end;

    procedure GetProductOverview() ProductOverview: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Product Overview");
        "Product Overview".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), ProductOverview) then
            Message(ReadingDataSkippedMsg, FieldCaption("Product Overview"));
    end;


    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';
}