pageextension 50078 "Ship-to Address Ext" extends "Ship-to Address"
{
    layout
    {
        // Add changes to page layout here
        modify("Customer No.")
        {
            ApplicationArea = all;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}