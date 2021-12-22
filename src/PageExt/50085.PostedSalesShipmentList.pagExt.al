pageextension 50085 "Posted Sales Shipment List Ext" extends "Posted Sales Shipments"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}