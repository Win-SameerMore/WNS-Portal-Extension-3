pageextension 50082 "Req. Wksh Names Ext" extends "Req. Wksh. Names"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("No. Series"; Rec."No. Series")
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