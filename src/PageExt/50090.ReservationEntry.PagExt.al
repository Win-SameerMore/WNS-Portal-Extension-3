pageextension 50090 "Reservation Entry Ext" extends "Reservation Entries"
{
    layout
    {
        // Add changes to page layout here
        modify("Serial No.")
        {
            ApplicationArea = all;
        }
        modify("Reservation Status")
        {
            Visible = false;
        }

        modify(ReservedFrom)
        {
            Visible = false;
        }
        modify("ReservEngineMgt.CreateForText(Rec)")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}