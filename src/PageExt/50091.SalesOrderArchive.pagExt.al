pageextension 50091 "Sales Order Archive Ext" extends "Sales Order Archive"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Sales Order Status"; Rec."Sales Order Status")
            {
                ApplicationArea = All;
            }
            field("Date of Completion"; Rec."Date of Completion")
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