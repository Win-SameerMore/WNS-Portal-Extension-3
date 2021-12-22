pageextension 50051 "Sal & Rec Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here

        addlast(General)
        {
            field("Sales Quote Terms 1"; Rec."Sales Quote Terms 1")
            {
                ApplicationArea = All;
            }
            field("Sales Quote Terms 2"; Rec."Sales Quote Terms 2")
            {
                ApplicationArea = All;
            }
            field("Sales Order Terms 1"; rec."Sales Order Terms 1")
            {
                ApplicationArea = All;
            }
            field("Sales Order Terms 2"; rec."Sales Order Terms 2")
            {
                ApplicationArea = All;
            }
            field("SSE Internal Mails"; Rec."SSE Internal Mails")
            {
                ApplicationArea = All;
            }
            field("Delivery Note Nos."; Rec."Delivery Note Nos.")
            {
                ApplicationArea = All;
            }
            field("Finance E-mails"; Rec."Finance E-mails")
            {
                ApplicationArea = All;
            }
        }
        addafter("Number Series")
        {
            group("SSE E-Commerce Portal")
            {
                field("ETA Available Remarks"; Rec."ETA Available Remarks")
                {
                    ApplicationArea = All;
                }
                field("ETA Not Available Remarks"; Rec."ETA Not Available Remarks")
                {
                    ApplicationArea = All;
                }
                field("Portal Sales Order Nos."; Rec."Portal Sales Order Nos.")
                {
                    ApplicationArea = All;
                }
                field("Freight G/L Acc."; Rec."Freight G/L Acc.")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Grp Overseas"; rec."VAT Bus. Posting Grp Overseas")
                {
                    ApplicationArea = All;
                }
                group("SO Terms & Conditions")
                {
                    Caption = 'SO Terms & Conditions';
                    field(SOTermCondition; SOTermCondition)
                    {
                        ApplicationArea = Basic, Suite;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTip = 'Specifies the products or service being offered.';

                        trigger OnValidate()
                        begin
                            Rec.SetSOTermCondition(SOTermCondition);
                        end;
                    }
                }
            }
        }

    }
    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SOTermCondition := Rec.GetSOTermCondition();
    end;

    var
        SOTermCondition: text;
        myInt: Integer;
}