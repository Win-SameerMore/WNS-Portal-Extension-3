pageextension 50057 "Assembly Order Ext" extends "Assembly Order"
{
    layout
    {
        // Add changes to page layout here
        addafter("Ending Date")
        {
            field("Sales Order No."; rec."Sales Order No.")
            {
                ApplicationArea = All;
            }
            field("Customer Name"; rec."Customer Name")
            {
                ApplicationArea = All;
            }
        }
        movelast(Control2; "Location Code", "Bin Code", "Cost Amount", "Unit Cost")

    }

    actions
    {
        // Add changes to page actions here
        addafter("Item Tracking Lines")
        {
            action("AO Serial Matrix")
            {
                ApplicationArea = ItemTracking;
                Caption = 'AO Serial Matrix';
                Image = ItemReservation;
                Promoted = true;
                PromotedCategory = Category8;

                trigger OnAction()
                var
                    AOSerialMapping: Page "AO Serial Mapping";
                    ReservationEntry: Record "Reservation Entry";
                begin
                    AOSerialMapping.SetAssemblyHeader(Rec);
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source ID", Rec."No.");
                    ReservationEntry.SetRange("Item No.", Rec."Item No.");
                    //ReservationEntry.SetRange("RM Alloted", false);
                    AOSerialMapping.SetTableView(ReservationEntry);
                    AOSerialMapping.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}