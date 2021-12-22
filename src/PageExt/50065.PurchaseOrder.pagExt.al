pageextension 50065 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Expected Receipt Date")
        {
            field("Cashflow PO Due Date"; Rec."Cashflow PO Due Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Vendor Shipment No.")
        {
            field("Vendor Shipment Date"; Rec."Vendor Shipment Date")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
        modify("Shipment Method Code")
        {
            ApplicationArea = all;
        }
        addafter(Status)
        {
            field("Order Acknowledged"; rec."Order Acknowledged")
            {
                ApplicationArea = All;
            }
        }
        addafter("Order Acknowledged")
        {
            field("PO Status"; rec."PO Status")
            {
                ApplicationArea = all;
            }
            field("Freight Estimated Days"; rec."Freight Estimated Days")
            {
                ApplicationArea = all;
            }
            field("Shipping Agent Code"; rec."Shipping Agent Code")
            {
                ApplicationArea = all;
            }
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                EventSubs: Codeunit "Event Subscriber";
            begin
                UpdateShipToPhonePurchase(ShipToOptions);
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                EventSubs: Codeunit "Event Subscriber";
            begin
                UpdateShipToPhonePurchase(ShipToOptions);
            end;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                EventSubs: Codeunit "Event Subscriber";
            begin
                UpdateShipToPhonePurchase(ShipToOptions);
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnAfterValidate()
            var
                EventSubs: Codeunit "Event Subscriber";
            begin
                UpdateShipToPhonePurchase(ShipToOptions);
            end;
        }

        addlast(Control99)
        {
            field("Ship-To Phone"; Rec."Ship-To Phone")
            {
                Caption = 'Phone No.';
                Editable = ShipToOptions = ShipToOptions::"Custom Address";
                Importance = Additional;
                ApplicationArea = All;
            }
        }
        modify("Vendor Order No.")
        {
            Caption = 'Vendor Quote No.';
        }
        addafter(IncomingDocAttachFactBox)
        {
            systempart("Record Links"; Links)
            {
                ApplicationArea = RecordLinks;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action(Links)
            {
                ApplicationArea = all;
                Image = Links;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    RLink: Record "Record Link";
                    str: RecordID;
                begin
                    EVALUATE(str, 'Purchase Header: Order,' + Rec."No.");
                    RLink.RESET();
                    RLink.SETRANGE("Record ID", str);
                    //if RLink.FindSet() then
                    PAGE.RUN(50004, RLink);
                end;
            }
        }
    }

    procedure UpdateShipToPhonePurchase(ShipToOptions: Integer)
    var
        CompanyInfo: Record "Company Information";
        Location: Record Location;
        Customer: Record Customer;
        ShiptoAddr: Record "Ship-to Address";
        blnModify: Boolean;
    begin
        blnModify := false;
        case ShipToOptions of
            0:
                begin
                    CompanyInfo.get();
                    Rec."Ship-To Phone" := CompanyInfo."Phone No.";
                    blnModify := true;
                end;
            1:
                begin
                    Location.Reset();
                    if Location.get(Rec."Location Code") then;
                    Rec."Ship-To Phone" := Location."Phone No.";
                    blnModify := true;
                end;
            2:
                begin
                    if Rec."Ship-to Code" = '' then begin
                        Customer.Reset();
                        if Customer.get(Rec."Sell-to Customer No.") then
                            Rec."Ship-To Phone" := Customer."Phone No.";
                        blnModify := true;
                    end else begin
                        ShiptoAddr.Reset();
                        ShiptoAddr.SetRange(Code, Rec."Ship-to Code");
                        ShiptoAddr.SetRange("Customer No.", Rec."Sell-to Customer No.");
                        if ShiptoAddr.FindFirst() then
                            Rec."Ship-To Phone" := ShiptoAddr."Phone No.";
                        blnModify := true;
                    end;
                end;
        end;
        // if blnModify then
        //     purchaseHeader.Modify();
    end;

    var
        myInt: Integer;
}