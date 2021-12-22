pageextension 50053 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addafter("Requested Delivery Date")
        {
            field("CashFlow SO Due Date"; Rec."CashFlow SO Due Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        modify("External Document No.")
        {
            Caption = 'Customer PO number';
        }

        addafter("External Document No.")
        {
            field("External Document date"; Rec."External Document date")
            {
                ApplicationArea = All;
            }
        }
        // Add changes to page layout here
        addafter(Status)
        {
            field("Sales Order Status"; rec."Sales Order Status")
            {
                ApplicationArea = all;
            }
        }
        modify(Control114)
        {
            Visible = true;
        }
        modify("Quote No.")
        {
            Editable = true;
        }
        modify("No.")
        {
            Visible = true;
        }
        addbefore(Status)
        {

            field("Quotation Validity"; rec."Quotation Validity")
            {
                ApplicationArea = All;
            }
            field("Project Name"; rec."Project Name")
            {
                ApplicationArea = All;
            }
            field("Tax Amount"; rec."Tax Amount")
            {
                ApplicationArea = All;
            }
            field("Delivery Type"; Rec."Delivery Mode")
            {
                ApplicationArea = All;
            }
            field("Delivery Note No."; Rec."Delivery Note No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Cust RFQ. No."; Rec."Cust RFQ. No.")
            {
                ApplicationArea = All;
            }
            field("End User"; Rec."End User")
            {
                ApplicationArea = All;
            }

            field("Modified At"; Rec.SystemModifiedAt)
            {
                ApplicationArea = All;
            }
            field("Portal Order"; Rec."Portal Order")
            {
                ApplicationArea = All;
            }
            field("Customer Mails"; Rec."Customer Mails")
            {
                ApplicationArea = All;
            }
            field("SSE Internal Mails"; Rec."SSE Internal Mails")
            {
                ApplicationArea = All;
            }
            field("Credit Limit(LCY)"; Rec."Credit Limit(LCY)")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Available Credit Limit"; Rec."Available Credit Limit")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Amount Including VAT"; rec."Amount Including VAT")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("MAF Freight"; rec."MAF Freight")
            {
                ApplicationArea = All;
            }
            field("MAF Labour"; Rec."MAF Labour")
            {
                ApplicationArea = All;
            }
            field("MAF Other Cost"; Rec."MAF Other Cost")
            {
                ApplicationArea = All;
            }
            field("MAF Other Cost Desc."; rec."MAF Other Cost Desc.")
            {
                ApplicationArea = All;
            }
            field("Total Weight(KG)"; Rec."Total Weight(KG)")
            {
                ApplicationArea = All;
            }
        }

        addafter("Sales Order Status")
        {
            field("Date of Completion"; Rec."Date of Completion")
            {
                Caption = 'Date of Completion';
                ApplicationArea = All;
            }
        }
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
        modify("No. of Archived Versions")
        {
            ApplicationArea = all;
        }
    }

    actions
    {
        addlast(Reporting)
        {
            action("MAF Report")
            {
                ApplicationArea = All;
                Image = Report;
                trigger OnAction()
                var
                    recsalesheader: Record "Sales Header";
                begin
                    recsalesheader.Reset();
                    recsalesheader.SetRange("No.", rec."No.");
                    Report.RunModal(50013, true, false, recsalesheader);
                end;

            }
        }
        // Add changes to page actions here
        addafter("&Order Confirmation")
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
                var
                    NoSerierMgt: Codeunit NoSeriesManagement;
                    SalRecSetup: Record "Sales & Receivables Setup";
                begin
                    if SalRecSetup.get() then;
                    if rec."Delivery Note No." = '' then begin
                        rec."Delivery Note No." := NoSerierMgt.GetNextNo(SalRecSetup."Delivery Note Nos.", Today, true);
                        rec.Modify();
                        Commit();
                    end;

                    rsalesHeader.SetRange("Document Type", rec."Document Type");
                    rsalesHeader.SetRange("No.", rec."No.");
                    Report.Runmodal(50003, true, false, rsalesHeader);
                end;
            }
        }
        addafter(AttachAsPDF)
        {
            action("Order Acknowledged")
            {
                ApplicationArea = basic, suite;
                Image = ChangeStatus;
                Promoted = true;
                PromotedCategory = Category11;
                trigger OnAction()
                var
                    Automail: Codeunit "Auto Mail";
                begin
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_Order_Acknowledged();
                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
        }
        /*
               modify("Order Issued to Factory")
               {
                   trigger OnAfterAction()
                   var
                       Automail: Codeunit "Auto Mail";
                   begin
                       clear(Automail);
                       Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                   end;
               }
               modify("Good being Manufactured with Date of Completion")
               {
                   trigger OnAfterAction()
                   var
                       Automail: Codeunit "Auto Mail";
                   begin
                       clear(Automail);
                       Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                   end;
               }
               modify("Goods rcvd by SSE and will be checked functionally")
               {
                   trigger OnAfterAction()
                   var
                       Automail: Codeunit "Auto Mail";
                   begin
                       clear(Automail);
                       Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                   end;
               }
               modify("Goods Packed and Ready to Ship")
               {
                   trigger OnAfterAction()
                   var
                       Automail: Codeunit "Auto Mail";
                   begin
                       clear(Automail);
                       Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                   end;
               }
               modify("Goods Delivered")
               {
                   trigger OnAfterAction()
                   var
                       Automail: Codeunit "Auto Mail";
                   begin
                       clear(Automail);
                       Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                   end;
               }
               modify("Goods Delayed")
               {
                   trigger OnAfterAction()
                   var
                       Automail: Codeunit "Auto Mail";
                   begin
                       clear(Automail);
                       Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                   end;
               }
       */
        // addlast(Reporting)
        // {
        //     action(Getbase64String)
        //     {
        //         ToolTip = 'Testing Purpose';
        //         ApplicationArea = All;
        //         Caption = 'Get Base64 String For ProformaInvoice';
        //         trigger OnAction()
        //         var
        //             AutoArchive: Codeunit "Auto Archive Document";
        //         begin
        //             message(AutoArchive.GetBase64StringforSaleOrderPrint(Rec."No."));
        //         end;
        //     }
        // }

        addafter(DocAttach)
        {
            //WIN504>>
            action("Order Issued to Factory")
            {
                Caption = 'Order Issued to Factory';
                ApplicationArea = basic, suite;
                Promoted = true;
                PromotedCategory = Category8;
                Image = ItemGroup;

                trigger OnAction()

                begin
                    //rec.TestField(rec."Sales Order Status", rec."Sales Order Status"::"Order Acknowledged");
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_Order_Issued();
                    rec.Modify();
                    CurrPage.Update();

                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
            action("Good being Manufactured with Date of Completion")
            {
                Caption = 'Good being Manufactured with Date of Completion';
                ApplicationArea = basic, suite;
                Promoted = true;
                PromotedCategory = Category8;
                Image = ItemGroup;

                trigger OnAction()
                begin
                    //rec.TestField(rec."Sales Order Status", rec."Sales Order Status"::"Order Issued to Factory");
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_GoodsManufacturing();
                    rec.Modify();
                    CurrPage.Update();

                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
            action("Goods rcvd by SSE and will be checked functionally")
            {
                Caption = 'Goods rcvd by SSE and will be checked functionally';
                ApplicationArea = basic, suite;
                Promoted = true;
                PromotedCategory = Category8;
                Image = ItemGroup;

                trigger OnAction()
                begin
                    //rec.TestField(rec."Sales Order Status", rec."Sales Order Status"::"Goods being Manufactured");
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_GoodsReceived();
                    rec.Modify();
                    CurrPage.Update();

                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
            //WIN504<<
            action("Goods Packed and Ready to Ship")
            {
                Caption = 'Goods Packed and Ready to Ship';
                ApplicationArea = basic, suite;
                Promoted = true;
                PromotedCategory = Category8;
                Image = ItemGroup;

                trigger OnAction()
                begin
                    //rec.TestField(rec."Sales Order Status", rec."Sales Order Status"::"Goods received & Will be checked");
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_GoodsPacked();
                    rec.Modify();
                    CurrPage.Update();

                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
            action("Goods Delivered")
            {
                Caption = 'Goods Delivered';
                ApplicationArea = basic, suite;
                Promoted = true;
                PromotedCategory = Category8;
                Image = Delivery;

                trigger OnAction()
                begin
                    //rec.TestField(rec."Sales Order Status", rec."Sales Order Status"::"Goods packed ready to ship");
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_GoodsDelivered();
                    rec.Modify();
                    CurrPage.Update();

                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
            //WIN504>>
            action("Goods Delayed")
            {
                Caption = 'Goods Delayed';
                ApplicationArea = basic, suite;
                Promoted = true;
                PromotedCategory = Category8;
                Image = Delivery;

                trigger OnAction()
                begin
                    //rec.TestField(rec."Sales Order Status", rec."Sales Order Status"::"Goods packed ready to ship");
                    if not confirm('Do you want to Updated Status and sent mail notification to Customer?') then
                        exit;
                    rec.Set_SO_GoodsDelayed();
                    rec.Modify();
                    CurrPage.Update();

                    clear(Automail);
                    Automail.AutoMailSalesOrdersPrintConfirmation(Rec);
                end;
            }
            //WIN504<<
        }
    }

    trigger OnAfterGetRecord()
    var
        rCustomer: Record customer;
    begin
        rCustomer.Reset();
        if rCustomer.get(rec."Sell-to Customer No.") then
            rec."Available Credit Limit" := rCustomer.CalcAvailableCredit();
        // Rec.CalcFields("Amount Including VAT", Amount);
        // rec."Tax Amount" := rec."Amount Including VAT" - rec.Amount;
    end;

    var
        Automail: Codeunit "Auto Mail";
        rSalesHeader: Record "sales header";
}