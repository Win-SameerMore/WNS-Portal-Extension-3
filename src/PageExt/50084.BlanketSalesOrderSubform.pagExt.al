pageextension 50084 "Blanket Sal Ord Subform Ext" extends "Blanket Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(ETA; Rec.ETA)
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