tableextension 50062 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50020; "PO Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(50021; "Order Acknowledged"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Ship-To Phone"; Text[30])
        {
            Caption = 'Ship-To Phone';
            DataClassification = ToBeClassified;
        }
        field(50023; "Cashflow PO Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "SSE Remarks"; Blob)
        {
            Caption = 'SSE Remarks';
            DataClassification = ToBeClassified;
        }
        field(50025; "Vendor Remarks"; Blob)
        {
            Caption = 'Vendor Remarks';
            DataClassification = ToBeClassified;
        }
        field(50026; "Vendor Shipment Date"; Date)
        {
            Caption = 'Vendor Shipmert Date';
            DataClassification = ToBeClassified;
        }
        field(50027; "PO Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = ,"On time","Potential Delay",Late;
        }
        field(50028; "Freight Estimated Days"; DateFormula)
        {
            Caption = 'Freight Estimated Days';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Order Completion Date" := CalcDate("Freight Estimated Days", "Committed Delivery Date");
            end;
        }
        field(50029; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";

            /* trigger OnValidate()
            var
                IsHandled: Boolean;
            begin
                IsHandled := false;
                OnBeforeValidateShippingAgentCode(Rec, IsHandled, xRec, CurrFieldNo);
                if IsHandled then
                    exit;

                TestStatusOpen;
                if xRec."Shipping Agent Code" = "Shipping Agent Code" then
                    exit;

                "Shipping Agent Service Code" := '';
                GetShippingTime(FieldNo("Shipping Agent Code"));

                OnValidateShippingAgentCodeOnBeforeUpdateLines(Rec, CurrFieldNo, HideValidationDialog);
                UpdateSalesLinesByFieldNo(FieldNo("Shipping Agent Code"), CurrFieldNo <> 0);
            end; */
        }
        field(50030; "Actual Freight Cost"; Decimal)
        {
            Caption = 'Actual Freight Cost';
            DataClassification = ToBeClassified;
        }


        modify("Expected Receipt Date")
        {
            trigger OnAfterValidate()
            var
                rVendor: Record Vendor;
                PaymentTerms: Record "Payment Terms";
                DueDateCalculation: DateFormula;
            begin
                // rVendor.Reset();
                // if rVendor.get("Buy-from Vendor No.") then
                //     if rVendor."Payment Terms Code" <> '' then begin
                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, "Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    evaluate(DueDateCalculation, '0D');
                if (PaymentTerms."Due Date Calculation" <> DueDateCalculation) and ("Expected Receipt Date" <> 0D) then
                    "Cashflow PO Due Date" := CalcDate(paymentterms."Due Date Calculation", "Expected Receipt Date")
                else
                    "Cashflow PO Due Date" := "Expected Receipt Date";

            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            var
                rVendor: Record Vendor;
                PaymentTerms: Record "Payment Terms";
                DueDateCalculation: DateFormula;
            begin
                // rVendor.Reset();
                // if rVendor.get("Buy-from Vendor No.") then
                //     if rVendor."Payment Terms Code" <> '' then begin
                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, "Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    evaluate(DueDateCalculation, '0D');
                if (PaymentTerms."Due Date Calculation" <> DueDateCalculation) and ("Expected Receipt Date" <> 0D) then
                    "Cashflow PO Due Date" := CalcDate(paymentterms."Due Date Calculation", "Expected Receipt Date")
                else
                    "Cashflow PO Due Date" := "Expected Receipt Date";

            end;
        }
        modify("Sales Order")
        {
            trigger OnAfterValidate()
            var
                Automail: Codeunit "Auto Mail";
                SalesHeader: Record "Sales header";
            begin
                clear(Automail);

                SalesHeader.Reset();
                SalesHeader.SetRange("No.", "Sales Order");
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type");
                if SalesHeader.FindFirst() then
                    Automail.AutoMailSalesOrdersPrintConfirmation(SalesHeader);
            end;
        }
        modify("Order Completion Date")
        {
            trigger OnAfterValidate()
            var
                Automail: Codeunit "Auto Mail";
                SalesHeader: Record "Sales header";
            begin
                clear(Automail);

                SalesHeader.Reset();
                SalesHeader.SetRange("No.", "Sales Order");
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type");
                if SalesHeader.FindFirst() then
                    Automail.AutoMailSalesOrdersPrintConfirmation(SalesHeader);
            end;
        }
        modify("Committed Delivery Date")
        {
            trigger OnAfterValidate()
            begin
                "Order Completion Date" := CalcDate("Freight Estimated Days", "Committed Delivery Date");
            end;
        }

    }
    procedure SetSSERemarks(NewSSERemarks: Text)
    var
        OutStream: OutStream;
    begin
        Clear("SSE Remarks");
        "SSE Remarks".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewSSERemarks);
        Modify;
    end;

    procedure GetSSERemarks() SSERemarks: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("SSE Remarks");
        "SSE Remarks".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), SSERemarks) then
            Message(ReadingDataSkippedMsg, FieldCaption("SSE Remarks"));
    end;

    procedure SetVendorRemarks(NewVendorRemarks: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Vendor Remarks");
        "Vendor Remarks".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewVendorRemarks);
        Modify;
    end;

    procedure GetVendorRemarks() VendorRemarks: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Vendor Remarks");
        "Vendor Remarks".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), VendorRemarks) then
            Message(ReadingDataSkippedMsg, FieldCaption("Vendor Remarks"));
    end;

    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';

}