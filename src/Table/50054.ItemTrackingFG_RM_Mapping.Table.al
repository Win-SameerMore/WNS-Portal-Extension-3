table 50054 "FG RM Item Tracking Mapping"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "FG Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(3; "FG Tracking Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "RM Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(5; "RM Tracking Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Source Type"; Enum "Source Type")
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Source ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Source Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.")
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