codeunit 50055 "Generate Item Prices"
{
    trigger OnRun()
    begin

    end;

    procedure GenerateItemPriceList()
    var
        rItem: Record Item;
        ItemPriceList: Record "Item With Price List";
        rCustomer: Record Customer;
        Currencies: Record Currency;
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";
        SalePrice: Record 7001 temporary;
        ItemUOM: Record "Item Unit of Measure";
        VATPostingSetup: Record "VAT Posting Setup";

    begin
        if not ItemPriceList.IsEmpty then
            ItemPriceList.DeleteAll();
        rItem.Reset();
        rItem.SetRange("Available on ECommerce", true);
        if rItem.Findset() then
            repeat
                //GetAttribute
                GetAttributeValueForItem(rItem);

                rCustomer.Reset();
                rCustomer.setrange("Portal Customer", true);
                if rCustomer.FindSet() then
                    repeat
                        Currencies.Reset();
                        Currencies.SetRange("Portal Currency", true);
                        if Currencies.FindSet() then
                            repeat
                                ItemPriceList.Init();
                                ItemPriceList."No." := rItem."No.";
                                ItemPriceList."Available on ECommerce" := rItem."Available on ECommerce";
                                ItemPriceList.Description := rItem.Description;
                                ItemPriceList."Gross Weight" := rItem."Gross Weight";
                                ItemPriceList."Item Category Code" := rItem."Item Category Code";
                                ItemPriceList."Minimum Order Quantity" := rItem."Minimum Order Quantity";
                                ItemPriceList."Net Weight" := rItem."Net Weight";
                                ItemPriceList."Global Dimension 2 Code" := rItem."Global Dimension 2 Code";
                                ItemPriceList."Order Multiple" := rItem."Order Multiple";
                                ItemPriceList."Price Includes VAT" := rItem."Price Includes VAT";
                                ItemPriceList."Purch. Unit of Measure" := rItem."Purch. Unit of Measure";
                                ItemPriceList."Routing No." := rItem."Routing No.";
                                ItemPriceList."Standard Cost" := rItem."Standard Cost";
                                ItemPriceList."Unit Volume" := rItem."Unit Volume";
                                ItemPriceList."Vendor No." := rItem."Vendor No.";
                                ItemPriceList."Vendor/Manufacturer item code" := rItem."Vendor/Manufacturer item code";
                                ItemPriceList."Quantity Available" := rItem."Quantity Available";
                                ItemPriceList."ETA Available Remarks" := rItem."ETA Available Remarks";
                                ItemPriceList."ETA Not Available Remarks" := rItem."ETA Not Available Remarks";
                                ItemPriceList."Base Unit of Measure" := rItem."Base Unit of Measure";
                                ItemPriceList."Manufucturing Item Code" := rItem."Manufucturing Item Code";
                                ItemPriceList.Blocked := rItem.Blocked;
                                ItemPriceList."Block Reason" := rItem."Block Reason";
                                ItemPriceList."Sales Unit of Measure" := rItem."Sales Unit of Measure";
                                ItemPriceList.Dimension := rItem.Dimension;
                                ItemPriceList."Customer No." := rCustomer."No.";
                                ItemPriceList."Portal Item Description" := rItem."Portal Item Description";
                                ItemPriceList."Search Description" := rItem."Search Description";
                                ItemPriceList."Search Item" := rItem."Search Item";

                                Clear(SalePrice);
                                ItemUOM.Reset();
                                ItemUOM.get(ritem."No.", rItem."Base Unit of Measure");
                                setitem(rItem."No.");
                                SetUoM(1, ItemUOM."Qty. per Unit of Measure");

                                VATPostingSetup.Reset();
                                VATPostingSetup.SetRange(VATPostingSetup."VAT Bus. Posting Group", rCustomer."VAT Bus. Posting Group");
                                VATPostingSetup.SetRange(VATPostingSetup."VAT Prod. Posting Group", ritem."VAT Prod. Posting Group");
                                if VATPostingSetup.FindFirst() then;

                                SetVAT(rItem."Price Includes VAT", VATPostingSetup."VAT %", VATPostingSetup."VAT Calculation Type".AsInteger(), rCustomer."VAT Bus. Posting Group");

                                FindSalesPrice(SalePrice, rcustomer."No.", '', rCustomer."Customer Price Group", '', rItem."No.", '', rItem."Sales Unit of Measure", Currencies.Code, Today, false);

                                CalcBestUnitPrice(SalePrice);

                                ItemPriceList."Currency Code" := Currencies.Code;
                                ItemPriceList."Unit Price" := SalePrice."Unit Price";
                                ItemPriceList."Promotional Item" := SalePrice."Promotional Item";
                                ItemPriceList."Original Price" := SalePrice."Original Price";
                                ItemPriceList."Minimum Qty." := 1;

                                //hereAssignAttributeValue
                                SetItemAttributeValOnItemPriceList(ItemPriceList);

                                ItemPriceList.Insert();
                            until Currencies.Next = 0;
                    until rCustomer.next = 0;
            until rItem.next = 0;
        InsertItemPriceListforMinQty();
    end;

    local procedure InsertItemPriceListforMinQty()
    var
        PriceListLine: Record "Price List Line";
        ItemPriceList: Record "Item With Price List";
        Customer: Record Customer;
        Currencies: Record Currency;
        rItem: Record item;
        GLSetup: Record "General Ledger Setup";
    begin
        PriceListLine.Reset();
        PriceListLine.SetFilter("Minimum Quantity", '<>%1', 0);
        PriceListLine.SetRange("Asset Type", PriceListLine."Asset Type"::Item);
        if PriceListLine.FindFirst() then
            repeat
                ritem.Reset();
                if rItem.Get(PriceListLine."Asset No.") then;
                GetAttributeValueForItem(rItem);

                Customer.Reset();
                Customer.SetRange("Portal Customer", true);
                if PriceListLine."Source Type" = PriceListLine."Source Type"::Customer then
                    Customer.SetRange("No.", PriceListLine."Source No.")
                else
                    if PriceListLine."Source Type" = PriceListLine."Source Type"::"Customer Price Group" then
                        Customer.SetRange("Customer Price Group", PriceListLine."Source No.");

                if customer.FindFirst() then
                    repeat
                        ItemPriceList.Init();
                        ItemPriceList."No." := rItem."No.";
                        ItemPriceList."Available on ECommerce" := rItem."Available on ECommerce";
                        ItemPriceList.Description := rItem.Description;
                        ItemPriceList."Gross Weight" := rItem."Gross Weight";
                        ItemPriceList."Item Category Code" := rItem."Item Category Code";
                        ItemPriceList."Minimum Order Quantity" := rItem."Minimum Order Quantity";
                        ItemPriceList."Net Weight" := rItem."Net Weight";
                        ItemPriceList."Global Dimension 2 Code" := rItem."Global Dimension 2 Code";
                        ItemPriceList."Order Multiple" := rItem."Order Multiple";
                        ItemPriceList."Price Includes VAT" := rItem."Price Includes VAT";
                        ItemPriceList."Purch. Unit of Measure" := rItem."Purch. Unit of Measure";
                        ItemPriceList."Routing No." := rItem."Routing No.";
                        ItemPriceList."Standard Cost" := rItem."Standard Cost";
                        ItemPriceList."Unit Volume" := rItem."Unit Volume";
                        ItemPriceList."Vendor No." := rItem."Vendor No.";
                        ItemPriceList."Vendor/Manufacturer item code" := rItem."Vendor/Manufacturer item code";
                        ItemPriceList."Quantity Available" := rItem."Quantity Available";
                        ItemPriceList."ETA Available Remarks" := rItem."ETA Available Remarks";
                        ItemPriceList."ETA Not Available Remarks" := rItem."ETA Not Available Remarks";
                        ItemPriceList."Base Unit of Measure" := rItem."Base Unit of Measure";
                        ItemPriceList."Manufucturing Item Code" := rItem."Manufucturing Item Code";
                        ItemPriceList.Blocked := rItem.Blocked;
                        ItemPriceList."Block Reason" := rItem."Block Reason";
                        ItemPriceList."Sales Unit of Measure" := rItem."Sales Unit of Measure";
                        ItemPriceList.Dimension := rItem.Dimension;
                        ItemPriceList."Customer No." := Customer."No.";
                        ItemPriceList."Portal Item Description" := rItem."Portal Item Description";
                        ItemPriceList."Search Description" := rItem."Search Description";
                        ItemPriceList."Search Item" := rItem."Search Item";

                        GLSetup.get();
                        if PriceListLine."Currency Code" <> '' then
                            ItemPriceList."Currency Code" := PriceListLine."Currency Code"
                        else
                            ItemPriceList."Currency Code" := GLSetup."LCY Code";
                        ItemPriceList."Unit Price" := PriceListLine."Unit Price";
                        ItemPriceList."Promotional Item" := PriceListLine."Promotional Item";
                        ItemPriceList."Original Price" := PriceListLine."Original Price";
                        ItemPriceList."Minimum Qty." := PriceListLine."Minimum Quantity";

                        //hereAssignAttributeValue
                        SetItemAttributeValOnItemPriceList(ItemPriceList);

                        ItemPriceList.Insert();

                    until Customer.Next = 0;
            until PriceListLine.Next = 0;
    end;

    local procedure GetAttributeValueForItem(Item: Record Item)
    var
        ItemAttribute: Record "Item Attribute";
        ItemAttribiuteVal: Record "Item Attribute Value";
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        txtAttributeCaption: text;
    begin
        Clear(txtAttribute);
        ItemAttributeValueMapping.Reset();
        ItemAttributeValueMapping.SetRange("Table ID", 27);
        ItemAttributeValueMapping.SetRange("No.", item."No.");
        if ItemAttributeValueMapping.FindFirst() then
            repeat
                ItemAttribute.Reset();
                if ItemAttribute.Get(ItemAttributeValueMapping."Item Attribute ID") then;

                ItemAttribiuteVal.Reset();
                if ItemAttribiuteVal.get(ItemAttribute.ID, ItemAttributeValueMapping."Item Attribute Value ID") then;

                // txtAttributeCaption := ItemAttribute.FieldCaption(Name);

                txtAttribute[ItemAttribute.ID] := ItemAttribiuteVal.Value;
            until ItemAttributeValueMapping.Next = 0;
    end;

    local procedure SetItemAttributeValOnItemPriceList(var ItemPriceList: Record "Item With Price List")
    begin
        ItemPriceList.Colour := txtAttribute[1];
        ItemPriceList.Depth := txtAttribute[2];
        ItemPriceList.Width := txtAttribute[3];
        ItemPriceList.Height := txtAttribute[4];
        ItemPriceList."Material Description" := txtAttribute[5];
        ItemPriceList."Model Year" := txtAttribute[6];
        ItemPriceList."Supply Voltage" := txtAttribute[7];
        ItemPriceList."BODY COLOUR" := txtAttribute[8];
        ItemPriceList."BASE COLOUR" := txtAttribute[9];
        ItemPriceList."Lens Colour" := txtAttribute[10];
        ItemPriceList.CERTIFICATION := txtAttribute[11];
        ItemPriceList."Operating Environment" := txtAttribute[12];
        ItemPriceList.BULBS := txtAttribute[13];
        ItemPriceList.PRODUCTS := txtAttribute[14];
        ItemPriceList.Brands := txtAttribute[15];
        ItemPriceList.Series := txtAttribute[16];
        ItemPriceList.Current := txtAttribute[17];
        ItemPriceList."Sound Output" := txtAttribute[18];
        ItemPriceList."Number of Tones" := txtAttribute[19];
        ItemPriceList."Alarm Stages" := txtAttribute[20];
        ItemPriceList."Volume Control" := txtAttribute[21];
        ItemPriceList."IP/NEMA Rating" := txtAttribute[22];
        ItemPriceList."Housing Materials" := txtAttribute[23];
        ItemPriceList."Housing Colour" := txtAttribute[24];
        ItemPriceList."Mounting Style" := txtAttribute[25];
        ItemPriceList."Base Diameter / Dimensions" := txtAttribute[26];
        ItemPriceList."Base Type" := txtAttribute[27];
        ItemPriceList."Comp. Sounder/Beacons for Base" := txtAttribute[28];
        ItemPriceList."Minimum Temperature" := txtAttribute[29];
        ItemPriceList."Maximum Temperature" := txtAttribute[30];
        ItemPriceList."Certification Standards" := txtAttribute[31];
        ItemPriceList."Hazardous Certification" := txtAttribute[32];
        ItemPriceList."Flash Colour" := txtAttribute[34];
        ItemPriceList."Flash Rate" := txtAttribute[35];
        ItemPriceList."Flash Power" := txtAttribute[36];
        ItemPriceList."Bulb Type" := txtAttribute[37];
        ItemPriceList."Light Output" := txtAttribute[38];
    end;

    procedure FindSalesPrice(var ToSalesPrice: Record 7001; CustNo: Code[20]; ContNo: Code[20]; CustPriceGrCode: Code[10]; CampaignNo: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; UOM: Code[10]; CurrencyCode: Code[10]; StartingDate: Date; ShowAll: Boolean)
    var
        FromSalesPrice: Record 7001;
        TempTargetCampaignGr: Record "Campaign Target Group" temporary;
    begin
        if not ToSalesPrice.IsTemporary then
            Error(TempTableErr);

        ToSalesPrice.Reset();
        ToSalesPrice.DeleteAll();


        with FromSalesPrice do begin
            SetRange("Asset No.", ItemNo);
            SetFilter("Variant Code", '%1|%2', VariantCode, '');
            SetFilter("Ending Date", '%1|>=%2', 0D, StartingDate);
            if not ShowAll then begin
                SetFilter("Currency Code", '%1|%2', CurrencyCode, '');
                if UOM <> '' then
                    SetFilter("Unit of Measure Code", '%1|%2', UOM, '');
                SetRange("Starting Date", 0D, StartingDate);
            end;

            SetRange("source type", "Source Type"::"All Customers");
            SetRange("Source No.");
            CopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice);

            if CustNo <> '' then begin
                SetRange("source type", "Source Type"::Customer);
                SetRange("Source No.", CustNo);
                CopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice);
            end;

            if CustPriceGrCode <> '' then begin
                SetRange("source type", "Source Type"::"Customer Price Group");
                SetRange("Source No.", CustPriceGrCode);
                CopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice);
            end;

            if not ((CustNo = '') and (ContNo = '') and (CampaignNo = '')) then begin
                SetRange("source type", "Source Type"::Campaign);
                if ActivatedCampaignExists(TempTargetCampaignGr, CustNo, ContNo, CampaignNo) then
                    repeat
                        SetRange("Source No.", TempTargetCampaignGr."Campaign No.");
                        CopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice);
                    until TempTargetCampaignGr.Next() = 0;
            end;
        end;
    end;

    local procedure CopySalesPriceToSalesPrice(var FromSalesPrice: Record 7001; var ToSalesPrice: Record 7001)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //OnBeforeCopySalesPriceToSalesPrice(FromSalesPrice, ToSalesPrice, IsHandled);
        if IsHandled then
            exit;

        with ToSalesPrice do
            if FromSalesPrice.FindSet then
                repeat
                    ToSalesPrice := FromSalesPrice;
                    Insert;
                until FromSalesPrice.Next() = 0;
    end;

    procedure ActivatedCampaignExists(var ToCampaignTargetGr: Record "Campaign Target Group"; CustNo: Code[20]; ContNo: Code[20]; CampaignNo: Code[20]): Boolean
    var
        FromCampaignTargetGr: Record "Campaign Target Group";
        Cont: Record Contact;
        IsHandled: Boolean;
    begin
        if not ToCampaignTargetGr.IsTemporary then
            Error(TempTableErr);

        IsHandled := false;
        //OnBeforeActivatedCampaignExists(ToCampaignTargetGr, CustNo, ContNo, CampaignNo, IsHandled);
        IF IsHandled then
            exit;

        with FromCampaignTargetGr do begin
            ToCampaignTargetGr.Reset();
            ToCampaignTargetGr.DeleteAll();

            if CampaignNo <> '' then begin
                ToCampaignTargetGr."Campaign No." := CampaignNo;
                ToCampaignTargetGr.Insert();
            end else begin
                SetRange(Type, Type::Customer);
                SetRange("No.", CustNo);
                if FindSet then
                    repeat
                        ToCampaignTargetGr := FromCampaignTargetGr;
                        ToCampaignTargetGr.Insert();
                    until Next() = 0
                else
                    if Cont.Get(ContNo) then begin
                        SetRange(Type, Type::Contact);
                        SetRange("No.", Cont."Company No.");
                        if FindSet then
                            repeat
                                ToCampaignTargetGr := FromCampaignTargetGr;
                                ToCampaignTargetGr.Insert();
                            until Next() = 0;
                    end;
            end;
            exit(ToCampaignTargetGr.FindFirst);
        end;
    end;

    procedure CalcBestUnitPrice(var SalesPrice: Record 7001)
    var
        BestSalesPrice: Record 7001;
        BestSalesPriceFound: Boolean;
        IsHandled: Boolean;
    begin
        //OnBeforeCalcBestUnitPrice(SalesPrice, IsHandled);
        if IsHandled then
            exit;

        with SalesPrice do begin
            FoundSalesPrice := FindSet();
            if FoundSalesPrice then
                repeat
                    if IsInMinQty("Unit of Measure Code", "Minimum Quantity") then begin
                        CalcBestUnitPriceConvertPrice(SalesPrice);

                        case true of
                            ((BestSalesPrice."Currency Code" = '') and ("Currency Code" <> '')) or
                            ((BestSalesPrice."Variant Code" = '') and ("Variant Code" <> '')):
                                begin
                                    BestSalesPrice := SalesPrice;
                                    BestSalesPriceFound := true;
                                end;
                            ((BestSalesPrice."Currency Code" = '') or ("Currency Code" <> '')) and
                          ((BestSalesPrice."Variant Code" = '') or ("Variant Code" <> '')):
                                if (BestSalesPrice."Unit Price" = 0) or
                                   (CalcLineAmount(BestSalesPrice) > CalcLineAmount(SalesPrice))
                                then begin
                                    BestSalesPrice := SalesPrice;
                                    BestSalesPriceFound := true;
                                end;
                        end;
                    end;
                until Next() = 0;
        end;
        // OnAfterCalcBestUnitPrice(SalesPrice, BestSalesPrice);

        // No price found in agreement
        if not BestSalesPriceFound then begin
            //WIN504_260821>> 
            // ConvertPriceToVAT(
            //   Item."Price Includes VAT", Item."VAT Prod. Posting Group",
            //   Item."VAT Bus. Posting Gr. (Price)", Item."Unit Price");
            // ConvertPriceToUoM('', Item."Unit Price");
            // ConvertPriceLCYToFCY(CurrencyCode, Item."Unit Price");

            // Clear(BestSalesPrice);
            // BestSalesPrice."Unit Price" := Item."Unit Price";
            // BestSalesPrice."Allow Line Disc." := AllowLineDisc;
            // BestSalesPrice."Allow Invoice Disc." := AllowInvDisc;
            //WIN504_260821<<
            //          OnAfterCalcBestUnitPriceAsItemUnitPrice(BestSalesPrice, Item);
        end;

        SalesPrice := BestSalesPrice;
    end;

    local procedure CalcBestUnitPriceConvertPrice(var SalesPrice: Record 7001)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        //        OnBeforeCalcBestUnitPriceConvertPrice(SalesPrice, IsHandled);
        if IsHandled then
            exit;

        with SalesPrice do begin
            ConvertPriceToVAT(
                "Price Includes VAT", Item."VAT Prod. Posting Group",
                "VAT Bus. Posting Gr. (Price)", "Unit Price");
            ConvertPriceToUoM("Unit of Measure Code", "Unit Price");
            ConvertPriceLCYToFCY("Currency Code", "Unit Price");
        end;
    end;

    procedure ConvertPriceToVAT(FromPricesInclVAT: Boolean; FromVATProdPostingGr: Code[20]; FromVATBusPostingGr: Code[20]; var UnitPrice: Decimal)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        IsHandled: Boolean;
    begin
        if FromPricesInclVAT then begin
            VATPostingSetup.Get(FromVATBusPostingGr, FromVATProdPostingGr);
            IsHandled := false;
            //OnBeforeConvertPriceToVAT(VATPostingSetup, UnitPrice, IsHandled);
            if IsHandled then
                exit;

            case VATPostingSetup."VAT Calculation Type" of
                VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT":
                    VATPostingSetup."VAT %" := 0;
                VATPostingSetup."VAT Calculation Type"::"Sales Tax":
                    Error(
                      Text010,
                      VATPostingSetup.FieldCaption("VAT Calculation Type"),
                      VATPostingSetup."VAT Calculation Type");
            end;

            case VATCalcType of
                VATCalcType::"Normal VAT",
                VATCalcType::"Full VAT",
                VATCalcType::"Sales Tax":
                    begin
                        if PricesInclVAT then begin
                            if VATBusPostingGr <> FromVATBusPostingGr then
                                UnitPrice := UnitPrice * (100 + VATPerCent) / (100 + VATPostingSetup."VAT %");
                        end else
                            UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
                    end;
                VATCalcType::"Reverse Charge VAT":
                    UnitPrice := UnitPrice / (1 + VATPostingSetup."VAT %" / 100);
            end;
        end else
            if PricesInclVAT then
                UnitPrice := UnitPrice * (1 + VATPerCent / 100);
    end;

    local procedure ConvertPriceToUoM(UnitOfMeasureCode: Code[10]; var UnitPrice: Decimal)
    begin
        if UnitOfMeasureCode = '' then
            UnitPrice := UnitPrice * QtyPerUOM;
    end;

    procedure ConvertPriceLCYToFCY(CurrencyCode: Code[10]; var UnitPrice: Decimal)
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if PricesInCurrency then begin
            if CurrencyCode = '' then
                UnitPrice :=
                  CurrExchRate.ExchangeAmtLCYToFCY(ExchRateDate, Currency.Code, UnitPrice, CurrencyFactor);
            UnitPrice := Round(UnitPrice, Currency."Unit-Amount Rounding Precision");
        end else
            UnitPrice := Round(UnitPrice, GLSetup."Unit-Amount Rounding Precision");
    end;

    local procedure CalcLineAmount(SalesPrice: Record 7001) LineAmount: Decimal
    begin
        with SalesPrice do
            if "Allow Line Disc." then
                LineAmount := "Unit Price" * (1 - LineDiscPerCent / 100)
            else
                LineAmount := "Unit Price";
        //OnAfterCalcLineAmount(SalesPrice, LineAmount);
    end;

    local procedure IsInMinQty(UnitofMeasureCode: Code[10]; MinQty: Decimal): Boolean
    begin
        if UnitofMeasureCode = '' then
            exit(MinQty <= QtyPerUOM * Qty);
        exit(MinQty <= Qty);
    end;

    procedure SetItem(ItemNo: Code[20])
    begin
        Item.Get(ItemNo);
    end;

    procedure SetVAT(PriceInclVAT2: Boolean; VATPerCent2: Decimal; VATCalcType2: Option; VATBusPostingGr2: Code[20])
    begin
        PricesInclVAT := PriceInclVAT2;
        VATPerCent := VATPerCent2;
        VATCalcType := VATCalcType2;
        VATBusPostingGr := VATBusPostingGr2;
    end;

    procedure SetUoM(Qty2: Decimal; QtyPerUoM2: Decimal)
    begin
        Qty := Qty2;
        QtyPerUOM := QtyPerUoM2;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Item: Record Item;
        Currency: Record Currency;
        Text010: Label 'Prices including VAT cannot be calculated when %1 is %2.';
        LineDiscPerCent: Decimal;
        Qty: Decimal;
        VATPerCent: Decimal;
        PricesInclVAT: Boolean;
        VATCalcType: Option "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        VATBusPostingGr: Code[20];
        QtyPerUOM: Decimal;
        PricesInCurrency: Boolean;
        CurrencyFactor: Decimal;
        ExchRateDate: Date;
        FoundSalesPrice: Boolean;
        TempTableErr: Label 'The table passed as a parameter must be temporary.';
        AllowLineDisc: Boolean;
        AllowInvDisc: Boolean;

        txtAttribute: array[100] of Text;
}




