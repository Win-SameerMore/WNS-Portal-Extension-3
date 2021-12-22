report 50016 "CFR Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Reports\Layout\50016.CFR_Report.rdl';

    dataset
    {
        /*
              dataitem(Customer; Customer)
              {
                  DataItemTableView = where(blocked = filter(false));
                  column(CustName; Name)
                  {

                  }
                  column(decArAmt; decArAmt)
                  {

                  }
                  column(decSOAmt; decSOAmt)
                  {

                  }
                  trigger OnAfterGetRecord()
                  begin
                      decArAmt := 0;
                      decSOAmt := 0;
                      rCLE.Reset();
                      rCLE.SetRange("Customer No.", Customer."No.");
                      rCLE.setrange("Currency Code", rBankAccount."Currency Code");
                      rCLE.SetRange("Due Date", FromDate, ToDate);
                      rCLE.SetRange(Open, true);
                      if rCLE.FindFirst() then
                          repeat
                              rCLE.CalcFields("Remaining Amount");
                              decArAmt += rCLE."Remaining Amount";
                          until rCLE.next = 0;

                      rSalesHeader.Reset();
                      rSalesHeader.SetRange("Sell-to Customer No.", Customer."No.");
                      rSalesHeader.SetRange("CashFlow SO Due Date", FromDate, ToDate);
                      rSalesHeader.SetRange("Currency Code", rBankAccount."Currency Code");
                      if rSalesHeader.FindFirst() then
                          repeat
                              rSalesLine.Reset();
                              rSalesLine.SetRange("Document No.", rSalesHeader."No.");
                              if rSalesLine.FindFirst() then
                                  repeat
                                      decSOAmt += rSalesLine."Outstanding Amount";
                                  until rSalesLine.next = 0;
                          until rSalesHeader.next = 0;
                  end;
              }
              dataitem(Vendor; Vendor)
              {
                  DataItemTableView = where(blocked = filter(false));
                  column(VendName; Name)
                  {

                  }
                  column(decApAmt; decApAmt)
                  {

                  }
                  column(decPoAmt; decPoAmt)
                  {

                  }
                  trigger OnAfterGetRecord()
                  begin
                      decApAmt := 0;
                      decPoAmt := 0;
                      rVLE.Reset();
                      rVLE.SetRange(Open, true);
                      rVLE.SetRange("Vendor No.", Vendor."No.");
                      rVLE.SetRange("Due Date", FromDate, ToDate);
                      if rVLE.FindFirst() then
                          repeat
                              rVLE.CalcFields("Remaining Amount");
                              decApAmt += rVLE."Remaining Amount";
                          until rVLE.Next = 0;

                      rPurchaseHeader.Reset();
                      rPurchaseHeader.SetRange("Document Type", rPurchaseHeader."Document Type"::Order);
                      rPurchaseHeader.SetRange("Buy-from Vendor No.", vendor."No.");
                      rPurchaseHeader.SetRange("Cashflow PO Due Date", FromDate, todate);
                      rPurchaseHeader.SetRange("Currency Code", rBankAccount."Currency Code");
                      if rPurchaseHeader.FindFirst() then
                          repeat
                              rPurchaseLine.Reset();
                              rPurchaseLine.SetRange("Document Type", rPurchaseLine."Document Type"::Order);
                              rPurchaseLine.SetRange("Document No.", rPurchaseHeader."No.");
                              if rPurchaseLine.FindFirst() then
                                  repeat
                                      decPoAmt += rPurchaseLine."Outstanding Amount";
                                  until rPurchaseLine.next = 0;
                          until rPurchaseHeader.Next = 0;
                  end;
              }
      */
        dataitem(Integer; Integer)
        {
            column(DateColumns; DateColumns)
            {

            }
            column(BankAccountName; rBankAccount.Name)
            {

            }
            column(BankAccountNo; rBankAccount."Bank Account No.")
            {

            }
            column(FilterMonthYear; format(filterMonth) + '-' + Format(FilterYear))
            {

            }
            column(BankBal; BankBal)
            {

            }
            column(Currency; rbankaccount."Currency Code")
            {

            }
            column(blnBGColor; blnBGColor)
            {

            }
            column(decOpeningBal; decOpeningBal)
            {

            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemTableView = where(open = filter(true));
                column(CustName; "customer name" + '(' + rCustomer."Payment Terms Code" + ')')
                {

                }
                column(decArAmt; decArAmt)
                {

                }
                trigger OnPreDataItem()
                begin
                    "Cust. Ledger Entry".SetRange("Due Date", FromDate, ToDate);
                    "Cust. Ledger Entry".SetRange("Currency Code", rBankAccount."Currency Code");
                end;

                trigger OnAfterGetRecord()
                begin
                    decArAmt := 0;
                    decSOAmt := 0;
                    "Cust. Ledger Entry".CalcFields("Remaining Amount");
                    decArAmt := "Cust. Ledger Entry"."Remaining Amount";

                    rCustomer.Reset();
                    if rCustomer.get("Cust. Ledger Entry"."Customer No.") then;

                    xdecArAmt += decArAmt;
                end;
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemTableView = where("document type" = filter(order));
                column(SoCustName; "sales header"."Sell-to Customer Name" + '(' + rCustomer."Payment Terms Code" + ')')
                {

                }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLinkReference = "sales Header";
                    DataItemLink = "document no." = Field("no.");
                    column(decSOAmt; decSOAmt)
                    {

                    }

                    trigger OnAfterGetRecord()
                    begin
                        decSOAmt += "Sales Line"."Outstanding Amount" - "Sales Line"."Prepayment Amount";
                        xdecSOAmt += decSOAmt;
                    end;
                }
                trigger OnPreDataItem()
                begin
                    "Sales Header".SetRange("CashFlow SO Due Date", FromDate, ToDate);
                    "Sales Header".SetRange("Currency Code", rBankAccount."Currency Code");
                end;

                trigger OnAfterGetRecord()
                begin
                    rCustomer.Reset();
                    if rCustomer.get("Sell-to Customer No.") then;
                end;
            }
            dataitem("Cash Flow Manual Revenue"; "Cash Flow Manual Revenue")
            {
                column(Rev_Code; "Cash Flow Manual Revenue".Code)
                {

                }
                column(RevenueDescription; Description)
                {

                }
                column(RevenueAmount; Amount)
                {

                }
                trigger OnPreDataItem()
                begin
                    // "Cash Flow Manual Revenue".SetRange("Starting Date", FromDate, ToDate);
                end;

                trigger OnAfterGetRecord()
                var
                    ReccurDateformula: DateFormula;
                begin
                    if rBankAccount."Currency Code" <> '' then
                        CurrReport.Skip();

                    if "Cash Flow Manual Revenue"."Starting Date" > ToDate then
                        CurrReport.Skip();
                    Evaluate(ReccurDateformula, '1M');
                    if not ("Cash Flow Manual Revenue"."Recurring Frequency" = ReccurDateformula) then begin
                        if StrPos(xRevDes, "Cash Flow Manual Revenue".Description) <> 0 then
                            CurrReport.Skip();
                    end else begin
                        if "Cash Flow Manual Revenue"."Ending Date" <> 0D then
                            if "Cash Flow Manual Revenue"."Ending Date" < ToDate then
                                CurrReport.Skip();
                    end;
                    if not ("Cash Flow Manual Revenue"."Recurring Frequency" = ReccurDateformula) then
                        xRevDes += "Cash Flow Manual Revenue".Description;

                    xdecRevAmt += "Cash Flow Manual Revenue".Amount;
                end;
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemTableView = where("document type" = filter(Payment), "Credit amount" = filter(0));
                column(BALE_Entry_No; "Entry No.")
                {

                }
                column(BALE_Description; Description)
                {

                }
                column(Debit_Amount; "Debit Amount")
                {

                }
                trigger OnPreDataItem()
                begin
                    SetRange("Bank Account No.", rBankAccount."No.");
                    SetRange("Posting Date", FromDate, ToDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    xdecBALEDAmt += "Debit Amount";
                end;
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemTableView = where(open = filter(true));
                column(VendName; "Vendor name" + '(' + rVendor."Payment Terms Code" + ')')
                {

                }
                column(decApAmt; decApAmt)
                {

                }
                trigger OnPreDataItem()
                begin
                    "Vendor Ledger Entry".SetRange("Due Date", FromDate, ToDate);
                    "Vendor Ledger Entry".SetRange("Currency Code", rBankAccount."Currency Code");
                end;

                trigger OnAfterGetRecord()
                begin
                    decApAmt := 0;
                    decPoAmt := 0;
                    "Vendor Ledger Entry".CalcFields("Remaining Amount");
                    decApAmt := "Vendor Ledger Entry"."Remaining Amount";

                    rVendor.Reset();
                    if rVendor.get("Vendor Ledger Entry"."Vendor No.") then;
                    xdecApAmt += decApAmt;
                end;
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemTableView = where("document type" = filter(order));
                column(PoVendName; "Purchase header"."Buy-from Vendor Name" + '(' + rVendor."Payment Terms Code" + ')')
                {

                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    DataItemLinkReference = "Purchase Header";
                    DataItemLink = "document no." = Field("no.");
                    DataItemTableView = where(type = filter(<> ''));
                    column(decPoAmt; decpOAmt)
                    {

                    }
                    trigger OnAfterGetRecord()
                    begin
                        decpOAmt += "Purchase Line"."Outstanding Amount";

                        xdecPoAmt += decPoAmt;
                    end;
                }
                trigger OnPreDataItem()
                begin
                    "Purchase Header".SetRange("Cashflow PO Due Date", FromDate, ToDate);
                    "Purchase Header".SetRange("Currency Code", rBankAccount."Currency Code");
                end;

                trigger OnAfterGetRecord()
                begin
                    rVendor.Reset();
                    if rVendor.get("Purchase Header"."Buy-from Vendor No.") then;
                end;
            }
            dataitem("Cash Flow Manual Expense"; "Cash Flow Manual Expense")
            {
                column(Exp_Code; "Cash Flow Manual Expense".Code)
                {

                }
                column(ExpenseDescription; Description)
                {

                }
                column(ExpenseAmount; Amount)
                {

                }
                trigger OnPreDataItem()
                begin
                    //"Cash Flow Manual Expense".SetFilter("Starting Date", '%1..', FromDate);

                end;

                trigger OnAfterGetRecord()
                var
                    ReccurDateformula: DateFormula;
                begin
                    if rBankAccount."Currency Code" <> '' then
                        CurrReport.Skip();

                    if "Cash Flow Manual Expense"."Starting Date" > ToDate then
                        CurrReport.Skip();
                    Evaluate(ReccurDateformula, '1M');
                    if not ("Cash Flow Manual Expense"."Recurring Frequency" = ReccurDateformula) then begin
                        if StrPos(xExpDes, "Cash Flow Manual Expense".Description) <> 0 then
                            CurrReport.Skip();
                    end else begin
                        if "Cash Flow Manual Expense"."Ending Date" <> 0D then
                            if "Cash Flow Manual Expense"."Ending Date" < ToDate then
                                CurrReport.Skip();
                    end;
                    if not ("Cash Flow Manual Expense"."Recurring Frequency" = ReccurDateformula) then
                        xExpDes += "Cash Flow Manual Expense".Description;

                    xdecExpAmt += Amount;
                end;
            }
            dataitem("Bank Account Ledger Entry Exp"; "Bank Account Ledger Entry")
            {
                DataItemTableView = where("document type" = filter(Payment), "debit amount" = filter(0));
                column(BALE_Entry_No_EXP; "Entry No.")
                {

                }
                column(BALE_Description_Exp; Description)
                {

                }
                column(Credit_Amount; "Credit Amount")
                {

                }
                trigger OnPreDataItem()
                begin
                    SetRange("Bank Account No.", rBankAccount."No.");
                    SetRange("Posting Date", FromDate, ToDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    xdecBALECAmt += "Credit Amount";
                end;
            }
            trigger OnPreDataItem()
            begin
                NoofDays := Date2DMY(CalcDate('CM', DMY2Date(1, filterMonth, FilterYear)), 1);
                loop := round(NoofDays / 7, 1, '>');
                Integer.SetRange(Number, 1, loop + FilterPeriods);
                FilterStartDay := 0;
                FilterEndDay := 0;


            end;

            trigger OnAfterGetRecord()
            begin
                blnBGColor := false;

                if FilterEndDay <> NoofDays then begin
                    blnBGColor := false;
                    FilterStartDay := FilterEndDay + 1;
                    if FilterEndDay + 7 > NoofDays then
                        FilterEndDay := NoofDays
                    else
                        FilterEndDay += 7;
                    FromDate := DMY2Date(FilterStartDay, filterMonth, FilterYear);
                    ToDate := DMY2Date(FilterEndDay, filterMonth, FilterYear);
                    DateColumns := format(FilterStartDay) + '-' + format(FilterEndDay) + ' ' + format(filterMonth) + '''' + Format(FilterYear);
                    //DateColumns := format(FromDate) + '..' + Format(ToDate);  

                end else begin
                    blnBGColor := true;
                    FilterStartDay := 1;
                    if filterMonth = 12 then begin
                        filterMonth := 1;
                        FilterYear := FilterYear + 1;
                    end else begin
                        filterMonth := filterMonth + 1;
                    end;

                    FromDate := DMY2Date(FilterStartDay, filterMonth, FilterYear);
                    ToDate := CALCDATE('CM', FromDate);

                    DateColumns := format(filterMonth) + '-' + format(FilterYear);
                end;
                //Message('%1..%2..%3', DateColumns, FromDate, ToDate);
                intcnt += 1;
                if intcnt = 1 then begin
                    recBankAcc.Reset();
                    recBankAcc.SetRange("No.", filterBankAccNo);
                    recBankAcc.SetRange("Date Filter", 0D, FromDate - 1);
                    if recBankAcc.FindFirst() then begin
                        recBankAcc.CalcFields("Balance at Date");
                        decOpeningBal := recBankAcc."Balance at Date";
                    end;
                end else begin
                    decOpeningBal := (xdecArAmt + xdecSOAmt + xdecRevAmt + xdecBALEDAmt) - (xdecApAmt + xdecPoAmt + xdecExpAmt + xdecBALECAmt);
                end;
                xdecArAmt := 0;
                xdecSOAmt := 0;
                xdecRevAmt := 0;
                xdecBALEDAmt := 0;
                xdecApAmt := 0;
                xdecPoAmt := 0;
                xdecExpAmt := 0;
                xdecBALECAmt := 0;

                intCountRev += 1;
                intCountExp := 0;
            end;
        }

    }


    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(filterMonth; filterMonth)
                    {
                        Caption = 'Month Filter';
                        ApplicationArea = All;
                    }
                    field(FilterYear; FilterYear)
                    {
                        Caption = 'Year filter';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if (StrLen(Format(FilterYear)) <> 4) or (FilterYear < 2021) then
                                Error('Please enter valid year code');
                        end;
                    }
                    field(FilterPeriods; FilterPeriods)
                    {

                        Caption = 'Periods';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if FilterPeriods > 12 then
                                Error('Please enter valid Number');
                        end;
                    }
                    field(filterBankAccNo; filterBankAccNo)
                    {
                        Caption = 'Bank Account No.';
                        ApplicationArea = All;
                        TableRelation = "Bank Account";
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
        if filterMonth = 0 then
            Error('Please Select Month');
        if FilterYear = 0 then
            Error('Please Select Year');

        FromDate := DMY2Date(1, filterMonth, FilterYear);
        ToDate := CalcDate('CM', FromDate);

        rBankAccount.Reset();
        rBankAccount.SetRange("no.", filterBankAccNo);
        if rBankAccount.FindFirst() then;

        rBankAccount.CalcFields(Balance);
        // BankBal := rBankAccount.Balance;

        intCountExp += 1;
        intCountRev := 0;
    end;

    var
        BankBal: Decimal;
        filterMonth: option " ","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec";
        FilterYear: Integer;
        filterBankAccNo: Code[20];
        rBankAccount: Record "Bank Account";
        FromDate: Date;
        ToDate: Date;
        decSOAmt: Decimal;
        decArAmt: Decimal;
        decApAmt: Decimal;
        decPoAmt: Decimal;
        NoofDays: Integer;
        FilterStartDay: Integer;
        FilterEndDay: Integer;
        DateColumns: Text;
        loop: Integer;
        FilterPeriods: Integer;
        rCustomer: Record Customer;
        rVendor: Record Vendor;
        blnBGColor: Boolean;
        decOpeningBal: Decimal;
        xdecArAmt: Decimal;
        xDecSOAmt: Decimal;
        xdecRevAmt: Decimal;
        xdecBALECAmt: Decimal;
        xdecApAmt: Decimal;
        xdecPoAmt: Decimal;
        xdecExpAmt: Decimal;
        xdecBALEDAmt: Decimal;
        recBankAcc: Record "Bank Account";
        intcnt: Integer;
        intCountRev: Integer;
        intCountExp: Integer;
        xRevDes: Text;
        xExpDes: Text;
}