codeunit 50051 "Event Subscriber"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnAfterRun', '', false, false)]
    local procedure SendMailAfterMakeOrder(PurchOrderHeader: Record "Purchase Header"; var PurchaseHeader: Record "Purchase Header")
    var
        AutoMailCodeunit: Codeunit "Auto Mail";
    begin

        if (PurchaseHeader."Reg. Vendor Quotation") and (PurchaseHeader."PO Vendor No." <> '') then begin
            PurchOrderHeader.Validate("buy-from vendor no.", PurchaseHeader."PO Vendor No.");
            PurchOrderHeader."PO Vendor No." := '';
            //PurchaseHeader.Modify();
        end;
        AutoMailCodeunit.AutoMailOnMakeOrder(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeRun', '', false, false)]
    local procedure BlockMakeOrderForDummyOrders(var PurchaseHeader: Record "Purchase Header")
    begin
        if not PurchaseHeader."Reg. Vendor Quotation" then
            Error('You can''t create Order For Dummy Vendor.');

        if (PurchaseHeader."Reg. Vendor Quotation") and (PurchaseHeader."Public Quotation") then
            PurchaseHeader.TestField("PO Vendor No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    local procedure OnVendorApproavlPortals(var ApprovalEntry: Record "Approval Entry")
    var
        rApprovalEntry: Record "Approval Entry";
        rVendor: Record Vendor;
        VendorPassword: Text;
        SMTPMail: Codeunit "SMTP Mail";
        txtRecipient: list of [text];
        txtCcmail: list of [text];
        SMTPSetup: Record "SMTP Mail Setup";
        rPurchaser: Record "Salesperson/Purchaser";
        txtSubject: Text;
    begin
        if ApprovalEntry."Table ID" = Database::Vendor then begin
            rApprovalEntry.Reset();
            rApprovalEntry.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
            rApprovalEntry.SetRange("Table ID", Database::Vendor);
            rApprovalEntry.SetFilter(Status, '%1|%2', rApprovalEntry.Status::Open, rApprovalEntry.Status::Created);
            if not rApprovalEntry.FindFirst() then begin
                rVendor.Reset();
                if rVendor.get(ApprovalEntry."Record ID to Approve") then begin
                    rVendor.Blocked := rVendor.Blocked::" ";

                    VendorPassword := '';
                    VendorPassword := CREATEGUID;
                    VendorPassword := DELCHr(VendorPassword, '=', '{}-01');
                    VendorPassword := copystr(VendorPassword, 1, 8);

                    rVendor.WebPassword := VendorPassword;

                    rVendor.Modify();
                    rPurchaser.Reset();
                    if rPurchaser.get(rVendor."Purchaser Code") then;
                    rPurchaser.TestField("E-Mail");
                    rVendor.TestField("E-Mail");

                    Clear(SMTPMail);
                    txtRecipient.Add(rVendor."E-Mail");
                    SMTPSetup.get();
                    txtSubject := rVendor.Name + 'Creation of Account';
                    SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, txtSubject, '', true);//Sandbox
                    txtCcmail.Add(rPurchaser."E-Mail");

                    SMTPMail.AddCC(txtCcmail);
                    SMTPMail.AppendBody('Dear Vendor,');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Your account has been successfully created.  Please access our Vendor Portal [URL] with the following ID and password:');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('User ID: ' + rVendor."No.");
                    SMTPMail.AppendBody('<br>');
                    SMTPMail.AppendBody('Password: ' + VendorPassword);
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('We recommend you change your password after login.  Your password is case sensitive, min 8 characters with alphanumeric and symbols accepted.');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Do not hesitate to contact me if you need any clarification or assistance.<br>Thank you.');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Kind regards, <br>');
                    SMTPMail.AppendBody(rPurchaser.Name + ' <br>');
                    SMTPMail.Send;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    procedure ValidatationForOrderStatus(var SalesHeader: Record "Sales Header")
    begin
        // if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
        //     if SalesHeader."Sales Order Status" <> SalesHeader."Sales Order Status"::"Order Acknowledged" then
        //         Error('Order Status must be Order Ackmowledge!');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnCodeOnAfterGenJnlPostBatchRun', '', false, false)]
    procedure DeleteBatch(var GenJnlLine: Record "Gen. Journal Line")
    var
        GenJourBatch: Record "Gen. Journal Batch";
    begin
        GenJourBatch.Reset();
        GenJourBatch.setrange("Journal Template Name", 'CASHRCTPL');
        GenJourBatch.setrange(Name, GenJnlLine."Journal Batch Name");
        GenJourBatch.setrange("Bal. Account Type", GenJourBatch."Bal. Account Type"::"G/L Account");
        GenJourBatch.setrange("Template Type", GenJourBatch."Template Type"::"Cash Receipts");
        GenJourBatch.setrange("Copy VAT Setup to Jnl. Lines", true);
        if GenJourBatch.FindFirst() then begin
            GenJourBatch.Delete()
        end;
    end;

    procedure GenerateDefaultShiptoAddressForNewCustomer(Customer: Record Customer)
    var
        ShipToAddress: Record "Ship-to Address";
    begin
        ShipToAddress.reset();
        ShipToAddress.SetRange(Code, 'Default');
        ShipToAddress.SetRange("Customer No.", Customer."No.");
        if not ShipToAddress.FindFirst() then begin
            ShipToAddress.Init();
            ShipToAddress.Code := 'Default';
            ShipToAddress."Customer No." := Customer."No.";
            ShipToAddress.Name := Customer.Name;
            ShipToAddress."Name 2" := Customer."Name 2";
            ShipToAddress.Address := Customer.Address;
            ShipToAddress."Address 2" := Customer."Address 2";
            ShipToAddress."Post Code" := Customer."Post Code";
            ShipToAddress.City := Customer.City;
            ShipToAddress."E-Mail" := Customer."E-Mail";
            ShipToAddress.Contact := Customer.Contact;
            ShipToAddress."Country/Region Code" := Customer."Country/Region Code";
            ShipToAddress.County := Customer.County;
            ShipToAddress."Fax No." := Customer."Fax No.";
            ShipToAddress."Home Page" := Customer."Home Page";
            ShipToAddress."Phone No." := Customer."Phone No.";
            ShipToAddress.Insert(true);
        end else begin
            ShipToAddress.Name := Customer.Name;
            ShipToAddress."Name 2" := Customer."Name 2";
            ShipToAddress.Address := Customer.Address;
            ShipToAddress."Address 2" := Customer."Address 2";
            ShipToAddress."Post Code" := Customer."Post Code";
            ShipToAddress.City := Customer.City;
            ShipToAddress."E-Mail" := Customer."E-Mail";
            ShipToAddress.Contact := Customer.Contact;
            ShipToAddress."Country/Region Code" := Customer."Country/Region Code";
            ShipToAddress.County := Customer.County;
            ShipToAddress."Fax No." := Customer."Fax No.";
            ShipToAddress."Home Page" := Customer."Home Page";
            ShipToAddress."Phone No." := Customer."Phone No.";
            ShipToAddress.Modify(true);
        end;
    end;
}