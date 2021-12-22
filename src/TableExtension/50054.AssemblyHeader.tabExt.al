tableextension 50054 "Assembly Header Ext" extends "Assembly Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                rSalesHdr: Record "Sales Header";
            begin
                rSalesHdr.Reset();
                rSalesHdr.SetRange("No.", "Sales Order No.");
                if rSalesHdr.FindFirst() then
                    "Customer Name" := rSalesHdr."Bill-to Name"
                else
                    "Customer Name" := '';
            end;
        }
        field(50001; "Customer Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}