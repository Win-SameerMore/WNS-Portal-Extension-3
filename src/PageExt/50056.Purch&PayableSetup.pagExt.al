pageextension 50056 "Purch & Payable Setup PageExt" extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Default Cancel Reason Code")
        {
            field("Purchase Order Terms 1"; rec."Purchase Order Terms 1")
            {
                ApplicationArea = All;
            }
            field("Purchase Order Terms 2"; rec."Purchase Order Terms 2")
            {
                ApplicationArea = All;
            }
            field("Purchase Order Terms 3"; rec."Purchase Order Terms 3")
            {
                ApplicationArea = All;
            }
            field("SSE RFQ Mails"; rec."SSE RFQ Mails")
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