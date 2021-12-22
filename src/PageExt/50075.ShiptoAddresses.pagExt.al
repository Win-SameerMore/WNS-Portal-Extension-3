pageextension 50075 "Ship to Address List Ext" extends "Ship-to Address List"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Code)
        {
            field("customer no."; rec."customer no.")
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