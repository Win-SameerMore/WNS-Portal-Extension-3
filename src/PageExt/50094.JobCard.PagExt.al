pageextension 50094 "Job Card Ext" extends "Job Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Project Manager")
        {
            field("SO number"; rec."SO number")
            {
                ApplicationArea = All;
            }
            field("Sales Order Date"; rec."Sales Order Date")
            {
                ApplicationArea = All;
            }
            field("Project Name"; rec."Project Name")
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