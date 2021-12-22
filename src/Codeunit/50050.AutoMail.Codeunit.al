codeunit 50050 "Auto Mail"
{
    trigger OnRun()
    begin

    end;

    procedure AutoMailPurchaseQuoteRejection(var DocumentNo: Code[20])
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        PurcahseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        Purchaser: Record "Salesperson/Purchaser";
        txtCCmail: list of [text];
        txtSubject: Text;
        SMTPSetup: Record "SMTP Mail Setup";
    begin
        SMTPSetup.get();
        PurcahseHeader.Reset();
        PurcahseHeader.SetRange("No.", DocumentNo);
        PurcahseHeader.SetRange("Document Type", PurcahseHeader."Document Type"::Quote);
        if PurcahseHeader.FindFirst() then;

        Clear(SMTPMail);
        Vendor.Reset();
        if Vendor.get(PurcahseHeader."Buy-from Vendor No.") then;

        txtRecipient.Add(Vendor."E-Mail");
        //txtRecipient.Add('janet@winspiresolutions.com');
        txtSubject := PurcahseHeader."No." + ' - ' + PurcahseHeader."Buy-from Vendor No." + ' - Quotation Result';
        SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, txtSubject, '', true);//Sandbox
        Purchaser.Reset();
        if Purchaser.get(PurcahseHeader."Purchaser Code") then;
        txtCCmail.Add(PurcahseHeader."E-Mail");
        SMTPMail.AddCC(txtCCmail);
        //SMTPMail.AddAttachmentStream(IStream, 'Purchase_Order' + PurchaseHeader."No." + '.pdf');

        SMTPMail.AppendBody('Dear Sir / Madam, ');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('We regret that your quotation has not been chosen.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Thank you for your submission and we hope to have a chance to engage your service in the future.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Kind regards, <br>');
        SMTPMail.AppendBody(Purchaser.Name);
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('This is a system generated message, please do not email noreply@sseisolutions.com.');
        SMTPMail.Send;
    end;

    procedure AutoMailRFQ(var PurchaseHeader: Record "Purchase Header")
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        rPurchaser: Record "Salesperson/Purchaser";
        rVendor: Record Vendor;
        txtSubject: Text;
        PurchPaySetup: Record "Purchases & Payables Setup";
        txtCcMail: list of [Text];
        CC_MailList: list of [Text];
        MailCount: Integer;
        intcnt: Integer;
    begin
        Clear(SMTPMail);
        SMTPSetup.get();
        PurchPaySetup.get();
        PurchPaySetup.TestField("SSE RFQ Mails");

        rVendor.Reset();
        if rVendor.get(PurchaseHeader."Buy-from Vendor No.") then;
        rVendor.TestField("E-Mail");
        txtRecipient.Add(rVendor."E-Mail");
        // txtRecipient.Add('keshav.shrivastava@winspiresolutions.com');
        // txtRecipient.Add('janet@winspiresolutions.com');

        txtSubject := PurchaseHeader."No." + ' - ' + PurchaseHeader."Buy-from Vendor Name" + ' - ' + 'Request for Quotation';

        CC_MailList := PurchPaySetup."SSE RFQ Mails".Split(';');
        MailCount := CC_MailList.Count;
        intCnt := 0;
        repeat
            intCnt += 1;
            txtCcMail.Add(CC_MailList.Get(intCnt));
            MailCount -= 1;
        until MailCount = 0;

        SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, txtSubject, '', true);//Sandbox
        SMTPMail.AddCC(txtCcMail);
        SMTPMail.AppendBody('Dear Vendor, ');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Kindly access our Vendor Portal  <a href="http://52.187.0.115/SSEVendorPortal">Vendor Portal</a> to retrieve the details of our request for quotation and to submit your corresponding quotation before the deadline ' + Format(purchaseheader."Quote Submission Deadline") + '.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Do confirm our required date of delivery ' + Format(PurchaseHeader."Requested Receipt Date") + ' and check that you have uploaded a copy of your quotation.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('If you need further clarification or assistance, please email the undersigned.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Thank you and have a nice day.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Kind regards, <br>');

        rPurchaser.Reset();
        if rPurchaser.get(PurchaseHeader."Purchaser Code") then;

        SMTPMail.AppendBody(rPurchaser.Name + '<br><br>');
        SMTPMail.AppendBody('This is a system generated message, please do not email noreply@sseisolutions.com.');
        if SMTPMail.Send then
            Message('Requisition %1 has been converted to Quote %2, and Mail Sent', PurchaseHeader."PR Ref. No.", PurchaseHeader."No.");
        ;
    end;

    procedure AutoMailOnMakeOrder(var PurchaseHeader: Record "Purchase Header")
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        txtSubject: text;
        vendor: Record Vendor;
        SMTPSetup: Record "SMTP Mail Setup";
        Purchaser: Record "Salesperson/Purchaser";
        txtCCmail: list of [Text];
    begin
        SMTPSetup.get();
        Clear(SMTPMail);
        Vendor.Reset();
        if Vendor.get(PurchaseHeader."Buy-from Vendor No.") then;
        vendor.TestField("E-Mail");
        txtRecipient.Add(Vendor."E-Mail");

        txtSubject := PurchaseHeader."No." + ' - ' + PurchaseHeader."Buy-from Vendor No." + ' - ' + PurchaseHeader."Vendor Order No." + ' - Quotation Accepted';
        SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, txtSubject, '', true);//Sandbox
        Purchaser.Reset();
        if Purchaser.get(PurchaseHeader."Purchaser Code") then;
        Purchaser.TestField("E-Mail");
        txtCCmail.Add(PurchaseHeader."E-Mail");
        SMTPMail.AddCC(txtCCmail);

        SMTPMail.AppendBody('Dear Sir / Madam, ');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Thank you for your quotation.  We are pleased to accept your offer.  Kindly retrieve our purchase order found in our <a href="http://52.187.0.115/SSEVendorPortal">Vendor Portal</a> and acknowledge it.');
        //SMTPMail.AppendBody(', Which has been released. ');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('If you need further clarification or assistance, please email me (refer to cc field).');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Kind regards, <br>');
        SMTPMail.AppendBody(Purchaser.Name);
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('This is a system generated message, please do not email noreply@sseisolutions.com.');
        SMTPMail.Send;
    end;

    procedure AutoMailSalesOrdersPrintConfirmation(var SalesHeader: Record "Sales Header")
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        MailSubject: text;
        CompanyInfo: Record "Company Information";
        // CompanyLogo: Record TempBlob temporary;
        cduCompanyLogo: Codeunit "Temp Blob";
        // CompanyLogo2: Record TempBlob temporary;
        cduCompanyLogo2: Codeunit "Temp Blob";
        // CompanyLogo3: Record TempBlob temporary;
        cduCompanyLogo3: Codeunit "Temp Blob";
        FileLogo: Text;
        FileManagement: Codeunit "File Management";
        Salesperson: Record "Salesperson/Purchaser";
    begin
        //Find Attachments>>

        //Find Attachments<<

        SMTPSetup.Reset();
        SMTPSetup.get();
        SalesHeader.TestField("Customer Mails");
        SalesHeader.TestField("SSE Internal Mails");
        Salesperson.Reset();
        Salesperson.get(SalesHeader."Salesperson Code");

        Clear(SMTPMail);
        txtRecipient.Add(SalesHeader."Customer Mails");
        txtRecipient.Add(SalesHeader."SSE Internal Mails");

        MailSubject := SalesHeader."No." + ' - ' + SalesHeader."Sell-to Customer Name" + ' - ' + Format(SalesHeader."Sales Order Status");

        SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, MailSubject, '', true);//Sandbox
        SMTPMail.AppendBody('Dear Sir/Madam, ');
        SMTPMail.AppendBody('<br><br>');

        SMTPMail.AppendBody('Customer Name : ' + salesheader."Sell-to Customer Name");
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Customer Order Ref. : ' + salesheader."External Document No.");
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('SSE SO Reference : ' + SalesHeader."No.");
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Date of Order Status : ' + format(Today));
        SMTPMail.AppendBody('<br>');
        SMTPMail.AppendBody('Status of Order : ' + format(salesheader."Sales Order Status"));
        SMTPMail.AppendBody('<br>');
        if SalesHeader."Sales Order Status" in [SalesHeader."Sales Order Status"::"Goods being Manufactured", SalesHeader."Sales Order Status"::"Goods Delayed"] then begin
            SMTPMail.AppendBody('Date of Completion : ' + format(salesheader."Date of Completion"));
            SMTPMail.AppendBody('<br>');
        end;
        SMTPMail.AppendBody('Remarks : ' + SalesHeader.GetWorkDescription());
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('This is a system generated message, please do not reply to this email.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Kind Regards<br>');
        SMTPMail.AppendBody(Salesperson.Name + '<br><br>');


        // SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="https://sseisolutions.com/templates/sse/images/logo.gif" height=58px>');
        SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="data:image/png;base64,' + ConvertBlobIntoBase64(CompanyInfo) + '" height="58px" width="174px">');
        SmtpMail.AppendBody('<br>');
        SmtpMail.AppendBody('<b><font color="red" size="4">S</font><font color="#000080">afety</font> <font color="red" size="4">S</font><font color="#000080">ystems</font> <font color="blue" size="4">E</font><font color="#000080">ngineering Pte Ltd</font></b>');
        SmtpMail.AppendBody('<br>');
        SmtpMail.AppendBody('<font color="#000080">1 Kaki Bukit Road 1,100 #02-17,</font>');
        SmtpMail.AppendBody('<br>');
        SmtpMail.AppendBody('<font color="#000080">Enterprise One, Singapore 415934 </font>');
        SmtpMail.AppendBody('<br>');
        SmtpMail.AppendBody('<font color="#000080">Tel: +65-6788 2048,      Fax: +65-6749 7991</font>');
        SmtpMail.AppendBody('<br>');

        SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="data:image/png;base64,' + ConvertBlobIntoBase64_2(CompanyInfo) + '" height="31px" width="127px">');
        SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="data:image/png;base64,' + ConvertBlobIntoBase64_3(CompanyInfo) + '" height="31px" width="127px">');
        // SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="https://sseisolutions.com/templates/sse/images/iso.gif" height=62px>');

        if SMTPMail.Send() then
            Message('Sales Order Status Update Mail Send.');
        ;
    end;

    // procedure AutoMailOnSalesQuote(var SalesHeader: Record "Sales Header")
    // var
    //     recRef: RecordRef;
    //     OStream: OutStream;
    //     IStream: InStream;
    //     TempBlob: Codeunit "Temp Blob";
    // begin
    //     recRef.Gettable(SalesHeader);
    //     TempBlob.CreateOutstream(OStream);

    //     REPORT.SAVEAS(Report::"Sales - Quote SSE", '', REPORTFORMAT::Pdf, OStream, recRef);
    //     TempBlob.CreateInStream(IStream);

    //     Clear(SMTPMail);
    //     txtRecipient.Add('keshav.shrivastava@winspiresolutions.com');
    //     txtRecipient.Add('janet@winspiresolutions.com');
    //     //txtRecipient.Add(SalesHeader."Sell-to E-Mail");
    //     SMTPMail.CreateMessage('SSE Mail', 'keshav.shrivastava@winspiresolutions.com', txtRecipient, 'Sales Quote Test Mail', '', true);//Sandbox

    //     SMTPMail.AddAttachmentStream(IStream, 'Sales_Quote' + SalesHeader."No." + '.pdf');

    //     SMTPMail.AppendBody('Dear Sir / Madam, ');
    //     SMTPMail.AppendBody('<br><br>');

    //     SMTPMail.AppendBody('Please find herewith the Sales Quote : ' + salesheader."No.");
    //     SMTPMail.AppendBody(', It''s a Reminder Mail.');
    //     SMTPMail.AppendBody('<br><br>');
    //     SMTPMail.AppendBody('Yours Truely, <br>');
    //     SMTPMail.AppendBody('SSE <br>');
    //     SMTPMail.Send;
    // end;

    // procedure SendMail()
    // VAR
    //     CustLedgerEntry: Record "Cust. Ledger Entry";
    //     UserSetup: Record "User Setup";
    // begin
    //     UserSetup.Reset();
    //     UserSetup.SetRange("User ID", UserId);
    //     if UserSetup.FindFirst() then
    //         REPEAT
    //             CustLedgerEntry.RESET;
    //             CustLedgerEntry.SetFilter(CustLedgerEntry."Due Date", '%1', WorkDate());
    //             CustLedgerEntry.SetRange(Open, true);
    //             IF CustLedgerEntry.FINDFIRST THEN BEGIN
    //                 SMTPMail.CreateMessage('NameMail-Keshav', 'SenderMailID', 'MailIdsButInListofText', 'Subject', '', TRUE);
    //                 SMTPMail.AddCC('ccMailIdsButInListofText');

    //                 SMTPMail.AppendBody('Dear ' + CustLedgerEntry."Customer Name" + ',');
    //                 SMTPMail.AppendBody('<br><br>');
    //                 SMTPMail.AppendBody('........Email Body......');
    //                 SMTPMail.AppendBody('<br><br>');
    //                 //Table Start
    //                 SMTPMail.AppendBody('<HTML>');
    //                 SMTPMail.AppendBody('<Table border = "1">');
    //                 SMTPMail.AppendBody('<TR>' + '<TD width="20%">' + '<B>' + 'Document No.' + '</B>' + 'ENU=</TD>');
    //                 SMTPMail.AppendBody('<td width="20%">' + '<B>' + 'Document Date ' + '</B>' + 'ENU=</TD>');
    //                 SMTPMail.AppendBody('<td width="20%">' + '<B>' + 'Amount ' + '</B>' + 'ENU=</TD>');
    //                 REPEAT
    //                     SMTPMail.AppendBody('<TR>' + 'ENU="<TD  width=""20%"" Align=Center>"' + FORMAT(CustLedgerEntry."Document No.") + 'ENU=</TD>');
    //                     SMTPMail.AppendBody('ENU="<TD  width=""20%"" Align=Center>"' + FORMAT(CustLedgerEntry."Posting Date") + 'ENU =</ TD >');
    //                     SMTPMail.AppendBody('ENU="<TD  width=""20%"" Align=Center>"' + FORMAT(ABS(CustLedgerEntry.Amount)) + 'ENU=</TD>');

    //                 UNTIL CustLedgerEntry.NEXT = 0;
    //                 SMTPMail.AppendBody('</TR>');
    //                 SMTPMail.AppendBody('</Table>');
    //                 SMTPMail.AppendBody('</HTML>');

    //                 //Table End
    //                 SMTPMail.AppendBody('<br><br>');
    //                 SMTPMail.AppendBody('Regards,');
    //                 SMTPMail.AppendBody('<br>');
    //                 SMTPMail.AppendBody(CompanyName);
    //                 SMTPMail.Send;
    //             END;
    //         UNTIL UserSetup.NEXT = 0;
    // end;

    procedure SOAAutoMail(Customer: Record Customer)
    var
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        txtSubject: Text;
        SSESOA: Report "Standard Statement - SSE";
        StartDate: Date;
        EndDate: Date;
        SalRecSetup: Record "Sales & Receivables Setup";
        txtCCMails: List of [text];
        ReceiptMailList: list of [text];
        MailCount: Integer;
        intCnt: Integer;
        CC_MailList: list of [text];
        rCLE: Record "Cust. Ledger Entry";
    begin
        SMTPSetup.get();
        SalRecSetup.get();
        SalRecSetup.TestField("Finance E-mails");
        Customer.Reset();
        Customer.SetFilter(Customer."SOA Customer E-mails", '<>%1', '');
        Customer.SetRange("Send SOA", true);
        if Customer.FindFirst() then
            repeat
                StartDate := calcdate('-1M-CM', Today());
                EndDate := CalcDate('-1M+CM', today());
                rCLE.Reset();
                rCLE.SetRange("Customer No.", Customer."No.");
                rCLE.SetRange("Posting Date", StartDate, EndDate);
                rCLE.SetRange(Open, true);
                if rCLE.FindFirst() then begin
                    recRef.Gettable(Customer);
                    TempBlob.CreateOutstream(OStream);
                    Clear(SSESOA);
                    SSESOA.SetVariables(StartDate, EndDate, true, true, true);
                    SSESOA.SetTableView(Customer);
                    SSESOA.SaveAs('', ReportFormat::Pdf, OStream, recRef);
                    //REPORT.SAVEAS(Report::"Standard Statement - SSE", '', REPORTFORMAT::Pdf, OStream, recRef);
                    TempBlob.CreateInStream(IStream);

                    Clear(SMTPMail);

                    ReceiptMailList := Customer."SOA Customer E-mails".Split(';');
                    MailCount := ReceiptMailList.Count;
                    intCnt := 0;
                    repeat
                        intCnt += 1;
                        txtRecipient.Add(ReceiptMailList.Get(intCnt));
                        MailCount -= 1;
                    until MailCount = 0;

                    txtSubject := 'Statement of Account ' + FORMAT(StartDate, 0, '<Month Text> <Year4>') + ' - ' + Customer.Name;
                    SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, txtSubject, '', true);

                    CC_MailList := SalRecSetup."Finance E-mails".Split(';');
                    MailCount := CC_MailList.Count;
                    intCnt := 0;
                    repeat
                        intCnt += 1;
                        txtCCMails.Add(CC_MailList.Get(intCnt));
                        MailCount -= 1;
                    until MailCount = 0;

                    SMTPMail.AddCC(txtCCMails);
                    SMTPMail.AddAttachmentStream(IStream, 'SOA' + Customer."No." + '.pdf');

                    SMTPMail.AppendBody('Dear Customer, ');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Good day');
                    SMTPMail.AppendBody('<br><br>');

                    SMTPMail.AppendBody('Please find attached SOA. Kindly contact us (per emails in cc field) if there is any discrepancy, otherwise we look forward to your prompt settlement.');

                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('Kind regards, <br>');
                    SMTPMail.AppendBody('SSE accounts department <br>');
                    SMTPMail.AppendBody('Tel: 6788 2048 <br>');
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AppendBody('This is a system generated message, please do not email noreply@sseisolutions.com.');

                    SMTPMail.Send;
                end;
            until (Customer.Next() = 0);
    end;

    procedure SalesQuotationFollowup(DocumentNo: code[20])
    var
        SalesHeader: Record "Sales Header";
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        MailSubject: text;
        SalesPersons: Record "Salesperson/Purchaser";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", DocumentNo);
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
        if SalesHeader.FindFirst() then begin

            SMTPSetup.Reset();
            SMTPSetup.get();
            SalesHeader.TestField("Customer Mails");
            SalesHeader.TestField("SSE Internal Mails");

            recRef.Gettable(SalesHeader);
            TempBlob.CreateOutstream(OStream);

            REPORT.SAVEAS(Report::"Sales - Quote SSE", '', REPORTFORMAT::Pdf, OStream, recRef);
            TempBlob.CreateInStream(IStream);

            SalesPersons.Reset();
            SalesPersons.get(SalesHeader."Salesperson Code");

            Clear(SMTPMail);
            txtRecipient.Add(SalesHeader."Customer Mails");
            txtRecipient.Add(SalesHeader."SSE Internal Mails");

            MailSubject := SalesHeader."No." + ' - ' + SalesHeader."Sell-to Customer Name" + ' - ' + 'Follow Up';

            SMTPMail.CreateMessage('SSE Mail', SMTPSetup."User ID", txtRecipient, MailSubject, '', true);//Sandbox
            SMTPMail.AddAttachmentStream(IStream, 'Sales_Quote' + SalesHeader."No." + '.pdf');
            SMTPMail.AppendBody('Dear Sir/Madam, ');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Thank you for the opportunity to quote to you. Please advise if our quotation meets your requirements. Please do not hesitate to contact me (per email in cc field) for any clarifications.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('We hope to be of service to you.');
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AppendBody('Kind Regards<br>');
            SMTPMail.AppendBody(SalesPersons.Name);
            SMTPMail.AppendBody('This is a system generated message, please do not email noreply@sseisolutions.com.');
            if SMTPMail.Send() then
                Message('Follow Up Mail Sent..');
        end;
    end;

    local procedure ConvertBlobIntoBase64(CompanyInfo: Record "Company Information") ReturnBase64: text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        InStr: InStream;
    begin
        CompanyInfo.get();
        CompanyInfo.CALCFIELDS(Picture);
        CompanyInfo.Picture.CreateInStream(InStr);

        ReturnBase64 := Base64.ToBase64(InStr);
    end;

    local procedure ConvertBlobIntoBase64_2(CompanyInfo: Record "Company Information") ReturnBase64: text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        InStr: InStream;
    begin
        CompanyInfo.get();
        CompanyInfo.CALCFIELDS("Picture 2");
        CompanyInfo."Picture 2".CreateInStream(InStr);

        ReturnBase64 := Base64.ToBase64(InStr);
    end;

    local procedure ConvertBlobIntoBase64_3(CompanyInfo: Record "Company Information") ReturnBase64: text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        InStr: InStream;
    begin
        CompanyInfo.get();
        CompanyInfo.CALCFIELDS("Picture 3");
        CompanyInfo."Picture 3".CreateInStream(InStr);

        ReturnBase64 := Base64.ToBase64(InStr);
    end;

    var
        XmlParameters: Text;
        txtRecipient: List of [Text];
        FileDirectory: text;
        FileName: Text;
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
}