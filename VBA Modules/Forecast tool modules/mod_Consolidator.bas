Attribute VB_Name = "mod_Consolidator"
Option Explicit

Function Activate_Consolidater()
    Call Application_Event_Handler(False)
    wks_SUmmary.Activate
    Call Consolidator_Global
    Call Monthly_Click
    Call Application_Event_Handler(True)
End Function

Function Drop_Down_Consolidator()
    Call Application_Event_Handler(False)
    Call Consolidator_Global
    Call Application_Event_Handler(True)
End Function

Function Consolidator_Global()
    Dim strScenario As String
    Dim strParameter As String
    Dim intLoop As Integer
    
    strScenario = Choose(wks_Vars.Range("BS1").Value, "Base", "Low", "High")
    strParameter = Choose(wks_Vars.Range("BT1").Value, "Patients", "Units", "Gross Revenue", "Net Revenue")

    With wks_SUmmary
        'SUMIF ROWS
        .Range("G2").Formula = "=""Q""&CHOOSE(MONTH(G6),0,0,1,0,0,2,0,0,3,0,0,4)&"" ""&YEAR(G6)"
        .Range("G2").Copy
        With .Range("G2:RR2")
            .PasteSpecial xlPasteAll
            .Calculate
            .Value = .Value
        End With
        .Range("G3").Formula = "=""Q""&CHOOSE(MONTH(G6),1,1,1,2,2,2,3,3,3,4,4,4)&"" ""&YEAR(G6)"
        .Range("G3").Copy
        With .Range("G3:RR3")
            .PasteSpecial xlPasteAll
            .Calculate
            .Value = .Value
        End With
        .Range("G4").Formula = "=IF(MONTH(G6)=12,0,YEAR(G6))"
        .Range("G4").Copy
        With .Range("G4:RR4")
            .PasteSpecial xlPasteAll
            .Calculate
            .Value = .Value
        End With
        .Range("G5").Formula = "=YEAR(G6)"
        .Range("G5").Copy
        With .Range("G5:RR5")
            .PasteSpecial xlPasteAll
            .Calculate
            .Value = .Value
        End With
        'MONTHLY
        .Range("G9").Formula = "=SUM(G10:G29)"
        .Range("G9").Copy
        .Range("G9:" & wks_Vars.Range("J8").Value & 9).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        
        .Range("G10").Formula = "=SUMIFS(OutputData!G:G,OutputData!$C:$C,""" & strScenario & """,OutputData!$B:$B,$F10,OutputData!$D:$D,""" & strParameter & """)"
        .Range("G10").Copy
        .Range("G10:" & wks_Vars.Range("J8").Value & 29).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        .Range("G10:" & wks_Vars.Range("J8").Value & 29).Calculate
        .Range("G10:" & wks_Vars.Range("J8").Value & 29).Copy
        .Range("G10").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'YEARLY
        .Range("RT9").Formula = "=SUM(RT10:RT29)"
        If wks_Vars.Range("BT1").Value = 1 Then
            .Range("RT10").Formula = "=SUMIF($G$4:$RR$4,RT$6,$G10:$RR10)"
        Else
            .Range("RT10").Formula = "=SUMIF($G$5:$RR$5,RT$6,$G10:$RR10)"
        End If
        
        .Range("RT9").Copy
        .Range("RT9:TG9").PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        .Range("RT10").Copy
        .Range("RT10:TG29").PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        .Range("RT9:TG29").Calculate
        .Range("RT9:TG29").Copy
        .Range("RT9").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'QUARTERLY
        .Range("TI9").Formula = "=SUM(TI10:TI29)"
        If wks_Vars.Range("BT1").Value = 1 Then
            .Range("TI10").Formula = "=SUMIF($G$2:$RR$2,TI$6,$G10:$RR10)"
        Else
            .Range("TI10").Formula = "=SUMIF($G$3:$RR$3,TI$6,$G10:$RR10)"
        End If
        
        .Range("TI9").Copy
        .Range("TI9:ZL9").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        .Range("TI10").Copy
        .Range("TI10:ZL29").PasteSpecial xlPasteFormulas
        Application.CutCopyMode = False
        .Range("TI10:ZL29").Calculate
        .Range("TI10:ZL29").Copy
        .Range("TI10").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        For intLoop = 10 To 29
            With .Range("F" & intLoop)
                If .Value = 0 Or .Value = "" Then
                    .EntireRow.Hidden = True
                Else
                    .EntireRow.Hidden = False
                End If
            End With
        Next intLoop
        
        If wks_Vars.Range("BT1").Value = 3 Then
            wks_SUmmary.Range("G9:RR29").NumberFormat = "$#,##0.00"
            wks_SUmmary.Range("RT9:TG29").NumberFormat = "$#,##0.00"
            wks_SUmmary.Range("TI9:ZL29").NumberFormat = "$#,##0.00"
        ElseIf wks_Vars.Range("BT2").Value = 4 Then
            wks_SUmmary.Range("G9:RR29").NumberFormat = "$#,##0.00"
            wks_SUmmary.Range("RT9:TG29").NumberFormat = "$#,##0.00"
            wks_SUmmary.Range("TI9:ZL29").NumberFormat = "$#,##0.00"
        End If
        
        .Range("G8").Select
    End With
End Function

Function Monthly_Click()
    With wks_SUmmary
        .Range("G1:ZL1").EntireColumn.Hidden = True
        .Range("G1:" & wks_Vars.Range("J8").Value & "1").EntireColumn.Hidden = False
    End With
    Call Change_Color_Consolidator(1)
End Function

Function Quarterly_Click()
    With wks_SUmmary
        .Range("G1:ZL1").EntireColumn.Hidden = True
        .Range("TI1:" & wks_Vars.Range("J27").Value).EntireColumn.Hidden = False
    End With
    Call Change_Color_Consolidator(2)
End Function

Function Yearly_Click()
    With wks_SUmmary
        .Range("G1:ZL1").EntireColumn.Hidden = True
        .Range("RT1:" & wks_Vars.Range("J24").Value).EntireColumn.Hidden = False
    End With
    Call Change_Color_Consolidator(3)
End Function

Function Change_Color_Consolidator(intShape As Integer)
    With wks_SUmmary
        If intShape = 1 Then
            .Shapes("shp_Monthly").Fill.ForeColor.RGB = RGB(127, 127, 127)
        Else
            .Shapes("shp_Monthly").Fill.ForeColor.RGB = RGB(79, 129, 189)
        End If
        If intShape = 2 Then
            .Shapes("shp_Quarterly").Fill.ForeColor.RGB = RGB(127, 127, 127)
        Else
            .Shapes("shp_Quarterly").Fill.ForeColor.RGB = RGB(79, 129, 189)
        End If
        If intShape = 3 Then
            .Shapes("shp_Yearly").Fill.ForeColor.RGB = RGB(127, 127, 127)
        Else
            .Shapes("shp_Yearly").Fill.ForeColor.RGB = RGB(79, 129, 189)
        End If
    End With
End Function
