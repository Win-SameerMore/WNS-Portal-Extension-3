codeunit 50052 "Auto Archive Document"
{
    Permissions = tabledata "Sales Invoice Header" = rm;

    trigger OnRun()
    begin

    end;

    [ServiceEnabled]
    procedure ArchivePurchaseOrderDocumentPortal(DocumentNo: code[20])
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Document Type", purchaseHeader."Document Type"::Order);
        PurchaseHeader.SetRange("No.", DocumentNo);
        if PurchaseHeader.FindFirst() then begin
            cduArchiveManagement.ArchivePurchDocument(PurchaseHeader);
        end;
    end;

    [ServiceEnabled]
    procedure ArchivePurchaseQuoteDocumentPortal(DocumentNo: code[20])
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Document Type", purchaseHeader."Document Type"::Quote);
        PurchaseHeader.SetRange("No.", DocumentNo);
        if PurchaseHeader.FindFirst() then begin
            cduArchiveManagement.ArchivePurchDocument(PurchaseHeader);
        end;
    end;

    [ServiceEnabled]
    procedure AutoMailOnSalesOrderPortal(DocumentNo: code[20])
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", DocumentNo);
        if not SalesHeader.FindFirst() then
            exit;

        recRef.Gettable(SalesHeader);
        TempBlob.CreateOutstream(OStream);

        //REPORT.SAVEAS(Report::"Proforma Invoice - SSE", '', REPORTFORMAT::Pdf, OStream, recRef);
        TempBlob.CreateInStream(IStream);

        Customer.Reset();
        if Customer.get(SalesHeader."Sell-to Customer No.") then
            Customer.TestField("Customer Mails");
        //SalesHeader.TestField("SSE Internal Mails");

        SmtpSetup.Reset();
        SmtpSetup.get();
        SmtpSetup.TestField("User ID");

        Clear(SMTPMail);
        txtRecipient.Add(Customer."Customer Mails");
        txtRecipient.Add('janet@winspiresolutions.com');
        SMTPMail.CreateMessage('SSE Mail', SmtpSetup."User ID", txtRecipient, 'Sales Order Test Mail', '', true);

        //SMTPMail.AddAttachmentStream(IStream, 'Sales_Order' + SalesHeader."No." + '.pdf');

        SMTPMail.AppendBody('Dear Sir / Madam, ');
        SMTPMail.AppendBody('<br><br>');

        SMTPMail.AppendBody('Please find herewith the Sales Order : ' + salesheader."No.");
        SMTPMail.AppendBody(', Sales Order has been created');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Yours Truely, <br>');
        SMTPMail.AppendBody('SSE <br>');
        SMTPMail.Send;
    end;

    [ServiceEnabled]
    procedure UpdateSalesInvoicePaymentStatus(var DocumentNo: Code[20])
    var
        SalesInvHeader: Record "sales invoice header";
    begin
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", DocumentNo);
        if SalesInvHeader.FindSet(true, false) then begin
            SalesInvHeader."Payment Status (Paid)" := true;
            SalesInvHeader.Modify();
        end;
    end;

    [ServiceEnabled]
    procedure GetBase64StringforSaleOrderPrint(DocumentNo: Code[20]) ReturnBase64String: Text
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        SalesHeader: Record "Sales Header";
        base64Convert: Codeunit "Base64 Convert";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("No.", DocumentNo);
        if not SalesHeader.FindFirst() then
            exit;

        recRef.Gettable(SalesHeader);
        TempBlob.CreateOutstream(OStream);

        REPORT.SAVEAS(Report::"Proforma Invoice - SSE", '', REPORTFORMAT::Pdf, OStream, recRef);
        TempBlob.CreateInStream(IStream);
        ReturnBase64String := base64Convert.ToBase64(IStream);
    end;

    [ServiceEnabled]
    procedure ClearPortalShoppingCart(CustomerNo: code[20])
    var
        ShoppingCart: Record "Shopping Cart";
    begin
        shoppingCart.Reset();
        ShoppingCart.SetRange("Customer No.", CustomerNo);
        ShoppingCart.SetRange("Converted to Order", false);
        shoppingCart.SetRange("Cart Type", ShoppingCart."Cart Type"::Cart);
        if ShoppingCart.FindSet(true, true) then
            ShoppingCart.DeleteAll();
    end;

    [ServiceEnabled]
    procedure GetItemParentCategory(CatCode: code[20]) ParentCat: Text
    var
        ItemCategory: Record "Item Category";
        rItemCategory: Record "Item Category";
        blnCheck: Boolean;
    begin
        ParentCat := '';
        if CatCode = '' then
            Error('Category Code must not be blank!');
        repeat
            ItemCategory.Reset();
            if ParentCat = '' then
                ItemCategory.SetRange(Code, CatCode)
            else
                ItemCategory.SetFilter(Code, ParentCat);
            if ItemCategory.FindFirst() then begin
                if not ItemCategory."Has Children" then
                    exit(ParentCat);

                if ParentCat = '' then
                    ParentCat := ItemCategory."Parent Category"
                else
                    ParentCat += '|' + ItemCategory."Parent Category";

                rItemCategory.Reset();
                rItemCategory.SetFilter(Code, ParentCat);
                if rItemCategory.FindFirst() then begin
                    if not rItemCategory."Has Children" then begin
                        exit(ParentCat);
                    end;

                    if ParentCat = '' then
                        ParentCat := ItemCategory."Parent Category"
                    else
                        ParentCat += '|' + ItemCategory."Parent Category";
                end;
            end;
        until blncheck;
    end;

    [ServiceEnabled]
    procedure GetChildItemCategoryTest(CatCode: code[20]) ChildCatCodes: Text
    var
        ItemCategory: Record "Item Category";
        rItemCategory: Record "Item Category";
        blnSkip: Boolean;
        FilterCatCode: Text;
    begin
        if CatCode = '' then
            Error('Category Code must not be blank..');
        FilterCatCode := CatCode;
        ChildCatCodes := CatCode;
        repeat
            blnSkip := true;
            ItemCategory.Reset();
            ItemCategory.SetRange("Parent Category", FilterCatCode);
            if ItemCategory.FindFirst() then begin
                blnSkip := false;
                FilterCatCode := ItemCategory.Code;
                if StrPos(ChildCatCodes, FilterCatCode) = 0 then
                    if ChildCatCodes = '' then
                        ChildCatCodes := ItemCategory.Code
                    else
                        ChildCatCodes += '|' + ItemCategory.Code;
            end;
        until blnSkip;

        exit(ChildCatCodes);
    end;

    procedure GetChildItemCategory(CatCode: code[20]) ChildCatCodes: Text
    var
        ItemCategory: Record "Item Category";
        rItemCategory: Record "Item Category";
        blnSkip: Boolean;
        FilterCatCode: Text;
    begin
        if CatCode = '' then
            Error('Category Code must not be blank..');
        FilterCatCode := CatCode;
        ChildCatCodes := CatCode;
        repeat
            blnSkip := true;
            ItemCategory.Reset();
            ItemCategory.SetRange("Parent Category", FilterCatCode);
            if ItemCategory.FindFirst() then begin
                repeat
                    blnSkip := false;
                    FilterCatCode := ItemCategory.Code;
                    if StrPos(ChildCatCodes, FilterCatCode) = 0 then
                        if ChildCatCodes = '' then
                            ChildCatCodes := ItemCategory.Code
                        else
                            ChildCatCodes += '|' + ItemCategory.Code;
                until ItemCategory.Next = 0;
            end;
        until blnSkip;

        exit(ChildCatCodes);
    end;

    [ServiceEnabled]
    procedure CerditLimitApprovalRequestOnPortal(DocumentNo: Code[20]): Text;
    var
        SalesHeader: Record "Sales header";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        UserSetup: Record "user setup";
        AppUserSetup: Record "user setup";
        rSalesHeader: Record "Sales header";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", DocumentNo);
        if SalesHeader.FindFirst() then
            if ApprovalMgt.CheckSalesApprovalPossible(SalesHeader) then begin
                ApprovalMgt.OnSendSalesDocForApproval(SalesHeader);

                rSalesHeader.Reset();
                rSalesHeader.SetRange("No.", DocumentNo);
                if rSalesHeader.FindFirst() then
                    if rSalesHeader.Status = rSalesHeader.Status::"Pending Approval" then begin

                        UserSetup.reset();
                        if UserSetup.get(UserId) then;
                        AppUserSetup.Reset();
                        if AppUserSetup.get(UserSetup."Approver ID") then;

                        SmtpSetup.get();
                        Clear(SMTPMail);
                        txtRecipient.Add(AppUserSetup."E-Mail");
                        txtRecipient.Add('keshav.shrivastava@winspiresolutions.com');

                        SMTPMail.CreateMessage('SSE Mail', SmtpSetup."User ID", txtRecipient, 'Sales Order Approval Limit Mail', '', true);
                        SMTPMail.AppendBody('Dear Sir / Madam, ');
                        SMTPMail.AppendBody('<br><br>');

                        SMTPMail.AppendBody('You have received Sales Order : ' + salesheader."No.");
                        SMTPMail.AppendBody(', for Approval.');
                        SMTPMail.AppendBody('<br><br>');
                        SMTPMail.AppendBody('Yours Truely, <br>');
                        SMTPMail.AppendBody('SSE <br>');
                        if SMTPMail.Send then
                            exit('Approval Entry Created and Mail send to the Approver');
                    end;
            end;
    end;

    var
        cduArchiveManagement: Codeunit ArchiveManagement;
        SMTPMail: Codeunit "SMTP Mail";
        txtRecipient: List of [Text];
        SmtpSetup: Record "SMTP Mail Setup";

}