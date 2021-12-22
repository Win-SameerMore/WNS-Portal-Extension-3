report 50013 "MAF Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layout/50013.MAFReport.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(Customer_Name; "Sell-to Customer Name") { }
            column(External_Document_No_; "External Document No.") { }
            column(Sales_Quote_No; "Quote No.") { }
            column(SO_No_; "No.") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Shipping_Agent_Service_Code; "Shipping Agent Service Code") { }
            column(Deliver_Term; "Shipment Method Code") { }
            column(Req_Delivery_Date; "Requested Delivery Date") { }
            column(Promised_Delivery_Date; "Promised Delivery Date") { }
            column(Comp_Currency_Code; "Currency Code") { }
            column(GeneralLCY; recGLE."LCY Code") { }
            column(Order_Date; "Order Date") { }
            column(RequestedBy; RequestedBy) { }
            column(ProjectName; "Sales header"."Project Name") { }
            column(MAF_Freight; "MAF Freight") { }
            column(MAF_Labour; "MAF Labour") { }
            column(MAF_Other_Cost; "MAF Other Cost") { }
            column(MAF_Other_Cost_Desc_; "MAF Other Cost Desc.") { }
            column(Total_Weight_KG_; "Total Weight(KG)") { }
            column(End_User; "End User") { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");
                column(Item_No; "No.") { }
                column(Item_Description; Description) { }
                column(Item_Quantity; Quantity) { }
                column(Item_Unit_Price; "Unit Price") { }
                column(Item_Total; "Line Amount") { }
                column(Sal_Line_No_; "Line No.")
                {

                }
                column(IntSrNoSal; IntSrNoSal)
                {

                }
                column(Unit_Cost_Price; "Unit Cost Price")
                {

                }
                column(Total_Cost_Price; "Total Cost Price")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    IntSrNoSal += 1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                recSalaHeader: Record "Sales Header";
            begin
                RequestedBy := UserId;
            end;
        }
        dataitem("Assembly Header"; "Assembly Header")
        {
            DataItemLinkReference = "Sales Header";
            DataItemLink = "Sales Order No." = field("No.");

            dataitem("Assembly Line"; "Assembly Line")
            {
                DataItemLinkReference = "assembly header";
                DataItemLink = "Document No." = field("No.");
                column(Assembly_Item_No_; "No.") { }
                column(Assembly_Item_Description; Description + '-' + "Document No.") { }
                column(Assembly_Item_Quantity; Quantity) { }
                column(Assm_Line_No_; "Line No.") { }
                column(IntSrNoAsm; IntSrNoAsm) { }
                column(Unit_Cost; "Unit Cost" / ExchangeRate) { }
                column(Cost_Amount; "Cost Amount" / ExchangeRate) { }
                column(Assembly_DocNo; "Document No.") { }

                trigger OnAfterGetRecord()
                begin
                    IntSrNoAsm += 1;
                    if "sales header"."Currency Code" <> '' then
                        ExchangeRate := 1 / "sales header"."Currency Factor"
                    else
                        ExchangeRate := 1;
                end;
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        recGLE.get();
        IntSrNoAsm := 0;
        IntSrNoSal := 0;
    end;

    var
        IntSrNoSal: Integer;
        IntSrNoAsm: Integer;
        AssemblyHeader: Record "Assembly Header";
        AssemblyLines: Record "Assembly Line";
        RequestedBy: Code[20];
        recGLE: Record "General Ledger Setup";
        ExchangeRate: Decimal;
}