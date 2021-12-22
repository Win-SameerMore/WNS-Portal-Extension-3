report 50011 "Payment Voucher Final"
{
    // version MMS

    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layout/Payment Voucher Final.rdl';
    Caption = 'Payment Voucher';
    PreviewMode = PrintLayout;
    ApplicationArea = all;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Line No.")
                                ORDER(Ascending);
            RequestFilterFields = "Account Type", "Account No.", "Document No.";
            column(Payee; PayeeName)
            {
            }
            column(Journal_Batch_Name; "Gen. Journal Line"."Journal Batch Name")
            { }
            column(Description; "Gen. Journal Line".Description)
            {
            }
            column(Bank; "Gen. Journal Line"."Account No.")
            {
            }
            column(VoucherNo; "Gen. Journal Line"."Account No.")
            {
            }
            column(VoucherNo2; "Gen. Journal Line"."Document No.")
            {
            }
            column(PostingDate; "Gen. Journal Line"."Posting Date")
            {
            }
            column(PaymentBy; "Gen. Journal Line"."Bal. Account No.")
            {
            }
            column(Amount; "Gen. Journal Line".Amount)
            {
            }
            column(CompAddr1; CompAddr[1])
            {
            }
            column(PostingDate_GenJournalLine; "Gen. Journal Line"."Posting Date")
            {
            }
            column(CurrencyCode_GenJournalLine; CurrCode)
            {
            }
            column(DocumentNo_GenJournalLine; "Gen. Journal Line"."Document No.")
            {
            }
            column(CompnInfoName; CompnInfo.Name)
            {
            }
            column(Company_Name; CompnInfo.Name)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankDec; BankName)
            {
            }
            column(Company_Addr; CompnInfo.Address)
            {
            }
            column(Company_Addr2; CompnInfo."Address 2" + ' ' + CountryRegion2.Name + ' ' + CompnInfo."Post Code")
            {
            }
            column(Company_RegNo; CompnInfo."Registration No.")
            {
            }
            column(Company_Tel; CompnInfo."Phone No.")
            {
            }
            column(Company_Fax; CompnInfo."Fax No.")
            {
            }
            column(Company_GST; CompnInfo."VAT Registration No.")
            {
            }
            column(Company_Reg; CompnInfo."Registration No.")
            { }
            column(Compny_Email; CompnInfo."E-Mail")
            {
            }
            column(Company_Home; CompnInfo."Home Page")
            { }

            column(ExternalDocumentNo_GenJournalLine; "Gen. Journal Line"."External Document No.")
            {
            }
            column(IsHide; IsHide)
            {
            }
            column(CompAddr2; CompAddr[2])
            {
            }
            column(CompAddr3; CompAddr[3])
            {
            }
            column(CompAddr4; CompAddr[4])
            {
            }
            column(CustAddr1; CustAddr[1])
            {
            }
            column(Opt; Opt)
            {
            }
            column(CustAddr2; CustAddr[2])
            {
            }
            column(CustAddr3; CustAddr[3])
            {
            }
            column(CustAddr4; CustAddr[4])
            {
            }
            column(BankAccountName; BankAccount.Name)
            {
            }
            column(TotAmount; TotAmount)
            {
            }
            column(Picture; CompnInfo.Picture)
            {
            }
            column(VendorPOsGup; '')
            {
            }
            column(PayableAccount; PayAccount)
            {
            }
            column(ApplnCurrencyCode; ApplnCurrencyCode)
            {
            }
            column(AmtInWords; CurrCode + '  : ' + AmtInWords[1])
            {
            }
            column(BaankAccName2; BaankAccName2)
            {
            }
            column(Currency; CurrCode)
            {
            }
            dataitem(Integer; Integer)
            {
                column(InvNo; DocNo)
                {
                }

                column(LineNo; LineNo) { }
                column(RemAmt; VLEAmount)
                {
                }
                column(AmounttoApply_VendorLedgerEntry; VLEAmounttoApply)
                {
                }
                column(VLEOrignAmt; VLEOrignAmt)
                {
                }
                column(VLEOrignCurrency; VLEOrignCurrency)
                {
                }
                column(ShowColumn; ShowColumn)
                {
                }
                column(Cap; Cap)
                {
                }
                column(Group; Group)
                {
                }
                column(ReminAmount; -(ReminAmount))
                {
                }
                column(Des; Des)
                {
                }
                column(Date; Date)
                {
                }

                trigger OnAfterGetRecord();
                begin

                    IF Number > 1 THEN;
                    VLETEMP.NEXT;
                    IF Number = 1 THEN
                        IF VLETEMP.FINDFIRST THEN;
                    DocNo := VLETEMP.Description;
                    //DocNo := VLETEMP."Document No.";
                    Des := VLETEMP.Description;
                    Group := VLETEMP."Document No.";
                    //VLEAmounttoApply :=   -VLETEMP."Original Pmt. Disc. Possible";
                    //VLEOrignAmt := -VLETEMP."Accepted Payment Tolerance";
                    VLEAmounttoApply := VLETEMP."Original Pmt. Disc. Possible";
                    VLEOrignAmt := VLETEMP."Accepted Payment Tolerance";
                    ReminAmount := VLETEMP."Max. Payment Tolerance";
                    VLEOrignCurrency := VLETEMP."Currency Code";
                    PrevNumber := Number;

                    //IF VLEOrignCurrency = ApplnCurrencyCode THEN BEGIN
                    //  VLEOrignCurrency := '';
                    //END;

                    IF (ApplnCurrencyCode <> '') AND (VLEOrignCurrency <> '') THEN
                        ShowColumn := TRUE;
                    //New +++
                    //MESSAGE('%1',Number);
                    CLEAR(Date);
                    Date := VLETEMP."Posting Date";
                    IF Date = 0D THEN
                        Date := "Gen. Journal Line"."Posting Date";
                end;

                trigger OnPreDataItem();
                var
                    lBank: Record "Bank Account";
                begin

                    CLEAR(ShowColumn);
                    IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Vendor THEN BEGIN
                        CLEAR(ShowColumn);
                        VLE.RESET;
                        VLE.SETRANGE(VLE."Applies-to ID", "Gen. Journal Line"."Document No.");
                        IF VLE.FINDSET THEN BEGIN
                            REPEAT
                                LineNo += 1;
                                IF NOT VLETEMP.GET(LineNo) THEN BEGIN
                                    ShowColumn := TRUE;
                                    VLETEMP.INIT;
                                    VLETEMP."Entry No." := LineNo;
                                    VLETEMP."Document No." := "Gen. Journal Line"."Document No.";
                                    VLETEMP."Posting Date" := VLE."Posting Date";
                                    IF VLE."External Document No." <> '' THEN
                                        VLETEMP.Description := VLE."Document No." + '  /  ' + VLE."External Document No."
                                    ELSE
                                        VLETEMP.Description := VLE."Document No.";
                                    //VLETEMP."Original Pmt. Disc. Possible"  := CalcApplnAmounttoApply(VLE."Amount to Apply",VLE."Currency Code",VLE."Posting Date");
                                    //IF  VLETEMP."Original Pmt. Disc. Possible" = 0 THEN
                                    //VLETEMP."Original Pmt. Disc. Possible" := VLE."Amount to Apply";
                                    VLE.CALCFIELDS(VLE."Original Amount");
                                    VLE.CALCFIELDS(VLE."Remaining Amount");
                                    VLETEMP."Max. Payment Tolerance" := VLE."Remaining Amount";
                                    IF VLE."Document Type" = VLE."Document Type"::Invoice THEN BEGIN
                                        VLETEMP."Accepted Payment Tolerance" := ABS(VLE."Original Amount");
                                        VLETEMP."Original Pmt. Disc. Possible" := ABS(VLE."Amount to Apply");
                                    END;
                                    IF VLE."Document Type" = VLE."Document Type"::"Credit Memo" THEN BEGIN
                                        VLETEMP."Accepted Payment Tolerance" := -VLE."Original Amount";
                                        VLETEMP."Original Pmt. Disc. Possible" := -VLE."Amount to Apply";
                                    END;
                                    IF ("Gen. Journal Line"."Currency Code" <> '') AND ("Gen. Journal Line"."Currency Code" <> GLSetup."LCY Code") THEN
                                        IF VLE."Amount to Apply" = 0 THEN
                                            VLETEMP."Original Pmt. Disc. Possible" := -"Gen. Journal Line".Amount;
                                    IF ("Gen. Journal Line"."Currency Code" <> '') AND ("Gen. Journal Line"."Currency Code" <> GLSetup."LCY Code") THEN
                                        IF lBank.GET("Gen. Journal Line"."Bal. Account No.") THEN
                                            IF lBank."Currency Code" = '' THEN
                                                VLETEMP."Original Pmt. Disc. Possible" := -"Gen. Journal Line"."Amount (LCY)";
                                    IF VLE."Currency Code" <> '' THEN
                                        VLETEMP."Currency Code" := VLE."Currency Code"
                                    ELSE
                                        IF VLE."Currency Code" = '' THEN
                                            VLETEMP."Currency Code" := GLSetup."LCY Code";
                                    IF VLE."Currency Code" = "Gen. Journal Line"."Currency Code" THEN
                                        CLEAR(ShowColumn);
                                    VLETEMP.INSERT;
                                END;
                            UNTIL VLE.NEXT = 0;
                        END ELSE BEGIN
                            LineNo += 1;
                            IF NOT VLETEMP.GET(LineNo) THEN BEGIN
                                VLETEMP.INIT;
                                VLETEMP."Entry No." := LineNo;//"Gen. Journal Line"."Line No.";
                                VLETEMP."Document No." := "Gen. Journal Line"."Document No.";
                                VLETEMP.Description := "Gen. Journal Line".Description;
                                VLETEMP."Original Pmt. Disc. Possible" := ABS("Gen. Journal Line".Amount);
                                //VLETEMP."Currency Code" := "Gen. Journal Line"."Currency Code";
                                IF "Gen. Journal Line"."Currency Code" = '' THEN
                                    VLETEMP."Currency Code" := GLSetup."LCY Code"
                                ELSE
                                    VLETEMP."Currency Code" := "Gen. Journal Line"."Currency Code";
                                VLETEMP."Accepted Payment Tolerance" := "Gen. Journal Line".Amount;
                                IF (BankAccount."Currency Code" = '') OR (BankAccount."Currency Code" = GLSetup."LCY Code") THEN
                                    IF "Gen. Journal Line"."Currency Factor" > 0 THEN
                                        VLETEMP."Original Pmt. Disc. Possible" := "Gen. Journal Line"."Amount (LCY)";
                                VLETEMP.INSERT;
                            END;
                        END;
                    END ELSE
                        IF ("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::"G/L Account") AND
                           ("Gen. Journal Line".Amount > 0) THEN BEGIN
                            LineNo += 1;
                            IF NOT VLETEMP.GET(LineNo) THEN BEGIN
                                VLETEMP.INIT;
                                VLETEMP."Entry No." := LineNo;
                                VLETEMP."Document No." := "Gen. Journal Line"."Document No.";
                                VLETEMP.Description := "Gen. Journal Line".Description;
                                //VLETEMP.Description :=  "Gen. Journal Line"."Message to Recipient";
                                VLETEMP."Original Pmt. Disc. Possible" := ABS("Gen. Journal Line".Amount);
                                IF "Gen. Journal Line"."Currency Code" = '' THEN
                                    VLETEMP."Currency Code" := GLSetup."LCY Code"
                                ELSE
                                    VLETEMP."Currency Code" := "Gen. Journal Line"."Currency Code";

                                VLETEMP.INSERT;
                            END;
                        END ELSE
                            IF "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."Account Type"::Customer THEN BEGIN
                                LineNo += 1;
                                IF NOT VLETEMP.GET(LineNo) THEN BEGIN
                                    VLETEMP.INIT;
                                    VLETEMP."Entry No." := LineNo;
                                    VLETEMP."Document No." := "Gen. Journal Line"."Document No.";
                                    VLETEMP.Description := "Gen. Journal Line".Description;
                                    //VLETEMP.Description :=  "Gen. Journal Line"."Message to Recipient";
                                    VLETEMP."Original Pmt. Disc. Possible" := -"Gen. Journal Line".Amount;
                                    VLETEMP."Currency Code" := "Gen. Journal Line"."Currency Code";
                                    VLETEMP.INSERT;
                                END;
                            END;
                    IF VLETEMP.FINDSET THEN;
                    SETRANGE(Number, 1, VLETEMP.COUNT);

                    IF (ApplnCurrencyCode <> '') AND (VLETEMP."Currency Code" <> '') AND (ApplnCurrencyCode <> VLETEMP."Currency Code") THEN
                        ShowColumn := TRUE;

                    IF ShowColumn THEN
                        Cap := 'Invoice Amount'
                    ELSE
                        Cap := ' ';
                end;
            }

            trigger OnAfterGetRecord();
            var
                GenJournalLine: Record "Gen. Journal Line";
                Check: Report Check;
            begin
                CLEAR(Check);
                //Check.InitTextVariable;
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJournalLine.SETRANGE("Document No.", "Gen. Journal Line"."Document No.");
                GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::"Bank Account");
                IF GenJournalLine.FINDFIRST THEN BEGIN
                    BankAccount.GET(GenJournalLine."Account No.");
                    BankCode := BankAccount."No.";
                    BankName := BankAccount.Name;
                END ELSE BEGIN
                    GenJournalLine.SETRANGE(GenJournalLine."Account Type");
                    GenJournalLine.SETRANGE(GenJournalLine."Bal. Account Type", GenJournalLine."Bal. Account Type"::"Bank Account");
                    IF GenJournalLine.FINDFIRST THEN
                        BankAccount.GET(GenJournalLine."Bal. Account No.");
                    BankName := BankAccount.Name;
                    BankCode := BankAccount."No.";
                END;


                CLEAR(TotAmount);
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
                GenJournalLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                GenJournalLine.SETRANGE("Document No.", "Gen. Journal Line"."Document No.");
                GenJournalLine.SETFILTER(Amount, '<%1', 0);
                IF GenJournalLine.FINDSET THEN
                    REPEAT
                        TotAmount += ABS(GenJournalLine.Amount);
                    UNTIL GenJournalLine.NEXT = 0;
                IF TotAmount = 0 THEN BEGIN//means Bal. Account No. will be on same line
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    GenJournalLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    GenJournalLine.SETRANGE("Document No.", "Gen. Journal Line"."Document No.");
                    GenJournalLine.SETFILTER("Bal. Account No.", '<>%1', '');
                    IF GenJournalLine.FINDSET THEN
                        REPEAT
                            TotAmount += ABS(GenJournalLine.Amount);
                        UNTIL GenJournalLine.NEXT = 0;
                END;



                CLEAR(CustAddr);
                IF Vendor.GET("Gen. Journal Line"."Account No.") THEN BEGIN
                    PayeeName := Vendor.Name;
                    CustAddr[2] := Vendor.Address;
                    CustAddr[3] := Vendor."Address 2";
                    IF CountryRegion.GET(Vendor."Country/Region Code") THEN;
                    CustAddr[4] := CountryRegion.Name + ' ' + Vendor."Post Code";
                    COMPRESSARRAY(CustAddr);
                END ELSE
                    PayeeName := "Gen. Journal Line"."Message to Recipient";

                IF "Gen. Journal Line"."Currency Code" = '' THEN
                    CurrCode := GLSetup."LCY Code"
                ELSE
                    CurrCode := "Gen. Journal Line"."Currency Code";

                VLETEMP.DELETEALL;
                //Check.FormatNoTextNew(AmtInWords, TotAmount, CurrCode);
                //Check.FormatNoText(AmtInWords, TotAmount, CurrCode);
                //WIN351++
                InitTextVariable;
                FormatNoText(AmtInWords, TotAmount, CurrencyCode);
                AmtInWords[1] := LOWERCASE(AmtInWords[1]);
                //AmountInWords[2] := LOWERCASE(AmountInWords[1]);
                lTxt := COPYSTR(AmtInWords[1], 1, 1);
                lTxt := UPPERCASE(lTxt);
                lTxt := lTxt + COPYSTR(AmtInWords[1], 2);
                //MESSAGE('%1',lTxt);
                AmtInWords[1] := lTxt;
                //WIN351--
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                FRA = 'Options';
                    field("Voucher Type"; Opt)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Voucher Type',
                                    FRA = 'Voucher Type';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompnInfo.GET;
        CompnInfo.CALCFIELDS(Picture);
        CountryRegion2.GET(CompnInfo."Country/Region Code");
        //FormatAddress.Company(CompAddr,CompnInfo);
        GLSetup.GET;
        CLEAR(LineNo);
        /*
        IF Opt = Opt::"RECEIPT VOUCHER" THEN
          IsHide := TRUE
        ELSE
          CLEAR(IsHide);
        */
        //opt := Opt::"PAYMENT VOUCHER";

    end;

    var
        LastDocNo: Code[20];
        FormatAddress: Codeunit "Format Address";
        CompAddr: array[8] of Text[50];
        CompnInfo: Record "Company Information";
        CustAddr: array[8] of Text[50];
        Cust: Record Vendor;
        TotAmount: Decimal;
        GLSetup: Record "General Ledger Setup";
        CurrCode: Code[20];
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Customer Posting Group";
        BankAccount: Record "Bank Account";
        PayeeName: Text;
        VLE: Record "Vendor Ledger Entry";
        VLETEMP: Record "Vendor Ledger Entry" temporary;
        DocNo: Text;
        VLEAmount: Decimal;
        VLEAmounttoApply: Decimal;
        RecCount: Integer;
        PrevNumber: Integer;
        PayAccount: Code[20];
        ValidExchRate: Boolean;
        ApplnCurrencyCode: Code[10];
        ApplnDate: Date;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        VLEOrignAmt: Decimal;
        VLEOrignCurrency: Code[10];
        TransCurrency: Code[10];
        ShowColumn: Boolean;
        Cap: Text;
        DontShowCurrency: Boolean;
        Group: Code[100];
        LineNo: Integer;
        VendorRec: Record Vendor;
        VendorPostingGroup2: Record "Vendor Posting Group";
        BaankAccName2: Text;
        Curr: Code[10];
        AMT: Decimal;
        GenJounl: Record "Gen. Journal Line";
        GenJounl2: Record "Gen. Journal Line";
        CountryRegion: Record "Country/Region";
        BankCode: Code[20];
        BankName: Text;
        CurreccyCode: Code[20];
        AmtInWords: array[2] of Text[1020];
        Opt: Option "PAYMENT VOUCHER","PETTY CASH VOUCHER";
        IsHide: Boolean;
        ReminAmount: Decimal;
        Des: Text;
        Date: Date;
        CountryRegion2: Record "Country/Region";
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        CurrencyCode: Code[20];
        lTxt: Text;

    procedure CalcApplnAmounttoApply(AmounttoApply: Decimal; var CurrencyCode: Code[20]; var PosDate: Date): Decimal;
    var
        ApplnAmounttoApply: Decimal;
    begin
        ApplnDate := PosDate;
        ValidExchRate := TRUE;
        IF ApplnCurrencyCode = CurrencyCode THEN
            EXIT(AmounttoApply);
        IF ApplnDate = 0D THEN
            ApplnDate := PosDate;
        IF ApplnCurrencyCode = GLSetup."LCY Code" THEN
            ApplnAmounttoApply :=
              CurrExchRate.ApplnExchangeAmtFCYToFCY(
                ApplnDate, CurrencyCode, '', AmounttoApply, ValidExchRate)
        ELSE
            ApplnAmounttoApply :=
              CurrExchRate.ApplnExchangeAmtFCYToFCY(
                ApplnDate, CurrencyCode, ApplnCurrencyCode, AmounttoApply, ValidExchRate);
        //MESSAGE('INSIDE LOOP%1 = %2 = %3 = %4 = %5 = %6',ApplnDate,CurrencyCode,ApplnCurrencyCode,AmounttoApply,ValidExchRate,ApplnAmounttoApply);
        EXIT(ApplnAmounttoApply);
    end;
    //WIN451++
    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; Currency: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        DecimalPosition: Decimal;
        recCurrency: Record 4;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        //NoText[1] := '****';
        NoText[1] := ' ';
        GLSetup.GET;//WIN345

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END ELSE
                    IF (Tens * 10 + Ones) > 0 THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;


        IF "Gen. Journal Line"."Currency Code" <> '' THEN
            recCurrency.GET("Gen. Journal Line"."Currency Code");
        //ELSE
        //recCurrency.GET(GLSetup."LCY Code");

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, recCurrency.Description + ' ' + Text028)//Need To Update WIN504
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'DOLLARS ' + Text028);//recCurrency."Currency Description"

        /*
        IF GLSetup."Amount Rounding Precision" <> 0 THEN
          DecimalPosition := 1 / GLSetup."Amount Rounding Precision"
        ELSE
          DecimalPosition := 1;
        */

        //for displaying cents
        No := No * 100;
        Tens := No DIV 10;
        Ones := No MOD 10;
        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE BEGIN
            IF Tens >= 2 THEN BEGIN
                AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                IF Ones > 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
            END ELSE
                IF (Tens * 10 + Ones) > 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
        END;
        //AddToNoText(NoText, NoTextIndex, PrintExponent, 'CENTS ONLY');


        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, recCurrency.Description + ' ONLY')//Need To Update WIN504
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'CENTS ONLY');//  + '/' + FORMAT(DecimalPosition)));


        /*IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);*/

    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;
    //WIN351--
}

