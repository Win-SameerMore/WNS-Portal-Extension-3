pageextension 50058 "Sales Quote Ext" extends "Sales Quote"
{
    layout
    {
        // Add changes to page layout here
        modify("Transport Method")
        {
            ApplicationArea = all;
        }
        addbefore(Status)
        {
            field("Customer Mails"; Rec."Customer Mails")
            {
                ApplicationArea = All;
            }
            field("SSE Internal Mails"; Rec."SSE Internal Mails")
            {
                ApplicationArea = All;
            }
            field("Quotation Validity"; rec."Quotation Validity")
            {
                ApplicationArea = All;
            }
            field("Project Name"; rec."Project Name")
            {
                ApplicationArea = All;
            }
            field("Cust RFQ. No."; Rec."Cust RFQ. No.")
            {
                ApplicationArea = All;
            }
            field("End User"; Rec."End User")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addlast("F&unctions")
        {
            action("SQ FollowUp")
            {
                ApplicationArea = All;
                Image = OrderReminder;
                trigger OnAction()
                var
                    Automail: Codeunit "Auto Mail";
                begin
                    clear(Automail);
                    Automail.SalesQuotationFollowup(Rec."No.");
                end;
            }
        }

    }

    var
        myInt: Integer;
}