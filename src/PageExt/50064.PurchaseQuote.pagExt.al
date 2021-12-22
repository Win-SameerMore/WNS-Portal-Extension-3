pageextension 50064 "Purchase Quote Ext" extends "Purchase Quote"
{
    layout
    {
        // Add changes to page layout here
        modify("Shipment Method Code")
        {
            ApplicationArea = all;
        }
        addafter("Buy-from Vendor Name")
        {
            field("PO Vendor No."; Rec."PO Vendor No.")
            {
                ApplicationArea = All;
                //Visible = rec."Public Quotation" and rec."Reg. Vendor Quotation";
            }
        }
        addafter(Status)
        {
            group("SSE Remarks")
            {
                Caption = 'SSE Remarks';
                field(SSERemarks; SSERemarks)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    trigger OnValidate()
                    begin
                        Rec.SetSSERemarks(SSERemarks);
                    end;
                }
            }
            group("Vendor Remarks")
            {
                Caption = 'Vendor Remarks';
                field(VendorRemarks; VendorRemarks)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    trigger OnValidate()
                    begin
                        Rec.SetVendorRemarks(VendorRemarks);
                    end;
                }
            }
        }
        modify("Purchaser Code Name")
        {
            ApplicationArea = All;
        }
        modify("Vendor Order No.")
        {
            Caption = 'Vendor Quote No.';
        }

        addafter(IncomingDocAttachFactBox)
        {
            systempart(Record_Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify("Reject Quote")
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
                AutoMailCodeunit: Codeunit "Auto Mail";
            begin
                AutoMailCodeunit.AutoMailPurchaseQuoteRejection(Rec."No.");
            end;
        }
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
                    EVALUATE(str, 'Purchase Header: Quote,' + Rec."No.");
                    RLink.RESET();
                    RLink.SETRANGE("Record ID", str);
                    //if RLink.FindSet() then
                    PAGE.RUN(50004, RLink);
                end;
            }
            action("Send Mail to vendor for Changes Update")
            {
                ApplicationArea = All;
                Image = SendMail;
                trigger OnAction()
                begin
                    SendMailNotificationToVendor();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SSERemarks := Rec.GetSSERemarks();
        VendorRemarks := Rec.GetVendorRemarks();
    end;

    procedure SendMailNotificationToVendor()
    var
        rVendor: Record Vendor;
        rPurchaser: Record "Salesperson/Purchaser";
        txtSubject: Text;
        recRef: RecordRef;
        OStream: OutStream;
        IStream: InStream;
        //TempBlob: Record TempBlob temporary;
        fileName: text;
        RecordLinks: Record "Record Link";
        PQRecordID: RecordId;
        ReviseNo: Text;
    begin
        SMTPMailSetup.Get();

        rVendor.Reset();
        if rVendor.get(Rec."Buy-from Vendor No.") then;
        rVendor.TestField(rVendor."E-Mail");
        txtRecipient.Add(rVendor."E-Mail");

        Clear(SMTPMail);
        rec.CalcFields("No. of Archived Versions");
        if StrLen(format(rec."No. of Archived Versions")) = 1 then
            ReviseNo := '0' + format(rec."No. of Archived Versions");
        txtSubject := Rec."No." + ' - ' + rec."Buy-from Vendor Name" + ' - Purchase Quote Amendment - ' + ReviseNo;
        SMTPMail.CreateMessage('SSE Mail', SMTPMailSetup."User ID", txtRecipient, txtSubject, '', true);//Sandbox


        // Evaluate(PQRecordID, 'Purchase Header: Quote,' + Rec."No.");
        // RecordLinks.Reset();
        // RecordLinks.SetRange("Record ID", PQRecordID);
        // if RecordLinks.FindFirst() then
        //     repeat
        //         clear(TempBlob);
        //         TempBlob.Blob.CreateInStream(IStream);
        //         //FileName := 'microsoft.pdf';
        //         TempBlob.TryDownloadFromUrl(RecordLinks.URL1);
        //         //DownloadFromStream(IStream, 'Download File', '', '*.*', FileName);
        //         SMTPMail.AddAttachmentStream(IStream, 'PQ_' + Rec."No." + Format(RecordLinks."Link ID") + '.pdf');
        //     until (RecordLinks.Next() = 0);

        rPurchaser.Reset();
        if rPurchaser.get(Rec."Purchaser Code") then;
        rPurchaser.TestField("E-Mail");
        txtCCMail.Add(rPurchaser."E-Mail");
        SMTPMail.AddCC(txtCCMail);

        SMTPMail.AppendBody('Dear Sir/Madam, ');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Please refer to our revised purchase enquiry <a href="http://52.187.0.115/SSEVendorPortal">Vendor Portal</a> for your necessary follow-up action.  Thank you.');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('SSE Remarks: <br>');
        SMTPMail.AppendBody(SSERemarks);//Need to check
        // SMTPMail.AppendBody('<br><br>');
        // SMTPMail.AppendBody('Vendor Remarks: <br>');
        // SMTPMail.AppendBody(VendorRemarks);//Need to check

        SMTPMail.AppendBody('<br><br>If you need further clarification or assistance, please email me (refer to cc field).');
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.AppendBody('Kind regards, <br>');
        SMTPMail.AppendBody(rPurchaser.Name);
        SMTPMail.AppendBody('<br><br>');

        SMTPMail.AppendBody('This is a system generated message, please do not email noreply@sseisolutions.com.<br>');

        Evaluate(PQRecordID, 'Purchase Header: Quote,' + Rec."No.");
        RecordLinks.Reset();
        RecordLinks.SetRange("Record ID", PQRecordID);
        if RecordLinks.FindFirst() then begin
            SMTPMail.AppendBody('<b>Attachments : </b><br>');
            repeat
                SMTPMail.AppendBody('<a href="' + RecordLinks.URL1 + '">' + RecordLinks.Description + '</a>');
                SMTPMail.AppendBody('<br>');
            until (RecordLinks.Next() = 0);
        end;

        if SMTPMail.Send then
            Message('Mail Sent');
    end;

    var
        VendorRemarks: text;
        SSERemarks: Text;
        SMTPMailSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        txtRecipient: list of [Text];
        txtCCMail: list of [Text];
}