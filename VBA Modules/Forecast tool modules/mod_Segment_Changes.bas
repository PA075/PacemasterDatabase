Attribute VB_Name = "mod_Segment_Changes"
Option Explicit

Function Compliance_Segment_Change()
    Call Application_Event_Handler(False)
        Call Compliance_Segment_Change_1
    Call Application_Event_Handler(True)
End Function

Function Compliance_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB12").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB12").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB12").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB12").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB12").Value).Select
    End With
End Function
Function Dosing_Segment_Change()
    Call Application_Event_Handler(False)
        Call Dosing_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function Dosing_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB13").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB13").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB13").Value

                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB13").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB13").Value).Select
    End With
End Function
Function DoT_Segment_Change()
   Call Application_Event_Handler(False)
        Call DoT_Segment_Change_1
   Call Application_Event_Handler(True)
End Function
Function DoT_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB14").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB14").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB14").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB14").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB14").Value).Select
    End With
End Function
Function Price_Segment_Change()
    Call Application_Event_Handler(False)
        Call Price_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function Price_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB15").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB15").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB15").Value).Select
    End With
End Function
Function GTN_Segment_Change()
    Call Application_Event_Handler(False)
        Call GTN_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function GTN_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB17").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB17").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB17").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB17").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB17").Value).Select
    End With
End Function
Function Probability_Segment_Change()
    Call Application_Event_Handler(False)
        Probability_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function Probability_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB19").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB19").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB19").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB19").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB19").Value).Select
    End With
End Function
Function MarketAccess_Segment_Change()
    Call Application_Event_Handler(False)
        Call MarketAccess_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function MarketAccess_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB16").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB16").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB16").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB16").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB16").Value).Select
    End With
End Function
Function PlaceHolder_Segment_Change()
    Call Application_Event_Handler(False)
        Call PlaceHolder_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function PlaceHolder_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB18").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB18").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Formula = "=G" & wks_Vars.Range("EB18").Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB18").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB18").Value).Select
    End With
End Function
Function AdvancePricing_Segment_Change()
    Call Application_Event_Handler(False)
        Call AdvancePriceing_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function AdvancePriceing_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB20").Value + 11
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB20").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow).Formula = "=G" & wks_Vars.Range("EB20").Value

                .Range("G" & intRow).Copy
                .Range("G" & intRow & ":J" & intRow + 9).PasteSpecial xlPasteFormulas
                Application.CutCopyMode = False
                .Range("G" & intRow & ":J" & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 11
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB20").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":J" & intRow + 9).Value = .Range("G" & intRow & ":J" & intRow + 9).Value
                .Range("G" & intRow & ":J" & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 11
            Next intLoop
        End If
        On Error Resume Next
        .Range("G" & wks_Vars.Range("EB20").Value).Select
    End With
End Function
Function ProductShares_Segment_Change()
    Call Application_Event_Handler(False)
        Call ProductShares_Segment_Change_1
    Call Application_Event_Handler(True)
End Function
Function ProductShares_Segment_Change_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB21").Value + 34
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow).Formula = "=G" & wks_Vars.Range("EB21").Value
                .Range("G" & intRow).Copy
                .Range("G" & intRow & ":K" & intRow + 9).PasteSpecial xlPasteFormulas
                Application.CutCopyMode = False
                .Range("G" & intRow & ":K" & intRow + 9).Interior.Color = RGB(255, 255, 255)
                
                If wks_Vars.Range("H2").Value = 2 Or wks_Vars.Range("H2").Value = 4 Or wks_Vars.Range("H2").Value = 5 Then
                    .Range("N" & intRow).Formula = "=N" & wks_Vars.Range("EB21").Value
                    .Range("N" & intRow).Copy
                    .Range("N" & intRow & ":R" & intRow + 9).PasteSpecial xlPasteFormulas
                    Application.CutCopyMode = False
                End If
                
                intRow = intRow + 11
                .Range("G" & intRow).Formula = "=G" & wks_Vars.Range("EB21").Value + 11
                .Range("G" & intRow).Copy
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).PasteSpecial xlPasteFormulas
                Application.CutCopyMode = False
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 23
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":K" & intRow + 9).Value = .Range("G" & intRow & ":K" & intRow + 9).Value
                .Range("G" & intRow & ":K" & intRow + 9).Interior.Color = RGB(255, 255, 204)
                
                If wks_Vars.Range("H2").Value = 2 Or wks_Vars.Range("H2").Value = 4 Or wks_Vars.Range("H2").Value = 5 Then
                    .Range("N" & intRow & ":R" & intRow + 9).Value = .Range("N" & intRow & ":R" & intRow + 9).Value
                End If
                intRow = intRow + 11
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Value
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 23
            Next intLoop
        End If
        ''Calculation
        intRow = wks_Vars.Range("EB21").Value + 11
        If .Range("A" & wks_Vars.Range("EB21").Value - 5).Value = 1 Then
            .Shapes("grp_ProductShares").Visible = msoCTrue
            For intLoop = 1 To 15
               .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 255)
               intRow = intRow + 34
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB21").Value - 5).Value = 2 Then
            .Shapes("grp_ProductShares").Visible = msoFalse
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 34
            If .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 2 Then
                For intLoop = 1 To 14
                   .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Interior.Color = RGB(255, 255, 204)
                   intRow = intRow + 34
                Next intLoop
            End If
        End If
        On Error Resume Next
        .Range("C" & wks_Vars.Range("EB21").Value).Select
    End With
End Function
Function Events_Segment_Change()
    Call Application_Event_Handler(False)
    Call Events_Segment_Change1
    Call Application_Event_Handler(True)
