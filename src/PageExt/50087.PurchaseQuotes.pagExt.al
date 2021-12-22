pageextension 50087 "Purchase Quotes Ext" extends "Purchase Quotes"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
            field("Expected Receipt Date"; Rec."Expected Receipt Date")
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