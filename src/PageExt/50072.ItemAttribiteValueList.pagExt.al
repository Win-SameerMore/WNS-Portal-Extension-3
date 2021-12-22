pageextension 50072 "Item Attribute Value List" extends "Item Attribute Value List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure")
        {
            field("Inherited-From Key Value"; Rec."Inherited-From Key Value")
            {
                ApplicationArea = All;
                Caption = 'Item No.';
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