pageextension 50063 "Transport Method Ext" extends "Transport Methods"
{
    layout
    {
        // Add changes to page layout here
        modify(Code)
        {
            ApplicationArea = all;
        }
        modify(Description)
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