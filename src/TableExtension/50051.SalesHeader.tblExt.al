tableextension 50051 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Quotation Validity"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Tax Amount"; Decimal)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50003; "Delivery Mode"; Option)
        {
            OptionMembers = " ","Self-Collect","Delivery";
            DataClassification = ToBeClassified;
        }
        field(50004; "Portal Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Cust RFQ. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "End User"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Customer Mails"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "SSE Internal Mails"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Credit Limit(LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Credit Limit (LCY)" where("No." = field("Sell-to Customer No.")));
        }
        field(50010; "Available Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "CashFlow SO Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Delivery Note No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Date of Completion"; Date)
        {
            Caption = 'Date of Completion';
            DataClassification = ToBeClassified;
        }
        field(50014; "MAF Freight"; Decimal)
        {
            Caption = 'MAF Freight';
            DataClassification = ToBeClassified;
        }
        field(50015; "MAF Labour"; Decimal)
        {
            Caption = 'MAF Labour';
            DataClassification = ToBeClassified;
        }
        field(50016; "MAF Other Cost"; Decimal)
        {
            Caption = 'MAF Other Cost';
            DataClassification = ToBeClassified;
        }
        field(50017; "Total Weight(KG)"; Decimal)
        {
            Caption = 'Total Weight(KG)';
            DataClassification = ToBeClassified;
        }
        field(50018; "External Document date"; Date)
        {
            Caption = 'External Document Date';
            DataClassification = ToBeClassified;
        }
        field(50019; "MAF Other Cost Desc."; text[200])
        {
            Caption = 'MAF Other Cost Description';
            DataClassification = ToBeClassified;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                rCustomer: Record Customer;
                rSalRecSetup: Record "Sales & Receivables Setup";
            begin
                rSalRecSetup.Reset();
                rSalRecSetup.get();

                rCustomer.Reset();
                if rCustomer.get(Rec."Sell-to Customer No.") then;

                Rec."Customer Mails" := rCustomer."Customer Mails";
                rec."SSE Internal Mails" := rSalRecSetup."SSE Internal Mails";
            end;
        }
        modify("Requested Delivery Date")
        {
            trigger OnAfterValidate()
            var
                Customer: Record customer;
                PaymentTerms: Record "Payment Terms";
                DueDateCalculation: DateFormula;
            begin
                // Customer.Reset();
                // if Customer.get(rec."Sell-to Customer No.") then;
                // if Customer."Payment Method Code" <> '' then begin
                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, "Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    evaluate(DueDateCalculation, '0D');
                if (PaymentTerms."Due Date Calculation" <> DueDateCalculation) and ("Requested Delivery Date" <> 0D) then
                    "CashFlow SO Due Date" := calcdate(PaymentTerms."Due Date Calculation", "Requested Delivery Date")
                else
                    "CashFlow SO Due Date" := "Requested Delivery Date";
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnAfterValidate()
            var
                Customer: Record customer;
                PaymentTerms: Record "Payment Terms";
                DueDateCalculation: DateFormula;
            begin
                // Customer.Reset();
                // if Customer.get(rec."Sell-to Customer No.") then;
                // if Customer."Payment Method Code" <> '' then begin
                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, "Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    evaluate(DueDateCalculation, '0D');
                if (PaymentTerms."Due Date Calculation" <> DueDateCalculation) and ("Requested Delivery Date" <> 0D) then
                    "CashFlow SO Due Date" := calcdate(PaymentTerms."Due Date Calculation", "Requested Delivery Date")
                else
                    "CashFlow SO Due Date" := "Requested Delivery Date";
            end;
        }

    }
    trigger OnInsert()
    var
        GenJourBatch: Record "Gen. Journal Batch";
    begin
        GenJourBatch.Init();
        GenJourBatch."Journal Template Name" := 'CASHRCTPL';
        GenJourBatch.Name := "No.";
        GenJourBatch."Bal. Account Type" := GenJourBatch."Bal. Account Type"::"G/L Account";
        GenJourBatch."Template Type" := GenJourBatch."Template Type"::"Cash Receipts";
        GenJourBatch."Copy VAT Setup to Jnl. Lines" := true;
        GenJourBatch.Insert(true);
    end;

    var
        myInt: Integer;
}