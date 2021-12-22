tableextension 50052 "Sales & Rec. Setup Ext" extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50020; "Sales Quote Terms 1"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Sales Quote Terms 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Sales Order Terms 1"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Sales Order Terms 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "ETA Available Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "ETA Not Available Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Portal Sales Order Nos."; Code[20])
        {
            TableRelation = "no. series";
            DataClassification = ToBeClassified;
        }
        field(50027; "VAT Bus. Posting Grp Overseas"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(50028; "Freight G/L Acc."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account" where("Account Type" = filter(Posting), Blocked = filter(false), "Direct Posting" = CONST(true));
        }
        field(50029; "SO Terms & Condition"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "SSE Internal Mails"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Delivery Note Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50032; "Finance E-mails"; text[200])
        {
            Caption = 'Finance E-mails';
            DataClassification = ToBeClassified;
        }
    }
    procedure SetSOTermCondition(NewTermCondition: Text)
    var
        OutStream: OutStream;
    begin
        Clear("SO Terms & Condition");
        "SO Terms & Condition".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewTermCondition);
        Modify;
    end;

    procedure GetSOTermCondition() SOTermCondition: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("SO Terms & Condition");
        "SO Terms & Condition".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), SOTermCondition) then
            Message(ReadingDataSkippedMsg, FieldCaption("SO Terms & Condition"));
    end;

    var
        myInt: Integer;
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';
}