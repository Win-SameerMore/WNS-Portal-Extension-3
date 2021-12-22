tableextension 50050 "Comp Info Ext" extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Chinese Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Chinese Company Address 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Chinese Company Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Chinese City"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Extra Address 1"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Extra Address 2"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Extra City"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Extra Post Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Extra Telephone"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Extra Fax"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Certificate No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "ISO No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Picture 2"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50013; "Picture 3"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(50014; "Bank Detail 1"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Bank Detail 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Bank Detail 3"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Bank Detail 4"; text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "QR Code"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
    }

    var
        myInt: Integer;
}