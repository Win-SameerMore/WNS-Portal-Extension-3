pageextension 50092 "Assembly Orders Ext" extends "Assembly Orders"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field(Status; Rec.Status)
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