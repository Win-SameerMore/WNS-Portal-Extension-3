tableextension 50058 "Customer Ext" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50010; "Credit Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50011; "Portal Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Customer Mails"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "No. of Open Orders"; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = CONST(Order),
                                                      "Sell-to Customer No." = FIELD("No."),
                                                      Status = filter(Open)));
            Caption = 'No. of Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Send SOA"; Boolean)
        {
            caption = 'Send SOA';
            DataClassification = ToBeClassified;
        }
        field(50016; "SOA Customer E-mails"; text[200])
        {
            Caption = 'SOA Customer E-mails';
            DataClassification = ToBeClassified;
        }
    }
    procedure GetCreditLimit()
    var
        CurrExchangeRate: Record "Currency Exchange Rate";
        TodayDate: Date;
        ExchangeRate: Decimal;
    begin
        TodayDate := today();

        CurrExchangeRate.GetLastestExchangeRate(Rec."Currency Code", TodayDate, ExchangeRate);
        if ExchangeRate <> 0 then
            Rec."Credit Limit" := Rec."Credit Limit (LCY)" / ExchangeRate;
        Rec.Modify();
    end;

    trigger OnAfterModify()
    var
        EventSubs: Codeunit "Event Subscriber";
    begin
        EventSubs.GenerateDefaultShiptoAddressForNewCustomer(rec);
    end;

    var
        myInt: Integer;
}