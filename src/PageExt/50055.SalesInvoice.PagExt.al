pageextension 50055 "Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Payment Status (Paid)"; Rec."Payment Status (Paid)")
            {
                ApplicationArea = All;
            }
            field(SystemModifiedAt; Rec.SystemModifiedAt)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            action("Tax Invoice")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    rSalesInvheader.Reset();
                    rSalesInvheader.SetRange("No.", Rec."No.");
                    rSalesInvheader.SetRange("Bill-to Customer No.", rec."Bill-to Customer No.");
                    Report.RunModal(50005, true, false, rSalesInvheader);
                end;
            }
        }
    }

    var
        rSalesInvheader: Record "Sales Invoice Header";
        myInt: Integer;
}