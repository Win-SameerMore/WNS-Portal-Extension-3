pageextension 50066 "Vendor List Ext" extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Contact)
        {
            field("Vendor Category 1"; Rec."Vendor Category 1")
            {
                ApplicationArea = All;
            }
            field("Vendor Category 2"; Rec."Vendor Category 2")
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