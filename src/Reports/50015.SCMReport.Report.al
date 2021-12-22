report 50015 "SCM Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reports\Layout\50015.SCM_Report_New.rdl';

    dataset
    {
        dataitem("Item Amount"; "Item Amount")
        {
            column(Sales_Order_No_; "Sales Order No.")
            {

            }
            column(Sales_Person; "Sales Person")
            {

            }
            column(Sales_Quote_No_; "Sales Quote No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(Project_Name; "Project Name")
            {

            }
            column(End_User_Name; "End User Name")
            {

            }
            column(Customer_PO_No_; "Customer PO No.")
            {

            }
            column(Customer_PO_Date; "Customer PO Date")
            {

            }
            column(Item_No_; "Item No.")
            {

            }
            column(Customer_Delivery_Date; "Customer Delivery Date")
            {

            }
            column(SSE_Date; "SSE Date")
            {

            }
            column(Customer_Shipping_Term; "Customer Shipping Term")
            {

            }
            column(Sales_Order_Qty; "Sales Order Qty")
            { }
            column(Shipped_Qty; "Shipped Qty")
            { }
            column(Invoiced_Qty; "Invoiced Qty")
            { }
            column(Supplier_Name; "Supplier Name")
            {

            }
            column(PO_No_; "PO No.")
            {

            }
            column(PO_Date; "PO Date")
            {

            }
            column(PO_Item_No_; "PO Item No.")
            {

            }
            column(PO_Line_Remarks; "PO Line Remarks")
            {

            }
            column(PO_Line_Order_Qty; "PO Line Order Qty")
            {

            }
            column(Order_Ack_No_; "Order Ack No.")
            {

            }
            column(Order_Ack_Date; "Order Ack Date")
            {

            }
            column(Supp__Org__Com__date_Ex_works_; "Supp. Org. Com. date(Ex-works)")
            {

            }
            column(Supp__Re_sch__Completion_date; "Supp. Re-sch. Completion date")
            {

            }
            column(SO_Status; "SO Status")
            {

            }
            column(PO_Status; "PO Status")
            { }
            column(VAS_Task; "VAS Task")
            {

            }
            column(VAS_Sub_Vendor_Name; "VAS Sub-Vendor Name")
            {

            }
            column(VAS_Time_Allocated; "VAS Time Allocated")
            {

            }
            column(AO_Item_No_; "AO Item No.")
            { }
            column(AO_Start_Date; format("AO Start Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            { }
            column(AO_End_Date; format("AO End Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            { }
            column(AO_Qty; "AO Qty")
            { }
            column(AO_Assembled_Qty; "AO Assembled Qty")
            { }
            column(AO_Remaining_Qty; "AO Remaining Qty")
            { }
            column(Freight_Estimated_Days; "Freight Estimated Days")
            { }
            column(Sales_Est_Freight_Cost; "Sales Est Freight Cost")
            { }
            column(Freight_Fwder_Name; "Freight Fwder Name")
            { }
            column(SO_Line_No_; "SO Line No.")
            { }
            column(AO_Line_No_; "AO Line No.")
            { }
            column(AO_Document_No_; "AO Document No.")
            { }
            column(PO_Line_No_; "PO Line No.")
            { }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Salesperson; filterSalesperson)
                    {
                        Caption = 'Salesperson Code';
                        ApplicationArea = All;
                        TableRelation = "Salesperson/Purchaser";
                    }
                    field(FilterOrderDate; FromOrderDate)
                    {
                        Caption = 'From Order Date';
                        ApplicationArea = All;
                    }
                    field(ToOrderDate; ToOrderDate)
                    {
                        Caption = 'To Order Date';
                        ApplicationArea = All;
                    }
                    field(FilterCustomerNo; FilterCustomerNo)
                    {
                        Caption = 'Sell-to Customer No.';
                        ApplicationArea = All;
                        TableRelation = Customer;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        GenerateItemAmount();
    end;

    trigger OnPostReport()
    var
        ItemAmount: Record "Item Amount";
    begin
        if ItemAmount.FindFirst() then
            ItemAmount.DeleteAll();
    end;

    local procedure GenerateItemAmount()
    var
        ItemAmount: Record "Item Amount";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        rItemAmount: Record "Item Amount";
    begin
        ItemAmount.Reset();
        ItemAmount.DeleteAll();
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if (FromOrderDate <> 0D) and (ToOrderDate <> 0D) then
            SalesHeader.SetRange("Order Date", FromOrderDate, ToOrderDate);
        if (FilterCustomerNo <> '') then
            SalesHeader.SetFilter("Sell-to Customer No.", FilterCustomerNo);
        if FilterSalesperson <> '' then
            SalesHeader.SetFilter("Salesperson Code", FilterSalesperson);
        if SalesHeader.FindFirst() then
            repeat
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange(Type, SalesLine.type::Item);
                if SalesLine.FindFirst() then
                    repeat
                        // ItemAmount.Reset();
                        // ItemAmount.SetRange("Sales Order No.", SalesLine."Document No.");
                        // ItemAmount.SetRange("Sales Order Line No.", SalesLine."Line No.");
                        rItemAmount.Reset();
                        if rItemAmount.FindLast() then;
                        ItemAmount.Init();
                        ItemAmount.Amount := rItemAmount.Amount + 1;
                        ItemAmount."Sales Order No." := SalesLine."Document No.";
                        ItemAmount."Sales Order Line No." := SalesLine."Line No.";
                        ItemAmount."Sales Person" := SalesHeader."Salesperson Code";
                        ItemAmount."Sales Quote No." := SalesHeader."Quote No.";
                        ItemAmount."Customer Name" := SalesHeader."Sell-to Customer Name";
                        ItemAmount."Project Name" := SalesHeader."Project Name";
                        itemamount."End User Name" := salesheader."End User";
                        ItemAmount."Customer PO No." := SalesHeader."External Document No.";
                        ItemAmount."Customer PO Date" := SalesHeader."External Document date";
                        ItemAmount."Item No." := salesline."No.";
                        ItemAmount."Customer Delivery Date" := SalesHeader."Requested Delivery Date";
                        ItemAmount."SSE Date" := SalesHeader."Date of Completion";
                        ItemAmount."Customer Shipping Term" := SalesHeader."Shipment Method Code";
                        ItemAmount."Sales Est Freight Cost" := SalesHeader."MAF Freight";
                        ItemAmount."Sales Order Qty" := SalesLine.Quantity;
                        ItemAmount."Shipped Qty" := SalesLine."Qty. Shipped (Base)";
                        ItemAmount."Invoiced Qty" := SalesLine."Qty. Invoiced (Base)";
                        ItemAmount.Insert(true);
                    until SalesLine.Next = 0;

                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Sales Order", salesheader."No.");
                if PurchaseHeader.FindFirst() then begin
                    repeat
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                        if PurchaseLine.FindFirst() then begin
                            repeat
                                rItemAmount.Reset();
                                rItemAmount.SetRange("Sales Order No.", SalesHeader."No.");
                                rItemAmount.SetRange("PO No.", '');
                                if rItemAmount.FindFirst() then begin
                                    ItemAmount."Supplier Name" := PurchaseHeader."Buy-from Vendor Name";
                                    ItemAmount."PO No." := PurchaseHeader."No.";
                                    ItemAmount."PO Date" := PurchaseHeader."Order Date";
                                    ItemAmount."Order Ack No." := PurchaseHeader."Vendor Shipment No.";
                                    ItemAmount."Order Ack Date" := PurchaseHeader."Vendor Shipment Date";
                                    ItemAmount."Supp. Org. Com. date(Ex-works)" := PurchaseHeader."Committed Delivery Date";
                                    ItemAmount."Supp. Re-sch. Completion date" := PurchaseHeader."Order Completion Date";
                                    ItemAmount."SO Status" := SalesHeader."Sales Order Status";
                                    ItemAmount."PO Status" := PurchaseHeader."PO Status";
                                    ItemAmount."PO Item No." := PurchaseLine."No.";
                                    ItemAmount."PO Line Remarks" := PurchaseLine."PO Line Remarks";
                                    ItemAmount."PO Line Order Qty" := PurchaseLine.Quantity;
                                    ItemAmount."Freight Estimated Days" := PurchaseHeader."Freight Estimated Days";
                                    ItemAmount."Freight Fwder Name" := PurchaseHeader."Shipping Agent Code";
                                    ItemAmount.Modify();
                                end else begin
                                    rItemAmount.Reset();
                                    rItemAmount.SetRange("Sales Order No.", SalesHeader."No.");
                                    rItemAmount.SetFilter("PO No.", '<>%1', '');
                                    if rItemAmount.FindLast() then begin
                                        ItemAmount.Init();
                                        ItemAmount.TransferFields(rItemAmount);
                                        ItemAmount.Amount := rItemAmount.Amount + 1;
                                        ItemAmount."Supplier Name" := PurchaseHeader."Buy-from Vendor Name";
                                        ItemAmount."PO No." := PurchaseHeader."No.";
                                        ItemAmount."PO Date" := PurchaseHeader."Order Date";
                                        ItemAmount."Order Ack No." := PurchaseHeader."Vendor Shipment No.";
                                        ItemAmount."Order Ack Date" := PurchaseHeader."Vendor Shipment Date";
                                        ItemAmount."Supp. Org. Com. date(Ex-works)" := PurchaseHeader."Committed Delivery Date";
                                        ItemAmount."Supp. Re-sch. Completion date" := PurchaseHeader."Order Completion Date";
                                        ItemAmount."SO Status" := SalesHeader."Sales Order Status";
                                        ItemAmount."PO Status" := PurchaseHeader."PO Status";
                                        ItemAmount."PO Item No." := PurchaseLine."No.";
                                        ItemAmount."PO Line Remarks" := PurchaseLine."PO Line Remarks";
                                        ItemAmount."PO Line Order Qty" := PurchaseLine.Quantity;
                                        ItemAmount."Freight Estimated Days" := PurchaseHeader."Freight Estimated Days";
                                        ItemAmount."Freight Fwder Name" := PurchaseHeader."Shipping Agent Code";
                                        ItemAmount.Insert(true);
                                    end;
                                end;
                            until PurchaseLine.Next() = 0;
                        end;
                    until purchaseheader.Next() = 0;
                end;
                AssemblyHeader.Reset();
                AssemblyHeader.SetRange("Sales Order No.", SalesHeader."No.");
                if AssemblyHeader.FindFirst() then begin
                    repeat
                        ItemAmount.Reset();
                        ItemAmount.SetRange("Sales Order No.", AssemblyHeader."Sales Order No.");
                        ItemAmount.SetFilter("VAS Task", '%1', '');
                        if ItemAmount.FindFirst() then begin
                            ItemAmount."VAS Task" := AssemblyHeader."No.";
                            ItemAmount."VAS Sub-Vendor Name" := 'New Field';
                            ItemAmount."VAS Time Allocated" := 'New Field';
                            ItemAmount."AO Item No." := AssemblyHeader."Item No.";
                            ItemAmount."AO Start Date" := AssemblyHeader."Starting Date";
                            ItemAmount."AO End Date" := AssemblyHeader."Ending Date";
                            ItemAmount."AO Qty" := AssemblyHeader.Quantity;
                            ItemAmount."AO Assembled Qty" := AssemblyHeader."Assembled Quantity";
                            ItemAmount."AO Remaining Qty" := AssemblyHeader."Remaining Quantity";
                            ItemAmount.Modify(True);
                        end else begin
                            rItemAmount.Reset();
                            rItemAmount.SetRange("Sales Order No.", AssemblyHeader."Sales Order No.");
                            rItemAmount.SetFilter("VAS Task", '<>%1', '');
                            if rItemAmount.FindLast() then begin
                                ItemAmount.Init();
                                ItemAmount.TransferFields(rItemAmount);
                                ItemAmount.Amount := rItemAmount.Amount + 1;
                                ItemAmount."VAS Task" := AssemblyHeader."No.";
                                ItemAmount."VAS Sub-Vendor Name" := 'New Field';
                                ItemAmount."VAS Time Allocated" := 'New Field';
                                ItemAmount."AO Item No." := AssemblyHeader."Item No.";
                                ItemAmount."AO Start Date" := AssemblyHeader."Starting Date";
                                ItemAmount."AO End Date" := AssemblyHeader."Ending Date";
                                ItemAmount."AO Qty" := AssemblyHeader.Quantity;
                                ItemAmount."AO Assembled Qty" := AssemblyHeader."Assembled Quantity";
                                ItemAmount."AO Remaining Qty" := AssemblyHeader."Remaining Quantity";
                                ItemAmount.Insert(true);
                            end;
                        end;
                    until AssemblyHeader.next = 0;
                end;
            until SalesHeader.Next = 0;
    end;

    var
        FilterSalesperson: Text;
        FromOrderDate: date;
        ToOrderDate: date;
        FilterCustomerNo: Text;
}