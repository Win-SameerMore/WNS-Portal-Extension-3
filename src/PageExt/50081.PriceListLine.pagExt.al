pageextension 50081 "Price List Line Ext" extends "Price List Lines"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit Price")
        {
            field("Promotional Item"; Rec."Promotional Item")
            {
                Caption = 'Promotional Item';
                ApplicationArea = All;
            }
            field("Original Price"; Rec."Original Price")
            {
                ApplicationArea = All;
                Caption = 'Original Price';
                Editable = false;
            }
        }


        // modify("Asset No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         rItem: Record Item;
        //     begin
        //         if Rec."Asset Type" = Rec."Asset Type"::Item then begin
        //             if rItem.get(rec."Asset No.") then
        //                 Rec."Original Price" := rItem."Unit Price";
        //             Rec.Modify();
        //         end;
        //     end;
        // }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}