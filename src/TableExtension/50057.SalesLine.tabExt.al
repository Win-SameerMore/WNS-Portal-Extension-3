tableextension 50057 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50010; "ETA"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Item Availability"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                rItem: Record Item;
            begin
                rItem.Reset();
                rItem.SetRange("No.", "No.");
                rItem.SetFilter("Location Filter", "Location Code");
                rItem.SetFilter("Date Filter", '..%1', "Posting Date");
                if ritem.FindFirst() then begin
                    rItem.CalcFields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order", "Qty. on Trf. Shipment", "Qty. on Trf. Receipt");

                    "Item Availability" := rItem.Inventory + rItem."Qty. on Purch. Order" - rItem."Qty. on Sales Order" - rItem."Qty. on Trf. Shipment" + rItem."Qty. on Trf. Receipt";
                end;
            end;
        }
        field(50012; "Unit Cost Price"; Decimal)
        {
            Caption = 'Unit Cost Price';
            DataClassification = ToBeClassified;
        }
        field(50013; "Total Cost Price"; Decimal)
        {
            Caption = 'Total Cost Price';
            DataClassification = ToBeClassified;
        }
    }
    var
        myInt: Integer;
}