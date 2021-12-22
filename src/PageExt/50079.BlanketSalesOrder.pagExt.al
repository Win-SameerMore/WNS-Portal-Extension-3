pageextension 50079 "MyExtension" extends "Blanket Sales Order"
{
    layout
    {
        // Add changes to page layout here
        modify("Ship-to Code")
        {
            //Editable = ((Rec."Portal Order") and (Rec."ship-to code" <> '')) or (ShipToOptions = ShipToOptions::"Alternate Shipping Address");
            Editable = true;
        }
        modify(Control4)
        {
            Visible = (NOT (ShipToOptions = ShipToOptions::"Default (Sell-to Address)")) or (Rec."Portal Order");
        }
        modify("Ship-to Name")
        {
            Editable = true;
        }
        modify("Ship-to Address")
        {
            Editable = true;
        }
        modify("Ship-to Address 2")
        {
            Editable = true;
        }
        modify("Ship-to City")
        {
            Editable = true;
        }
        modify("Ship-to Contact")
        {
            Editable = true;
        }
        modify("Ship-to Country/Region Code")
        {
            Editable = true;
        }
        modify("Ship-to Post Code")
        {
            Editable = true;
        }
        addlast(General)
        {
            field("Customer Mails"; Rec."Customer Mails")
            {
                ApplicationArea = All;
            }
        }
        modify(SellToEmail)
        {
            Editable = true;
        }
        modify(SellToPhoneNo)
        {
            Editable = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}