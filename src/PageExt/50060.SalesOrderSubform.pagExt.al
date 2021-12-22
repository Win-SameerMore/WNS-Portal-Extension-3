pageextension 50060 "Sales Order Subdform Ext" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(ETA; Rec.ETA)
            {
                ApplicationArea = All;

            }
        }
        addafter(Quantity)
        {
            field("Item Availability"; Rec."Item Availability")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price")
        {
            field("Unit Cost Price"; Rec."Unit Cost Price")
            {
                ApplicationArea = All;
            }
            field("Total Cost Price"; Rec."Total Cost Price")
            {
                ApplicationArea = All;
            }
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                UpdateSalesOrderInAssemblyOrder();
            end;
        }

        modify("Qty. to Assemble to Order")
        {
            trigger OnAfterValidate()
            begin
                UpdateSalesOrderInAssemblyOrder();
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalculateItemAvailability();
    end;

    local procedure UpdateSalesOrderInAssemblyOrder()
    var
        AssemblyOrderLink: Record "Assemble-to-Order Link";
        AssemblyHeader: Record "Assembly Header";
    begin
        AssemblyOrderLink.Reset();
        AssemblyOrderLink.SetRange("Document No.", Rec."Document No.");
        AssemblyOrderLink.SetRange("Document Line No.", Rec."Line No.");
        if AssemblyOrderLink.FindFirst() then begin
            AssemblyHeader.Reset();
            AssemblyHeader.SetRange("Document Type", AssemblyOrderLink."Assembly Document Type");
            AssemblyHeader.SetRange("No.", AssemblyOrderLink."Assembly Document No.");
            if AssemblyHeader.FindFirst() then begin
                AssemblyHeader.validate("Sales Order No.", AssemblyOrderLink."Document No.");
                AssemblyHeader.Modify();
            end;
        end;
    end;

    var

        myInt: Integer;

    procedure CalculateItemAvailability()
    var
        myInt: Integer;
        rItem: Record item;
    begin
        rItem.Reset();
        rItem.SetRange("No.", Rec."No.");
        rItem.SetFilter("Location Filter", Rec."Location Code");
        rItem.SetFilter("Date Filter", '..%1', Rec."Posting Date");
        if ritem.FindFirst() then begin
            rItem.CalcFields(Inventory, "Qty. on Purch. Order", "Qty. on Sales Order", "Qty. on Trf. Shipment", "Qty. on Trf. Receipt");

            Rec."Item Availability" := rItem.Inventory + rItem."Qty. on Purch. Order" - rItem."Qty. on Sales Order" - rItem."Qty. on Trf. Shipment" + rItem."Qty. on Trf. Receipt";
        end;

    end;
}