table 50050 "Minimum Order Value Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(2; "Admin Minimum Order Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Admin Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Admin Charges G/L Acc."; Code[20])
        {
            TableRelation = "G/L Account" where("Account Type" = filter(Posting), Blocked = filter(false), "Direct Posting" = CONST(true));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                GLAcc: Record "g/l account";
            begin
                GLAcc.Reset();
                if GLAcc.get("Admin Charges G/L Acc.") then
                    "Admin Charges G/L Acc. Desc." := GLAcc.Name;
            end;
        }
        field(5; "Delivery Minimum Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Delivery Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Delivery Charges G/L Acc."; code[20])
        {
            TableRelation = "g/l account" where("Account Type" = filter(Posting), Blocked = filter(false), "Direct Posting" = CONST(true));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                GLAcc: Record "g/l account";
            begin
                GLAcc.Reset();
                if GLAcc.get("Delivery Charges G/L Acc.") then
                    "Del. Charges G/L Acc. Desc." := GLAcc.Name;
            end;
        }
        field(8; "Admin Charges G/L Acc. Desc."; Text[30])
        {
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
        field(9; "Del. Charges G/L Acc. Desc."; Text[30])
        {
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Currency Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}