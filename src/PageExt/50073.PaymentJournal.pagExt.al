pageextension 50073 "Payment Journal Ext" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Reporting)
        {
            action("Payment Voucher Print")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    GenJnlLine.Reset();
                    GenJnlLine.SetRange("Document Type", rec."document type");
                    GenJnlLine.SetRange("Document No.", rec."Document No.");
                    if GenJnlLine.FindFirst() then
                        Report.RunModal(50011, true, false, GenJnlLine);
                end;
            }
        }
    }

    var
        myInt: Integer;
}