pageextension 50068 "Req. Worksheet Ext" extends "Req. Worksheet"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("Select Vendors & Publish")
        {
            trigger OnAfterAction()
            var
                AutoMailCodeunit: Codeunit "Auto Mail";
                PurchaseHeader: Record "Purchase Header";
            begin
                PurchaseHeader.Reset();
                PurchaseHeader.setrange("PR Ref. No.", Rec."PR Ref. No.");
                if PurchaseHeader.FindFirst() then
                    AutoMailCodeunit.AutoMailRFQ(PurchaseHeader);
            end;
        }
    }

    var
        myInt: Integer;
}