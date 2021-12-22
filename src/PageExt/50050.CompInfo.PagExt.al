pageextension 50050 "Company Information Ext" extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
        addafter("VAT Registration No.")
        {
            field("Registration No."; Rec."Registration No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("User Experience")
        {
            group("SSE Specific")
            {
                field("Chinese Company Name"; rec."Chinese Company Name")
                {
                    ApplicationArea = All;
                }
                field("Chinese Company Address 1"; rec."Chinese Company Address 1")
                {
                    ApplicationArea = All;
                }
                field("Chinese Company Address 2"; rec."Chinese Company Address 2")
                {
                    ApplicationArea = All;
                }
                field("Chinese City"; rec."Chinese City")
                {
                    ApplicationArea = All;
                }
                field("Extra Address 1"; rec."Extra Address 1")
                {
                    ApplicationArea = All;
                }
                field("Extra Address 2"; rec."Extra Address 2")
                {
                    ApplicationArea = All;
                }
                field("Extra City"; rec."Extra City")
                {
                    ApplicationArea = All;
                }
                field("Extra Post Code"; rec."Extra Post Code")
                {
                    ApplicationArea = All;
                }
                field("Extra Telephone"; rec."Extra Telephone")
                {
                    ApplicationArea = All;
                }
                field("Extra Fax"; rec."Extra Fax")
                {
                    ApplicationArea = All;
                }
                field("Certificate No."; rec."Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("ISO No."; rec."ISO No.")
                {
                    ApplicationArea = All;
                }
                field("Picture 2"; rec."Picture 2")
                {
                    ApplicationArea = All;
                }
                field("Picture 3"; rec."Picture 3")
                {
                    ApplicationArea = All;
                }
                field("Bank Detail 1"; rec."Bank Detail 1")
                {
                    ApplicationArea = All;
                }
                field("Bank Detail 2"; rec."Bank Detail 2")
                {
                    ApplicationArea = All;
                }
                field("Bank Detail 3"; rec."Bank Detail 3")
                {
                    ApplicationArea = All;
                }
                field("Bank Detail 4"; rec."Bank Detail 4")
                {
                    ApplicationArea = All;
                }
                field("QR Code"; Rec."QR Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}