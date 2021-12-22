codeunit 50054 "Get Currency Exchange Rate"
{
    trigger OnRun()
    begin

    end;

    procedure GetExchangeRatePortal(CurrCode: Code[20]): Decimal
    var
        CurrExchangeRate: Record "Currency Exchange Rate";
    begin
        CurrExchangeRate.reset;
        CurrExchangeRate.SetRange("Currency Code", CurrCode);
        if CurrExchangeRate.FindLast() then
            exit(CurrExchangeRate."Exchange Rate Amount")
        else
            exit(0);
    end;

    var
        myInt: Integer;
}