pageextension 50067 "Vendor Card Ext" extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Vendor Category 1"; Rec."Vendor Category 1")
            {
                ApplicationArea = All;
            }
            field("Vendor Category 2"; rec."Vendor Category 2")
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