End Function
Function Events_Segment_Change1()
    Dim intRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("EB23").Value + 34
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB23").Value - 3).Value = 1 Then
            For intLoop = 1 To 14
                .Range("G" & intRow).Formula = "=G" & wks_Vars.Range("EB23").Value
                .Range("G" & intRow).Copy
                .Range("G" & intRow & ":M" & intRow + 9).PasteSpecial xlPasteFormulas
                Application.CutCopyMode = False
                .Range("G" & intRow & ":M" & intRow + 9).Interior.Color = RGB(255, 255, 255)
                intRow = intRow + 34
            Next intLoop
        ElseIf .Range("A" & wks_Vars.Range("EB23").Value - 3).Value = 2 Then
            For intLoop = 1 To 14
                .Range("G" & intRow & ":M" & intRow + 9).Copy
                .Range("G" & intRow & ":M" & intRow + 9).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                .Range("G" & intRow & ":M" & intRow + 9).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 34
            Next intLoop
        End If
    End With
End Function

Function Advanced_Pricing_Refresh_Click()
    Call Application_Event_Handler(False)
    Call Advanced_Pricing_Refresh_Click_1
    Call Application_Event_Handler(True)
End Function

Function Advanced_Pricing_Refresh_Click_1()
    Dim intRow As Integer
    Dim intLoop As Integer
    Dim intCol As Integer
    Dim intLoop1 As Integer
    Dim intRow1 As Integer
    With wks_ForecastFlow
        If .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = "" Then
            .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = 2
            Call Price_Segment_Change_1
        End If
        If .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = 1 Then
            intRow = wks_Vars.Range("EB15").Value
            For intLoop = 1 To 10
                intCol = Match_Date_Price(intRow - 169)
                If intCol <> 0 Then
                    .Cells(intRow, intCol).FormulaR1C1 = "=IF(OR(R[-169]C7="""",R[-169]C7=0),0,IF(R6C[0]<R[-169]C7,0,IF(R6C[0]=R[-169]C7,R[-169]C8,(IF(OR(R[-169]C9="""",R[-169]C9=0),0,IF(MONTH(R6C[0])=MATCH(R[-169]C9,Vars!R2C55:R13C55,0),R[-169]C10,0))+1)*RC[-1])))"
                    .Cells(intRow, intCol).Copy
                    .Range(.Cells(intRow, intCol), .Cells(intRow, wks_Vars.Range("J6").Value)).PasteSpecial xlPasteFormulas
                    Application.CutCopyMode = False
                End If
                .Calculate
                intRow = intRow + 1
            Next intLoop
            
            intRow = wks_Vars.Range("EB15").Value
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Copy
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
       ElseIf .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = 2 Then
            intRow = wks_Vars.Range("EB15").Value
            For intLoop = 1 To 10
                intCol = Match_Date_Price(intRow - 169)
                If intCol <> 0 Then
                    .Cells(intRow, intCol).FormulaR1C1 = "=IF(OR(R[-169]C7="""",R[-169]C7=0),0,IF(R6C[0]<R[-169]C7,0,IF(R6C[0]=R[-169]C7,R[-169]C8,(IF(OR(R[-169]C9="""",R[-169]C9=0),0,IF(MONTH(R6C[0])=MATCH(R[-169]C9,Vars!R2C55:R13C55,0),R[-169]C10,0))+1)*RC[-1])))"
                    .Cells(intRow, intCol).Copy
                    .Range(.Cells(intRow, intCol), .Cells(intRow, wks_Vars.Range("J6").Value)).PasteSpecial xlPasteFormulas
                    Application.CutCopyMode = False
                End If
                intRow = intRow + 1
            Next intLoop
        
            intRow1 = wks_Vars.Range("EB15").Value + 11
            For intLoop1 = 1 To 14
                intRow = intRow1
                For intLoop = 1 To 10
                    intCol = Match_Date_Price(intRow - 169)
                    If intCol <> 0 Then
                        .Cells(intRow, intCol).FormulaR1C1 = "=IF(OR(R[-169]C7="""",R[-169]C7=0),0,IF(R6C[0]<R[-169]C7,0,IF(R6C[0]=R[-169]C7,R[-169]C8,(IF(OR(R[-169]C9="""",R[-169]C9=0),0,IF(MONTH(R6C[0])=MATCH(R[-169]C9,Vars!R2C55:R13C55,0),R[-169]C10,0))+1)*RC[-1])))"
                        .Cells(intRow, intCol).Copy
                        .Range(.Cells(intRow, intCol), .Cells(intRow, wks_Vars.Range("J6").Value)).PasteSpecial xlPasteFormulas
                        Application.CutCopyMode = False
                    End If
                    intRow = intRow + 1
                Next intLoop
                intRow1 = intRow1 + 11
            Next intLoop1
            .Calculate

            intRow = wks_Vars.Range("EB15").Value
            For intLoop = 1 To 15
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).Copy
                .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 9).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                intRow = intRow + 11
            Next intLoop
            On Error Resume Next
            .Range("G" & wks_Vars.Range("EB15").Value).Select
        End If
    End With

End Function

Function Match_Date_Price(intRow As Integer)
    On Error GoTo NotMatched
    wks_Vars.Range("AX1").Value = wks_ForecastFlow.Range("G" & intRow).Value
    wks_Vars.Calculate
    Match_Date_Price = wks_Vars.Range("AX2").Value
    If Match_Date_Price = 0 Then
        Match_Date_Price = 7
    Else
        Match_Date_Price = Match_Date_Price + 6
    End If
    Exit Function
NotMatched:
    Match_Date_Price = 7
End Function
