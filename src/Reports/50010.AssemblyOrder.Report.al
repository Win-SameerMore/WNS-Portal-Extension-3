report 50010 "Assembly Order SSE"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layout/50010.AssemblyOrder.rdl';
    Caption = 'Assembly Order SSE';

    dataset
    {
        dataitem("Assembly Header"; "Assembly Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.", "Item No.", "Due Date";

            column(Posting_Date; "Posting Date")
            {

            }
            column(Assembled_Quantity; "Assembled Quantity")
            {

            }
            column(CompName; CompanyInfo.Name)
            {

            }
            column(CompAdd; CompanyInfo.Address)
            {

            }
            column(CompAdd2; CompanyInfo."address 2")
            {

            }
            column(CompTel; CompanyInfo."Phone No.")
            {

            }
            column(CompFax; CompanyInfo."Fax No.")
            {

            }
            column(CompEmail; CompanyInfo."E-Mail")
            {

            }
            column(CompWebsite; CompanyInfo."Home Page")
            {

            }
            column(CompPicture; CompanyInfo.Picture)
            {

            }
            column(CompVATRegNo; CompanyInfo."VAT Registration No.")
            {

            }
            column(Sales_Order_No_; "Sales Order No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {

            }
            column(No_AssemblyHeader; "No.")
            {
            }
            column(ItemNo_AssemblyHeader; "Item No.")
            {
                IncludeCaption = true;
            }
            column(Description_AssemblyHeader; Description)
            {
                IncludeCaption = true;
            }
            column(Quantity_AssemblyHeader; Quantity)
            {
                IncludeCaption = true;
            }
            column(QuantityToAssemble_AssemblyHeader; "Quantity to Assemble")
            {
                IncludeCaption = true;
            }
            column(UnitOfMeasureCode_AssemblyHeader; "Unit of Measure Code")
            {
            }
            column(DueDate_AssemblyHeader; Format("Due Date"))
            {
            }
            column(StartingDate_AssemblyHeader; Format("Starting Date"))
            {
            }
            column(EndingDate_AssemblyHeader; Format("Ending Date"))
            {
            }
            column(LocationCode_AssemblyHeader; "Location Code")
            {
                IncludeCaption = true;
            }
            column(BinCode_AssemblyHeader; "Bin Code")
            {
                IncludeCaption = true;
            }
            column(SalesDocNo; SalesDocNo)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            dataitem("Assembly Line"; "Assembly Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(Type_AssemblyLine; Type)
                {
                    IncludeCaption = true;
                }
                column(No_AssemblyLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(Description_AssemblyLine; Description)
                {
                    IncludeCaption = true;
                }
                column(VariantCode_AssemblyLine; "Variant Code")
                {
                }
                column(DueDate_AssemblyLine; Format("Due Date"))
                {
                }
                column(QuantityPer_AssemblyLine; "Quantity per")
                {
                    IncludeCaption = true;
                }
                column(Quantity_AssemblyLine; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitOfMeasureCode_AssemblyLine; "Unit of Measure Code")
                {
                }
                column(LocationCode_AssemblyLine; "Location Code")
                {
                    IncludeCaption = true;
                }
                column(BinCode_AssemblyLine; "Bin Code")
                {
                    IncludeCaption = true;
                }
                column(QuantityToConsume_AssemblyLine; "Quantity to Consume")
                {
                    IncludeCaption = true;
                }
                column(LineSerialNo; LineSerialNo)
                {

                }
                trigger OnAfterGetRecord()
                var
                    rReservationEntry: Record "Reservation Entry";
                begin
                    LineSerialNo := '';
                    rReservationEntry.Reset();
                    rReservationEntry.SetRange("Source ID", "Assembly Line"."Document No.");
                    rReservationEntry.SetRange("Source Ref. No.", "Assembly Line"."Line No.");
                    if rReservationEntry.FindFirst() then
                        repeat
                            if LineSerialNo <> '' then begin
                                LineSerialNo += ',' + rReservationEntry."Serial No.";
                            end else begin
                                LineSerialNo := rReservationEntry."Serial No.";
                            end;
                        until rReservationEntry.Next = 0;
                end;
            }
            dataitem("FG RM Item Tracking Mapping"; "FG RM Item Tracking Mapping")
            {
                DataItemLinkReference = "Assembly Header";
                DataItemLink = "Source ID" = field("No.");
                column(FG_Item_No_; "FG Item No.")
                {

                }
                column(FG_Tracking_Code; "FG Tracking Code")
                {

                }
                column(RM_Item_No_; "RM Item No.")
                {

                }
                column(RM_Tracking_Code; "RM Tracking Code")
                {

                }
                column(Source_ID; "Source ID")
                {

                }
                column(Source_Line_No_; "Source Line No.")
                {

                }
                column(Source_Type; "Source Type")
                {

                }
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                CompanyInfo.get();
                CompanyInfo.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                ATOLink: Record "Assemble-to-Order Link";
            begin
                Clear(SalesDocNo);
                if ATOLink.Get("Document Type", "No.") then
                    SalesDocNo := ATOLink."Document No.";
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        AssemblyOrderHeading = 'Assembly Order';
        AssemblyItemHeading = 'Assembly Item';
        BillOfMaterialHeading = 'Bill of Material';
        PageCaption = 'Page';
        OfCaption = 'of';
        OrderNoCaption = 'Order No.';
        QuantityAssembledCaption = 'Quantity Assembled';
        QuantityPickedCaption = 'Quantity Picked';
        QuantityConsumedCaption = 'Quantity Consumed';
        AssembleToOrderNoCaption = 'Asm. to Order No.';
        UnitOfMeasureCaption = 'Unit of Measure';
        VariantCaption = 'Variant';
        DueDateCaption = 'Due Date';
        StartingDateCaption = 'Starting Date';
        EndingDateCaption = 'Ending Date';
    }

    var
        LineSerialNo: Text;
        IntCnt: Integer;
        ReservationEntry: Record "Reservation Entry";
        SerialNo1: Text;
        SerialNo2: Text;
        SerialNo3: Text;
        SerialNo4: Text;
        SerialNo5: Text;
        SerialNo6: Text;
        SerialNo7: Text;
        SerialNo8: Text;
        SerialNo9: Text;
        SerialNo10: Text;
        SerialNo11: Text;
        SerialNo12: Text;
        SalesDocNo: Code[20];
        CompanyInfo: Record "Company Information";
}