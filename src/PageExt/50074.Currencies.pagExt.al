pageextension 50074 "Currencies Ext" extends Currencies
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Portal Currency"; Rec."Portal Currency")
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