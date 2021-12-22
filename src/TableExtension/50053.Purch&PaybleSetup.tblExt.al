tableextension 50053 "Purchase & Payabel Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Purchase Order Terms 1"; Text[300])
        {
            DataClassification = ToBeClassified;

        }
        field(50001; "Purchase Order Terms 2"; Text[300])
        {
            DataClassification = ToBeClassified;

        }
        field(50002; "Purchase Order Terms 3"; Text[300])
        {
            DataClassification = ToBeClassified;

        }
        field(50003; "SSE RFQ Mails"; text[200])
        {
            Caption = 'SSE RFQ Mails';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}