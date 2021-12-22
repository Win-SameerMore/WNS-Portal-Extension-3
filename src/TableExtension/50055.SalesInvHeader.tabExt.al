tableextension 50055 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Quotation Validity"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Delivery Mode"; Enum "Delivery Mode")
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Portal Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Cust RFQ. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "End User"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Payment Status (Paid)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}