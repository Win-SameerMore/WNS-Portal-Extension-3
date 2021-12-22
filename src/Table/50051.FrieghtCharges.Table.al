table 50051 "Freight Charges"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Currency; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(2; "Minimum Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                if ("Maximum Weight" < "Minimum Weight") and ("Maximum Weight" <> 0) and ("Minimum Weight" <> 0) then
                    Error('Maximum Weight can''t be lesser then Minimum Weight');
            end;
        }
        field(3; "Maximum Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ("Maximum Weight" < "Minimum Weight") and ("Maximum Weight" <> 0) and ("Minimum Weight" <> 0) then
                    Error('Maximum Weight can''t be lesser then Minimum Weight');
            end;
        }
        field(4; Charges; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; Currency, "Minimum Weight", "Maximum Weight")
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