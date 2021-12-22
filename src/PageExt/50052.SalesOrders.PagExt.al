pageextension 50052 "Sales Orders List" extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Payment Status"; Rec."Payment Status")
            {
                ApplicationArea = All;
            }
            field("Sales Order Status"; Rec."Sales Order Status")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("Print Confirmation")
        {
            action("Sales Order Print")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    rsalesHeader.Reset();
                    rsalesHeader.SetRange("Document Type", rec."Document Type");
                    rsalesHeader.SetRange("No.", rec."No.");
                    Report.RunModal(50001, true, false, rsalesHeader);
                end;
            }
            action("Print Proforma Invoice")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    rsalesHeader.SetRange("Document Type", rec."Document Type");
                    rsalesHeader.SetRange("No.", rec."No.");
                    Report.Runmodal(50002, true, false, rsalesHeader);
                end;
            }
            action("Delivery Note")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                begin
                    rsalesHeader.SetRange("Document Type", rec."Document Type");
                    rsalesHeader.SetRange("No.", rec."No.");
                    Report.Runmodal(50003, true, false, rsalesHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
        rsalesHeader: Record "Sales header";
}