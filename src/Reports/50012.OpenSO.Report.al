report 50012 "Open SO"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './src/Reports/Layout/50012.OpenSO.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "Order Date";
            DataItemTableView = sorting("Document type", "No.") where(Status = filter(Open));
            column(SN; SN)
            { }
            column(No__Series; "No. Series")
            { }
            column(No_; "No.")
            { }
            column(Order_Date; "Order Date")
            { }
            column(Document_Date; "Document Date")
            { }
            column(External_Document_No_; "External Document No.")
            { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Payment_Terms_Code; "Payment Terms Code")
            { }
            column(Shipment_Method_Code; "Shipment Method Code")
            { }
            column(Currency_Code; "Currency Code")
            { }
            column(Requested_Delivery_Date; "Requested Delivery Date")
            { }
            column(companyName; companyInfo.Name)
            { }
            column(Amount_Including_VAT; "Amount Including VAT")
            { }
            column(Amount; Amount)
            { }
            column(VATAmount; "Amount Including VAT" - Amount)
            { }
            column(LYC_Code; RecGLS."LCY Code")
            { }
            column(decSO_Amount_LCY; decSO_Amount_LCY)
            { }
            column(decSO_AmountWithVAT_LCY; decSO_AmountWithVAT_LCY)
            { }
            column(decSO_VAT_LCY; decSO_VAT_LCY)
            { }
            column(decTotalSO_Amount_LCY; decTotalSO_Amount_LCY)
            { }
            column(decTotalSO_AmountWithVAT_LCY; decTotalSO_AmountWithVAT_LCY)
            { }
            column(decTotalSO_VAT_LCY; decTotalSO_VAT_LCY)
            { }
            column(LCYCode; RecGLS."LCY Code")
            { }
            column(decAOAmt; decAOAmt)
            { }
            column(decAOAmtLCY; decAOAmtLCY)
            { }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "sales order" = field("no.");
                column(No_field; "No.")
                { }
                column(PO_Currency; CurrencyCode)
                { }
                column(From_PO_Vendor_Name; "Buy-from Vendor Name")
                { }
                column(PO_Total_excl_of_vat; Amount)
                { }
                column(PO_Amount_Including_VAT; "Amount Including VAT")
                { }
                column(PO_Amount; Amount)
                { }
                column(decPO_Amount_LCY; decPO_Amount_LCY)
                { }
                column(PO_VATAmount; "Amount Including VAT" - Amount)
                { }
                column(decPO_AmountWithVAT_LCY; decPO_AmountWithVAT_LCY)
                { }
                column(decPO_VAT_LCY; decPO_VAT_LCY)
                { }
                trigger OnAfterGetRecord()
                begin
                    RecGLS.Get();
                    if "Currency Code" <> '' then
                        CurrencyCode := "Currency Code"
                    else
                        CurrencyCode := RecGLS."LCY Code";

                    CalcFields("Amount Including VAT");
                    CalcFields(Amount);
                    if "Currency Factor" <> 0 then begin
                        decPO_Amount_LCY := Amount * (1 / "Currency Factor");
                        decPO_AmountWithVAT_LCY := "Amount Including VAT" * (1 / "Currency Factor");
                        decPO_VAT_LCY := ("Amount Including VAT" - Amount) / (1 / "Currency Factor");
                    end else begin
                        decPO_Amount_LCY := Amount;
                        decPO_AmountWithVAT_LCY := "Amount Including VAT";
                        decPO_VAT_LCY := "Amount Including VAT" - Amount;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                SN += 1;
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Sales order", "Sales Header"."No.");
                if PurchaseHeader.FindFirst() then;

                CalcFields("Amount Including VAT");
                CalcFields(Amount);
                if "Currency Factor" <> 0 then begin
                    decSO_Amount_LCY := Amount * (1 / "Currency Factor");
                    decSO_AmountWithVAT_LCY := "Amount Including VAT" * (1 / "Currency Factor");
                    decSO_VAT_LCY := ("Amount Including VAT" - Amount) / (1 / "Currency Factor");
                end else begin
                    decSO_Amount_LCY := Amount;
                    decSO_AmountWithVAT_LCY := "Amount Including VAT";
                    decSO_VAT_LCY := "Amount Including VAT" - Amount;
                end;
                decTotalSO_Amount_LCY += decSO_Amount_LCY;
                decTotalSO_AmountWithVAT_LCY += decSO_AmountWithVAT_LCY;
                decTotalSO_VAT_LCY += decSO_VAT_LCY;

                decAOAmt := 0;
                decAOAmtLCY := 0;
                AssemblyHeader.Reset();
                AssemblyHeader.SetRange("Sales Order No.", "No.");
                if AssemblyHeader.FindFirst() then
                    repeat
                        decAOAmt += AssemblyHeader."Cost Amount";
                        if "Currency Factor" <> 0 then
                            decAOAmtLCY += AssemblyHeader."Cost Amount" * (1 / "Currency Factor")
                        else
                            decAOAmtLCY += AssemblyHeader."Cost Amount";
                    until AssemblyHeader.Next() = 0;
            end;
        }
    }

    trigger OnPreReport()
    begin
        companyInfo.get();
        RecGLS.Get();

    end;

    var
        SN: Integer;
        PO_Currency: code[10];
        PO_Total_excl_of_vat: Decimal;
        From_PO_Vendor_Name: Text[30];
        No_field: Code[15];
        companyInfo: Record "Company Information";
        RecGLS: Record "General Ledger Setup";
        PurchaseHeader: Record "Purchase Header";
        decSO_Amount_LCY: Decimal;
        decSO_VAT_LCY: Decimal;
        decSO_AmountWithVAT_LCY: Decimal;
        decTotalSO_Amount_LCY: Decimal;
        decTotalSO_VAT_LCY: Decimal;
        decTotalSO_AmountWithVAT_LCY: Decimal;
        decPO_VAT_LCY: Decimal;
        decPO_Amount_LCY: Decimal;
        decPO_AmountWithVAT_LCY: Decimal;
        CurrencyCode: Code[20];
        AssemblyHeader: Record "Assembly Header";
        decAOAmt: Decimal;
        decAOAmtLCY: Decimal;
        AssemblyOrderLink: Record "Assemble-to-Order Link";
}