tableextension 50063 "Price List Line Ext" extends "Price List Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Promotional Item"; Boolean)
        {
            Caption = 'Promotional Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                rItem: Record Item;
                CurrExchangeRate: Record "Currency Exchange Rate";
                TodayDate: Date;
                ExchangeRate: Decimal;
            begin
                if Rec."Promotional Item" then begin
                    if Rec."Asset Type" = Rec."Asset Type"::Item then
                        if rItem.get("Asset No.") then begin
                            CurrExchangeRate.GetLastestExchangeRate(Rec."Currency Code", TodayDate, ExchangeRate);
                            if ExchangeRate <> 0 then
                                "Original Price" := rItem."Unit Price" / ExchangeRate;
                        end;
                end else begin
                    "Original Price" := 0;
                end;
            end;
        }
        field(50001; "Original Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Original Price';
        }
        modify("Unit Price")
        {
            trigger OnAfterValidate()
            var
                rItem: Record Item;
            begin
                if Rec."Asset Type" = Rec."Asset Type"::Item then
                    if rItem.get("Asset No.") then begin
                        if ((Rec."Unit Price" * 100) / rItem."Unit Price") <= 70 then
                            if not Confirm('Unit Price is much lesser than Actual Price,\ Do you want to update this price?') then
                                Error('Price Not Updated.');
                    end;
            end;
        }
    }

    var
        myInt: Integer;
}