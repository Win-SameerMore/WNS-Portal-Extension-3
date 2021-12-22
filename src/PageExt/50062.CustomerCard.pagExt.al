pageextension 50062 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Credit Limit (LCY)")
        {
            field("Credit Limit"; Rec."Credit Limit")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Portal Customer"; rec."Portal Customer")
            {
                ApplicationArea = All;
            }
            field("Customer Mails"; Rec."Customer Mails")
            {
                ApplicationArea = All;
            }
            field("No. of Open Orders"; Rec."No. of Open Orders")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("No. of Invoices"; Rec."No. of Invoices")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("SOA Customer E-mails"; Rec."SOA Customer E-mails")
            {
                ApplicationArea = All;
            }
            field("Send SOA"; rec."Send SOA")
            {
                ApplicationArea = All;
            }
        }
        modify("Credit Limit (LCY)")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                rec.GetCreditLimit();
                CurrPage.Update(false);
            end;
        }
        modify("Currency Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                rec.GetCreditLimit();
                CurrPage.Update(false);
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
        // addlast(reporting)
        // {
        //     action("SOA Mail")
        //     {
        //         ApplicationArea = All;
        //         Image = SendMail;
        //         trigger OnAction()
        //         var
        //             AutoMail: Codeunit "Auto Mail";
        //         begin
        //             AutoMail.SOAAutoMail();
        //         end;
        //     }
        // }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     rec.GetCreditLimit();
    //     CurrPage.Update(false);
    // end;

    var
        myInt: Integer;
}