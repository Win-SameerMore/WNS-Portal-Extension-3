page 50051 "Freight Charges"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Freight Charges";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field("Minimum Weight"; Rec."Minimum Weight")
                {
                    ApplicationArea = All;
                }
                field("Maximum Weight"; Rec."Maximum Weight")
                {
                    ApplicationArea = All;
                }
                field(Charges; Rec.Charges)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}