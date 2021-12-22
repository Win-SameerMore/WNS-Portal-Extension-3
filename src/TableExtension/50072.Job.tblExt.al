tableextension 50072 "Job Ext" extends Job
{
    fields
    {
        // Add changes to table fields here
        field(50000; "SO number"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." where("Document Type" = filter(Order));

            trigger OnValidate()
            var
                recSalesHeader: Record "Sales Header";
                SalRecSetup: Record "Sales & Receivables Setup";
            begin
                recSalesHeader.Reset();
                recSalesHeader.SetRange("No.", Rec."SO number");
                if recSalesHeader.FindFirst() then begin
                    "Sales Order Date" := recSalesHeader."Order Date";
                    "Project Name" := recSalesHeader."Project Name";
                end;
                SalRecSetup.get();
                Add_SO_Dimension(SalRecSetup."Sales Order Dimension", "SO number");
            end;

        }
        field(50001; "Sales Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

    }
    procedure Add_SO_Dimension(var DimCode: Code[20]; var DimValue: Code[20])
    var
        DefaultDimensionTmp: Record "Default Dimension" temporary;
        DefaultDimension: Record "Default Dimension";
        DimMgmt: Codeunit DimensionManagement;
        DimensionValue: Record "Dimension Value";
        rDefaultDimension: Record "Default Dimension";

    begin
        IF DimensionValue.GET(DimCode, DimValue) THEN;
        DefaultDimension.reset();
        DefaultDimension.SetRange("Table ID", Database::Job);
        DefaultDimension.SetRange("No.", Rec."No.");
        DefaultDimension.setfilter("Dimension Code", '<>%1', DimCode);
        if DefaultDimension.findset() then
            repeat
                DimensionValue.get(DefaultDimension."Dimension code", DefaultDimension."Dimension value code");
                DefaultDimensionTmp.Init();
                DefaultDimensionTmp.Validate("Dimension Code", DefaultDimension."Dimension Code");
                DefaultDimensionTmp.Validate("Dimension Value Code", DefaultDimension."Dimension Value Code");
                DefaultDimensionTmp."Table ID" := Database::Job;
                DefaultDimensionTmp."No." := Rec."No.";
                DefaultDimensionTmp.Insert();
            until DefaultDimension.Next = 0;
        rDefaultDimension.Init();
        rDefaultDimension.Validate(rDefaultDimension."Dimension Code", DimCode);
        rDefaultDimension.Validate(rDefaultDimension."Dimension Value Code", DimValue);
        rDefaultDimension."Table ID" := database::job;
        rDefaultDimension."No." := Rec."No.";
        rDefaultDimension.Insert();
        // Rec."Dimension Set ID" := DimMgmt.GetDimensionSetID(DefaultDimensionTmp);

    end;

    var
        myInt: Integer;
}