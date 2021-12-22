pageextension 50076 "Country Ext" extends "Countries/Regions"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Portal Country"; Rec."Portal Country")
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