pageextension 50080 "Price List Line Review Ext" extends "Price List Line Review"
{
    layout
    {
        // Add changes to page layout here
        addafter("Allow Invoice Disc.")
        {
            field("Promotional Item"; Rec."Promotional Item")
            {
                Caption = 'Promotional Item';
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