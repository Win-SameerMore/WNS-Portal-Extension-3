pageextension 50054 "Sales Shipment Card Ext" extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Currency Code"; Rec."Currency Code")
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
        addafter("&Print")
        {
            action("Delivery Order")
            {
                ApplicationArea = All;
                image = Print;
                trigger OnAction()
                begin
                    rSalesShpHeader.Reset();
                    rSalesShpHeader.SetRange("No.", Rec."No.");
                    rSalesShpHeader.SetRange("Bill-to Customer No.", Rec."Bill-to Customer No.");
                    report.RunModal(50004, true, false, rSalesShpHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
        rSalesShpHeader: Record "Sales Shipment Header";
}