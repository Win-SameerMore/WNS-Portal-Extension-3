page 50054 "AO Serial Mapping"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Reservation Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // field("Lot No."; Rec."Lot No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Serial No."; rec."Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(LineItemNo1; LineTrackingRM[1])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[1];
                    Visible = VisibilityItemNo1;

                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(1);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(1);
                    end;
                }
                field(LineItemNo2; LineTrackingRM[2])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[2];
                    Visible = VisibilityItemNo2;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(2);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(2);
                    end;
                }
                field(LineItemNo3; LineTrackingRM[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[3];
                    Visible = VisibilityItemNo3;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(3);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(3);
                    end;
                }
                field(LineItemNo4; LineTrackingRM[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[4];
                    Visible = VisibilityItemNo4;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(4);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(4);
                    end;

                }
                field(LineItemNo5; LineTrackingRM[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[5];
                    Visible = VisibilityItemNo5;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(5);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(5);
                    end;
                }
                field(LineItemNo6; LineTrackingRM[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[6];
                    Visible = VisibilityItemNo6;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(6);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(6);
                    end;
                }
                field(LineItemNo7; LineTrackingRM[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[7];
                    Visible = VisibilityItemNo7;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(7);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(7);
                    end;
                }
                field(LineItemNo8; LineTrackingRM[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[8];
                    Visible = VisibilityItemNo8;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(8);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(8);
                    end;
                }
                field(LineItemNo9; LineTrackingRM[9])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[9];
                    Visible = VisibilityItemNo9;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(9);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(9);
                    end;
                }
                field(LineItemNo10; LineTrackingRM[10])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[10];
                    Visible = VisibilityItemNo10;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(10);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(10);
                    end;
                }
                field(LineItemNo11; LineTrackingRM[11])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[11];
                    Visible = VisibilityItemNo11;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(11);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(11);
                    end;
                }
                field(LineItemNo12; LineTrackingRM[12])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[12];
                    Visible = VisibilityItemNo12;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(12);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(12);
                    end;
                }
                field(LineItemNo13; LineTrackingRM[13])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[13];
                    Visible = VisibilityItemNo13;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(13);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(13);
                    end;
                }
                field(LineItemNo14; LineTrackingRM[14])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[14];
                    Visible = VisibilityItemNo14;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(14);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(14);
                    end;
                }
                field(LineItemNo15; LineTrackingRM[15])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[15];
                    Visible = VisibilityItemNo15;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(15);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(15);
                    end;
                }
                field(LineItemNo16; LineTrackingRM[16])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[16];
                    Visible = VisibilityItemNo16;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(16);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(16);
                    end;
                }
                field(LineItemNo17; LineTrackingRM[17])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[17];
                    Visible = VisibilityItemNo17;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(17);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(17);
                    end;
                }
                field(LineItemNo18; LineTrackingRM[18])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[18];
                    Visible = VisibilityItemNo18;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(18);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(18);
                    end;
                }
                field(LineItemNo19; LineTrackingRM[19])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[19];
                    Visible = VisibilityItemNo19;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(19);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(19);
                    end;
                }
                field(LineItemNo20; LineTrackingRM[20])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[20];
                    Visible = VisibilityItemNo20;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(20);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(20);
                    end;
                }
                field(LineItemNo21; LineTrackingRM[21])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[21];
                    Visible = VisibilityItemNo21;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(21);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(21);
                    end;
                }
                field(LineItemNo22; LineTrackingRM[22])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[22];
                    Visible = VisibilityItemNo22;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(22);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(22);
                    end;
                }
                field(LineItemNo23; LineTrackingRM[23])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[23];
                    Visible = VisibilityItemNo23;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(23);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(23);
                    end;
                }
                field(LineItemNo24; LineTrackingRM[24])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[24];
                    Visible = VisibilityItemNo24;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(24);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(24);
                    end;
                }
                field(LineItemNo25; LineTrackingRM[25])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[25];
                    Visible = VisibilityItemNo25;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(25);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(25);
                    end;
                }
                field(LineItemNo26; LineTrackingRM[26])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[26];
                    Visible = VisibilityItemNo26;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(26);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(26);
                    end;
                }
                field(LineItemNo27; LineTrackingRM[27])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[27];
                    Visible = VisibilityItemNo27;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(27);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(27);
                    end;
                }
                field(LineItemNo28; LineTrackingRM[28])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[28];
                    Visible = VisibilityItemNo28;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(28);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(28);
                    end;
                }
                field(LineItemNo29; LineTrackingRM[29])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[29];
                    Visible = VisibilityItemNo29;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(29);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(29);
                    end;
                }
                field(LineItemNo30; LineTrackingRM[30])
                {
                    ApplicationArea = All;
                    CaptionClass = '3,' + LineItemNoCaption[30];
                    Visible = VisibilityItemNo30;
                    trigger OnDrillDown()
                    begin
                        MapTrackingforFG(30);
                    end;

                    trigger OnValidate()
                    begin
                        OnValidateSerial(30);
                    end;
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

    trigger OnAfterGetRecord()
    var
        MaxColumns_Rec: Integer;
    begin
        while MaxColumns > MaxColumns_Rec do begin
            MaxColumns_Rec += 1;
            Matrix_Fill(MaxColumns_Rec);
        end;
    end;

    trigger OnOpenPage()
    begin
        Load();
    end;

    var
        VisibilityItemNo1: Boolean;
        VisibilityItemNo2: Boolean;
        VisibilityItemNo3: Boolean;
        VisibilityItemNo4: Boolean;
        VisibilityItemNo5: Boolean;
        VisibilityItemNo6: Boolean;
        VisibilityItemNo7: Boolean;
        VisibilityItemNo8: Boolean;
        VisibilityItemNo9: Boolean;
        VisibilityItemNo10: Boolean;
        VisibilityItemNo11: Boolean;
        VisibilityItemNo12: Boolean;
        VisibilityItemNo13: Boolean;
        VisibilityItemNo14: Boolean;
        VisibilityItemNo15: Boolean;
        VisibilityItemNo16: Boolean;
        VisibilityItemNo17: Boolean;
        VisibilityItemNo18: Boolean;
        VisibilityItemNo19: Boolean;
        VisibilityItemNo20: Boolean;
        VisibilityItemNo21: Boolean;
        VisibilityItemNo22: Boolean;
        VisibilityItemNo23: Boolean;
        VisibilityItemNo24: Boolean;
        VisibilityItemNo25: Boolean;
        VisibilityItemNo26: Boolean;
        VisibilityItemNo27: Boolean;
        VisibilityItemNo28: Boolean;
        VisibilityItemNo29: Boolean;
        VisibilityItemNo30: Boolean;
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        IntLineCnt: integer;
        rReservationEntry: Record "Reservation Entry";
        MaxColumns: Integer;

    protected var
        xLineTrackingRM: array[30] of Text;
        LineTrackingRM: array[30] of text;
        LineTrackingRM_LineNO: array[30] of Integer;
        LineItemNoCaption: array[30] of text;

    local procedure Load()
    begin
        AssemblyLine.Reset();
        AssemblyLine.SetRange("Document No.", AssemblyHeader."No.");
        AssemblyLine.SetRange(Type, AssemblyLine.Type::Item);
        if AssemblyLine.FindFirst() then
            repeat
                IntLineCnt += 1;
                LineItemNoCaption[IntLineCnt] := AssemblyLine."No.";
                LineTrackingRM_LineNO[IntLineCnt] := AssemblyLine."Line No.";
            until (AssemblyLine.Next() = 0);
        MaxColumns := IntLineCnt;

        VisibilityItemNo1 := LineItemNoCaption[1] <> '';
        VisibilityItemNo2 := LineItemNoCaption[2] <> '';
        VisibilityItemNo3 := LineItemNoCaption[3] <> '';
        VisibilityItemNo4 := LineItemNoCaption[4] <> '';
        VisibilityItemNo5 := LineItemNoCaption[5] <> '';
        VisibilityItemNo6 := LineItemNoCaption[6] <> '';
        VisibilityItemNo7 := LineItemNoCaption[7] <> '';
        VisibilityItemNo8 := LineItemNoCaption[8] <> '';
        VisibilityItemNo9 := LineItemNoCaption[9] <> '';
        VisibilityItemNo10 := LineItemNoCaption[10] <> '';
        VisibilityItemNo11 := LineItemNoCaption[11] <> '';
        VisibilityItemNo12 := LineItemNoCaption[12] <> '';
        VisibilityItemNo13 := LineItemNoCaption[13] <> '';
        VisibilityItemNo14 := LineItemNoCaption[14] <> '';
        VisibilityItemNo15 := LineItemNoCaption[15] <> '';
        VisibilityItemNo16 := LineItemNoCaption[16] <> '';
        VisibilityItemNo17 := LineItemNoCaption[17] <> '';
        VisibilityItemNo18 := LineItemNoCaption[18] <> '';
        VisibilityItemNo19 := LineItemNoCaption[19] <> '';
        VisibilityItemNo20 := LineItemNoCaption[20] <> '';
        VisibilityItemNo21 := LineItemNoCaption[21] <> '';
        VisibilityItemNo22 := LineItemNoCaption[22] <> '';
        VisibilityItemNo23 := LineItemNoCaption[23] <> '';
        VisibilityItemNo24 := LineItemNoCaption[24] <> '';
        VisibilityItemNo25 := LineItemNoCaption[25] <> '';
        VisibilityItemNo26 := LineItemNoCaption[26] <> '';
        VisibilityItemNo27 := LineItemNoCaption[27] <> '';
        VisibilityItemNo28 := LineItemNoCaption[28] <> '';
        VisibilityItemNo29 := LineItemNoCaption[29] <> '';
        VisibilityItemNo30 := LineItemNoCaption[30] <> '';
    end;

    procedure SetAssemblyHeader(rAssemblyHeader: Record "Assembly Header")
    begin
        AssemblyHeader.SetRange("No.", rAssemblyHeader."No.");
        AssemblyHeader.SetRange("Document Type", rAssemblyHeader."Document Type");
        AssemblyHeader.FindFirst();
    end;

    local procedure MapTrackingforFG(ColumnID: Integer)
    var
        FGRMTrackingMapping: Record "FG RM Item Tracking Mapping";
        RecResveEntry: Record "Reservation Entry";
        ReservationEntry: Record "Reservation Entry";
        rFGRMMapping: Record "FG RM Item Tracking Mapping";
    begin
        rReservationEntry.Reset();
        rReservationEntry.SetRange("Source ID", AssemblyHeader."No.");
        rReservationEntry.SetRange("Item No.", LineItemNoCaption[ColumnID]);
        rReservationEntry.SetRange("RM Alloted", false);
        rReservationEntry.SetRange("Source Ref. No.", LineTrackingRM_LineNO[ColumnID]);
        if rReservationEntry.FindFirst() then begin
            if Page.RunModal(0, rReservationEntry) = action::LookupOK then begin
                if LineTrackingRM[ColumnID] <> '' then begin
                    ReservationEntry.Reset();
                    ReservationEntry.SetRange("Source ID", AssemblyHeader."No.");
                    ReservationEntry.SetRange("Serial No.", LineTrackingRM[ColumnId]);
                    ReservationEntry.SetRange("Item No.", LineItemNoCaption[ColumnID]);
                    ReservationEntry.SetRange("RM Alloted", true);
                    if ReservationEntry.FindFirst() then begin
                        ReservationEntry."RM Alloted" := false;
                        ReservationEntry.Modify(true);
                    end;
                    rFGRMMapping.reset;
                    rFGRMMapping.SetRange("Source ID", AssemblyHeader."No.");
                    rFGRMMapping.SetRange("Source Line No.", LineTrackingRM_LineNO[ColumnId]);
                    rFGRMMapping.SetRange("RM Item No.", LineItemNoCaption[ColumnId]);
                    rFGRMMapping.SetRange("RM Tracking Code", LineTrackingRM[ColumnId]);
                    if rFGRMMapping.FindFirst() then
                        rFGRMMapping.Delete();
                end;
                FGRMTrackingMapping.Reset();
                FGRMTrackingMapping.SetRange("Source Type", FGRMTrackingMapping."Source Type"::"Assembly Order");
                FGRMTrackingMapping.SetRange("Source ID", AssemblyHeader."No.");
                FGRMTrackingMapping.SetRange("RM Tracking Code", rReservationEntry."Serial No.");
                FGRMTrackingMapping.SetRange("RM Item No.", LineItemNoCaption[ColumnID]);
                if not FGRMTrackingMapping.FindFirst() then begin
                    FGRMTrackingMapping.Init();
                    FGRMTrackingMapping."Source Type" := FGRMTrackingMapping."Source Type"::"Assembly Order";
                    FGRMTrackingMapping."Source ID" := AssemblyHeader."No.";
                    FGRMTrackingMapping."FG Item No." := AssemblyHeader."Item No.";
                    FGRMTrackingMapping."FG Tracking Code" := Rec."Serial No.";
                    FGRMTrackingMapping."RM Item No." := LineItemNoCaption[ColumnID];
                    FGRMTrackingMapping."RM Tracking Code" := rReservationEntry."Serial No.";
                    FGRMTrackingMapping."Source Line No." := LineTrackingRM_LineNO[ColumnID];
                    FGRMTrackingMapping.Insert(true);
                end else begin
                    RecResveEntry.Reset();
                    RecResveEntry.SetRange("Item No.", LineItemNoCaption[ColumnID]);
                    RecResveEntry.SetRange("Serial No.", FGRMTrackingMapping."RM Tracking Code");
                    RecResveEntry.SetRange("RM Alloted", true);
                    if RecResveEntry.FindFirst() then begin
                        RecResveEntry."RM Alloted" := false;
                        RecResveEntry.Modify();
                    end;

                    FGRMTrackingMapping."RM Item No." := LineItemNoCaption[ColumnID];
                    FGRMTrackingMapping."RM Tracking Code" := rReservationEntry."Serial No.";
                    FGRMTrackingMapping.Modify(true);
                end;
                rReservationEntry."RM Alloted" := true;
                rReservationEntry.Modify();
            end;
        end else begin
            Error('Reservation Not Found!');
        end;
        CurrPage.Update();
    end;


    local procedure Matrix_Fill(ColumnID: Integer)
    var
        FGRMTrackingMapping: Record "FG RM Item Tracking Mapping";
        IntColID: Integer;
    begin
        FGRMTrackingMapping.Reset();
        FGRMTrackingMapping.SetRange("Source Type", FGRMTrackingMapping."Source Type"::"Assembly Order");
        FGRMTrackingMapping.SetRange("Source ID", AssemblyHeader."No.");
        FGRMTrackingMapping.SetRange("FG Tracking Code", Rec."Serial No.");
        FGRMTrackingMapping.SetRange("RM Item No.", LineItemNoCaption[ColumnID]);
        FGRMTrackingMapping.SetRange("Source Line No.", LineTrackingRM_LineNO[ColumnID]);
        if FGRMTrackingMapping.FindFirst() then begin
            LineTrackingRM_LineNO[ColumnID] := FGRMTrackingMapping."Source Line No.";
        end;
        LineTrackingRM[ColumnID] := FGRMTrackingMapping."RM Tracking Code";
        xLineTrackingRM[ColumnID] := FGRMTrackingMapping."RM Tracking Code";
    end;

    local procedure OnValidateSerial(ColumnId: Integer)
    var
        ReservationEntry: Record "Reservation Entry";
        rFGRMMapping: Record "FG RM Item Tracking Mapping";
    begin
        if LineTrackingRM[ColumnId] = '' then begin
            ReservationEntry.Reset();
            ReservationEntry.SetRange("Source ID", AssemblyHeader."No.");
            ReservationEntry.SetRange("Serial No.", xLineTrackingRM[ColumnId]);
            ReservationEntry.SetRange("RM Alloted", true);
            ReservationEntry.SetRange("Item No.", LineItemNoCaption[ColumnId]);
            if ReservationEntry.FindFirst() then begin
                ReservationEntry."RM Alloted" := false;
                ReservationEntry.Modify(true);
            end;
            rFGRMMapping.reset;
            rFGRMMapping.SetRange("Source ID", AssemblyHeader."No.");
            rFGRMMapping.SetRange("Source Line No.", LineTrackingRM_LineNO[ColumnId]);
            rFGRMMapping.SetRange("RM Item No.", LineItemNoCaption[ColumnId]);
            rFGRMMapping.SetRange("RM Tracking Code", xLineTrackingRM[ColumnId]);
            if rFGRMMapping.FindFirst() then
                rFGRMMapping.Delete();
        end;
    end;
}