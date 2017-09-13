Attribute VB_Name = "mod_Forecast_Create"
Option Explicit

Function Application_Event_Handler(blnFlag As Boolean)
    Application.ScreenUpdating = blnFlag
    Application.EnableEvents = False
    Application.DisplayAlerts = blnFlag
On Error Resume Next
    If blnFlag = False Then
        Application.Calculation = xlCalculationManual
    Else
        Application.Calculation = xlCalculationAutomatic
    End If
End Function

Function Create_Forecast_Generic()
    frm_Create_Forecast.Show
End Function

Function Create_Forecast_Generic_Edit()
    frm_Edit_Forecast.Show
End Function

Function Set_All_Sheets()
    wks_Vars.Calculate
    wks_S.Calculate
    
    Call Copy_Paste_Formula_Format
    
    Call Segment_Names
    Call Segment_DropDown_Fill
    Call Product_Names
    Call New_EPI_Sheet
    
    wks_ForecastFlow.Calculate
    wks_Vars.Calculate
    Call Create_Forecast_Flow
    Call Create_Shares_Table
    Call ProductShares_Segment_Change_1
    
    wks_Ranges.Range("I2:RY2").Copy
    wks_EPI_Data.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("I4:SA4").Copy
    wks_Historical_Data.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("I6:SA6").Copy
    wks_Conversion_Data.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("J8:IT8").Copy
    wks_Shares.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("J18:S18").Copy
    wks_SOB.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("I10:SA10").Copy
    wks_Output.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("J12:V12").Copy
    wks_Events.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("J14:R14").Copy
    wks_AdvancedPricing.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
    
    wks_Ranges.Range("J16:M16").Copy
    wks_MasterList.Range("A1").PasteSpecial xlPasteAll
    Application.CutCopyMode = False
End Function

Function Set_All_Sheets_Edit()
    wks_Vars.Calculate
    wks_S.Calculate
    
    Call Copy_Paste_Formula_Format
    
    Call Segment_Names
    Call Segment_DropDown_Fill
    Call Product_Names
    Call New_EPI_Sheet
    
    wks_ForecastFlow.Calculate
    wks_Vars.Calculate
    Call Create_Forecast_Flow
    Call Create_Shares_Table
End Function

Function Create_Forecast_Flow()
    Dim intInline As Double
    Dim intPipeline As Double
    Dim intLoop As Double
    Dim intSegment As Double, intRow As Double
    Dim intL1 As Double
    
    intInline = wks_Vars.Range("M1").Value
    intPipeline = wks_Vars.Range("R1").Value
    wks_ForecastFlow.Range("A1001:A5259").EntireRow.Hidden = False
    
    If intInline = 0 Then
        Call Hide_Inline_Shapes
        wks_ForecastFlow.Range("A1001:A1611").EntireRow.Hidden = True
        wks_ForecastFlow.Range("A2966:A3057").EntireRow.Hidden = True
    Else
        Call Show_Inline_Shapes
        wks_ForecastFlow.Range("A1001:A1611").EntireRow.Hidden = False
        wks_ForecastFlow.Range("A2966:A3057").EntireRow.Hidden = False
    End If
    
    With wks_ForecastFlow
        .Range("A1368:A1387").EntireRow.Hidden = True
        .Range("A1480:A1499").EntireRow.Hidden = True
        .Range("A1592:A1611").EntireRow.Hidden = True
        ''HISTORICAL DATA
        If intInline <> 0 Then
            intRow = wks_Vars.Range("EB2").Value
            If intInline > 0 Then Call HistoricalDataAvailableFor_1
            ''PRODUCT SPLIT
                intRow = wks_Vars.Range("EB2").Value + 88
                For intLoop = 1 To 15
                    If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                        .Range("A" & intRow - 1 & ":A" & intRow + 4).EntireRow.Hidden = True
                    Else
                        If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                    End If
                    intRow = intRow + 6
                Next intLoop
            ''PRODUCT UNITS
                intRow = wks_Vars.Range("EB2").Value + 180
                For intLoop = 1 To 15
                    If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                        .Range("A" & intRow - 1 & ":A" & intRow + 4).EntireRow.Hidden = True
                    Else
                        If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                    End If
                    intRow = intRow + 6
                Next intLoop
            ''TRENDED DATA
                intRow = wks_Vars.Range("EB3").Value
                For intLoop = 1 To 15
                    If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                        .Range("A" & intRow - 1 & ":A" & intRow + 4).EntireRow.Hidden = True
                    Else
                        If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                    End If
                    intRow = intRow + 6
                Next intLoop
            ''Modification Factor
                intRow = wks_Vars.Range("EB4").Value
                For intLoop = 1 To 15
                    If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                        .Range("A" & intRow - 1 & ":A" & intRow + 4).EntireRow.Hidden = True
                    Else
                        If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                    End If
                    intRow = intRow + 6
                Next intLoop
            ''Revised Trending
                intRow = wks_Vars.Range("EB4").Value + 112
                For intLoop = 1 To 15
                    If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                        .Range("A" & intRow - 1 & ":A" & intRow + 4).EntireRow.Hidden = True
                    Else
                        If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                    End If
                    intRow = intRow + 6
                Next intLoop
        End If
        ''CONVERSION PARAMETERS
        ''Compliance
        intRow = wks_Vars.Range("EB12").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''DOSING
        intRow = wks_Vars.Range("EB13").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''DOT
        intRow = wks_Vars.Range("EB14").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
           End If
                intRow = intRow + 11
        Next intLoop
        ''Advanced Pricing
        intRow = wks_Vars.Range("EB20").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''Price
        intRow = wks_Vars.Range("EB15").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''Market Access
        intRow = wks_Vars.Range("EB16").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''GTN
        intRow = wks_Vars.Range("EB17").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''Place Holder
        intRow = wks_Vars.Range("EB18").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''PATIENTS
        If intInline <> 0 Then
            intRow = wks_Vars.Range("EB21").Value - 98
            For intLoop = 1 To 15
                If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                    .Range("A" & intRow - 1 & ":A" & intRow + 4).EntireRow.Hidden = True
                Else
                    If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                End If
                intRow = intRow + 6
            Next intLoop
        End If
        ''Product Shares
        intRow = wks_Vars.Range("EB21").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 2 & ":A" & intRow + 31).EntireRow.Hidden = True
                intRow = intRow + 34
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
                intRow = intRow + 11
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
                intRow = intRow + 11
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
                intRow = intRow + 12
            End If
        Next intLoop
        ''EVENTS
        intRow = wks_Vars.Range("EB23").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 2 & ":A" & intRow + 31).EntireRow.Hidden = True
                intRow = intRow + 34
            Else
                If intInline < 5 Then .Range("A" & intRow + 22 + intInline & ":A" & intRow + 26).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 27 + intPipeline & ":A" & intRow + 31).EntireRow.Hidden = True
                intRow = intRow + 34
            End If
        Next intLoop
        ''OUTPUT Patients
        intRow = wks_Vars.Range("EB6").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
            intRow = intRow + 11
        Next intLoop
        ''Units
        intRow = wks_Vars.Range("EB7").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''Gross Revenue
        intRow = wks_Vars.Range("EB8").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''Net Revenue
        intRow = wks_Vars.Range("EB9").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''Probability Adjustment
        intRow = wks_Vars.Range("EB19").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
                intRow = intRow + 11
        Next intLoop
        ''PAGR
        intRow = wks_Vars.Range("EB10").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
            intRow = intRow + 11
        Next intLoop
        ''PANR
        intRow = wks_Vars.Range("EB11").Value
        For intLoop = 1 To 15
            If .Range("E" & intRow - 1).Value = 0 Or .Range("E" & intRow - 1).Value = "" Then
                .Range("A" & intRow - 1 & ":A" & intRow + 9).EntireRow.Hidden = True
            Else
                If intInline < 5 Then .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
                If intPipeline < 5 Then .Range("A" & intRow + 5 + intPipeline & ":A" & intRow + 9).EntireRow.Hidden = True
            End If
            intRow = intRow + 11
        Next intLoop
    End With
End Function

Function Copy_Paste_Formula_Format()
    Dim intLoop As Integer
    Dim intRow As Integer
        
    'CLEAR FIRST
    wks_Vars.Calculate
    With wks_ForecastFlow
        .Range("O6:RR5259").Clear
        .Range("I1028:N1046").Clear
        
        'YEARLY or MONTHLY Forecast
        If wks_Vars.Range("I2").Value Then
            .Range("H6:N6").Formula = "=DATE(YEAR(G6),MONTH(G6)+1,1)"
            .Range("G6:N6").NumberFormat = "MMM YYYY"
            
            .Range("G1042:K1046").Formula = "=G1035-G1020"
        Else
            .Range("H6:N6").Formula = "=DATE(YEAR(G6),MONTH(G6)+12,1)"
            .Range("G6:N6").NumberFormat = "YYYY"
            
            .Range("G1042:K1046").Formula = "=G1029-G1020"
        End If

        Call Copy_Paste_Ranges(6, 8, wks_Vars.Range("J6").Value)
        
        Call Copy_Paste_Ranges(1001, 1001, wks_Vars.Range("J6").Value)
        
        Call Copy_Paste_Ranges(1004, 1024, wks_Vars.Range("J7").Value)
        
        Call Copy_Paste_Ranges(1035, 1274, wks_Vars.Range("J7").Value)
        
        Call Copy_Paste_Ranges(1276, 3056, wks_Vars.Range("J6").Value)
        
        'CLEAR SOURCE OF BUSINESS TABLES
        intRow = wks_Vars.Range("EB22").Value - 1
        For intLoop = 1 To 15
            wks_ForecastFlow.Range("M" & intRow & ":RR" & intRow + 10).Clear
            intRow = intRow + 34
        Next intLoop
        
        Call Copy_Paste_Ranges(3058, 5259, wks_Vars.Range("J6").Value)
        
        'ANALYST REPORT
        wks_Vars.Range("BO1").Value = 1
        Call Analyst_Report_Formatting
    End With
End Function

Function HistoricalDataAvailableFor()
    Call Application_Event_Handler(False)
    Call HistoricalDataAvailableFor_1
    wks_ForecastFlow.Range("G1002").Select
    Call Application_Event_Handler(True)
End Function

Function HistoricalDataAvailableFor_1()
    Dim intInline As Integer, intRow As Integer, intLoop As Integer
    Dim intDose As Integer, intDoT As Integer, intComp As Integer, intPrice As Integer, intPatient As Integer
    Dim strFormula As String
    intInline = wks_Vars.Range("M1").Value
    intRow = wks_Vars.Range("EB2").Value
    
    With wks_ForecastFlow
        If .Range("A1002").Value = 1 Then
            .Range("A1005:A1024").EntireRow.Hidden = True
            .Range("A1049:A1068").EntireRow.Hidden = True
            .Range("A1071:A1090").EntireRow.Hidden = True
            
            .Range("A1005").EntireRow.Hidden = False
            .Range("A1006:A" & 1005 + intInline).EntireRow.Hidden = False
            
            .Range("A1049").EntireRow.Hidden = False
            .Range("A1050:A" & 1049 + intInline).EntireRow.Hidden = False
            
            .Range("A1071").EntireRow.Hidden = False
            .Range("A1072:A" & 1071 + intInline).EntireRow.Hidden = False
            
            .Range("A1029:A1033").EntireRow.Hidden = True
            .Range("A1035:A1039").EntireRow.Hidden = True
            .Range("A1042:A1046").EntireRow.Hidden = True
            .Range("A1029:A" & 1028 + intInline).EntireRow.Hidden = False
            If wks_Vars.Range("I2").Value Then .Range("A1035:A" & 1034 + intInline).EntireRow.Hidden = False
            .Range("A1042:A" & 1041 + intInline).EntireRow.Hidden = False
        ElseIf .Range("A1002").Value = 2 Then
            .Range("A1005:A1024").EntireRow.Hidden = True
            .Range("A1049:A1068").EntireRow.Hidden = True
            .Range("A1071:A1090").EntireRow.Hidden = True
            
            .Range("A1012").EntireRow.Hidden = False
            .Range("A1013:A" & 1012 + intInline).EntireRow.Hidden = False
            
            .Range("A1056").EntireRow.Hidden = False
            .Range("A1057:A" & 1056 + intInline).EntireRow.Hidden = False
            
            .Range("A1078").EntireRow.Hidden = False
            .Range("A1079:A" & 1078 + intInline).EntireRow.Hidden = False
            
            .Range("A1029:A1033").EntireRow.Hidden = True
            .Range("A1035:A1039").EntireRow.Hidden = True
            .Range("A1042:A1046").EntireRow.Hidden = True
            .Range("A1029:A" & 1028 + intInline).EntireRow.Hidden = False
            If wks_Vars.Range("I2").Value Then .Range("A1035:A" & 1034 + intInline).EntireRow.Hidden = False
            .Range("A1042:A" & 1041 + intInline).EntireRow.Hidden = False
        ElseIf .Range("A1002").Value = 3 Then
            .Range("A1005:A1024").EntireRow.Hidden = True
            .Range("A1049:A1068").EntireRow.Hidden = True
            .Range("A1071:A1090").EntireRow.Hidden = True
            
            .Range("A1019").EntireRow.Hidden = False
            .Range("A1020:A" & 1019 + intInline).EntireRow.Hidden = False
            
            .Range("A1063").EntireRow.Hidden = False
            .Range("A1064:A" & 1063 + intInline).EntireRow.Hidden = False
            
            .Range("A1085").EntireRow.Hidden = False
            .Range("A1086:A" & 1085 + intInline).EntireRow.Hidden = False
            
            .Range("A1029:A1033").EntireRow.Hidden = True
            .Range("A1035:A1039").EntireRow.Hidden = True
            .Range("A1042:A1046").EntireRow.Hidden = True
            .Range("A1029:A" & 1028 + intInline).EntireRow.Hidden = False
            If wks_Vars.Range("I2").Value Then .Range("A1035:A" & 1034 + intInline).EntireRow.Hidden = False
            .Range("A1042:A" & 1041 + intInline).EntireRow.Hidden = False
        Else
            .Range("A1005:A1024").EntireRow.Hidden = False
            .Range("A1049:A1068").EntireRow.Hidden = False
            .Range("A1071:A1090").EntireRow.Hidden = False
            .Range("A" & intRow + intInline & ":A" & intRow + 4).EntireRow.Hidden = True
            .Range("A" & intRow + 7 + intInline & ":A" & intRow + 11).EntireRow.Hidden = True
            .Range("A" & intRow + 14 + intInline & ":A" & intRow + 18).EntireRow.Hidden = True
            .Range("A" & intRow + 23 + intInline & ":A" & intRow + 27).EntireRow.Hidden = True
            If wks_Vars.Range("I2").Value Then
                .Range("A" & intRow + 29 + intInline & ":A" & intRow + 33).EntireRow.Hidden = True
            Else
                .Range("A" & intRow + 29 & ":A" & intRow + 33).EntireRow.Hidden = True
            End If
            .Range("A" & intRow + 36 + intInline & ":A" & intRow + 40).EntireRow.Hidden = True
            ''Modification Factor
            .Range("A" & intRow + 44 + intInline & ":A" & intRow + 48).EntireRow.Hidden = True
            .Range("A" & intRow + 51 + intInline & ":A" & intRow + 55).EntireRow.Hidden = True
            .Range("A" & intRow + 58 + intInline & ":A" & intRow + 62).EntireRow.Hidden = True
            ''Modified Data
            .Range("A" & intRow + 66 + intInline & ":A" & intRow + 70).EntireRow.Hidden = True
            .Range("A" & intRow + 73 + intInline & ":A" & intRow + 77).EntireRow.Hidden = True
            .Range("A" & intRow + 80 + intInline & ":A" & intRow + 84).EntireRow.Hidden = True
        End If
        intRow = 2968
        intPatient = 1502
        intComp = 1618
        intDose = 1787
        intDoT = 1956
        intPrice = 2294
        For intLoop = 1 To 15
            If .Range("A1002").Value = 1 Or .Range("A1002").Value = 4 Then
                strFormula = "=IFERROR(G" & intPatient & "/(G" & intComp & "*G" & intDose & "*G" & intDoT & "),0)"
            ElseIf .Range("A1002").Value = 2 Then
                strFormula = "=G" & intPatient
            ElseIf .Range("A1002").Value = 3 Then
                strFormula = "=IFERROR(G" & intPatient & "/(G" & intComp & "*G" & intDose & "*G" & intDoT & "*G" & intPrice & "),0)"
            End If
            .Range("G" & intRow & ":G" & intRow + 4).Formula = strFormula
            .Range("G" & intRow & ":G" & intRow + 4).Copy
            .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
            
            intRow = intRow + 6
            intPatient = intPatient + 6
            intComp = intComp + 11
            intDose = intDose + 11
            intDoT = intDoT + 11
            intPrice = intPrice + 11
        Next intLoop
    End With
End Function

Function Analyst_Report_Formatting()
    wks_Vars.Calculate
    With wks_ForecastFlow
        .Range("I1028:RR1046").Clear
        If wks_Vars.Range("BO1").Value = 1 Then
            .Range("G1028").Formula = "=Vars!C2"
            .Range("H1028").Formula = "=G1028+1"
            .Range("A1034:A1039").EntireRow.Hidden = False
            .Range("G1028:H1028").NumberFormat = "General"
            
            .Range("H1028:H1033").Copy
            .Range("H1028:" & wks_Vars.Range("J19").Value & 1033).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
            
            .Range("H1035:H1046").Copy
            .Range("H1035:" & wks_Vars.Range("J9").Value & 1046).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
        ElseIf wks_Vars.Range("BO1").Value = 2 Then
            .Range("G1028").Formula = "=""Q1 "" & Vars!C2"
            .Range("H1028").Formula = "=IF(MID(G1028,2,1)=""4"",""Q1 ""&VALUE(RIGHT(G1028,4))+1,""Q""&VALUE(MID(G1028,2,1))+1&"" ""&RIGHT(G1028,4))"
            .Range("A1034:A1039").EntireRow.Hidden = False
            .Range("G1028:H1028").NumberFormat = "General"
            
            .Range("H1028:H1033").Copy
            .Range("H1028:" & wks_Vars.Range("J20").Value & 1033).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
            
            .Range("H1035:H1046").Copy
            .Range("H1035:" & wks_Vars.Range("J9").Value & 1046).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
        ElseIf wks_Vars.Range("BO1").Value = 3 Then
            .Range("G1028").Formula = "=G6"
            .Range("H1028").Formula = "=H6"
            .Range("A1034:A1039").EntireRow.Hidden = True
            .Range("G1028:H1028").NumberFormat = "MMM-YYYY"
            
            .Range("H1028:H1033").Copy
            .Range("H1028:" & wks_Vars.Range("J21").Value & 1033).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
            
            .Range("H1035:H1046").Copy
            .Range("H1035:" & wks_Vars.Range("J9").Value & 1046).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
        End If
''        .Range("G1028").Select
    End With
End Function

Function Analyst_Report_Refresh()
Call Application_Event_Handler(False)
    With wks_ForecastFlow
        If wks_Vars.Range("BO1").Value = 1 Then
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1035).FormulaArray = "=Interpolate_Data(G1029:" & wks_Vars.Range("J19").Value & "1029,12)"
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1035).Copy
            .Range("G1036:" & wks_Vars.Range("J9").Value & 1039).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
            .Calculate
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1039).Copy
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1039).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
        ElseIf wks_Vars.Range("BO1").Value = 2 Then
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1035).FormulaArray = "=Interpolate_Data(G1029:" & wks_Vars.Range("J20").Value & "1029,3)"
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1035).Copy
            .Range("G1036:" & wks_Vars.Range("J9").Value & 1039).PasteSpecial xlPasteAll
            Application.CutCopyMode = False
            .Calculate
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1039).Copy
            .Range("G1035:" & wks_Vars.Range("J9").Value & 1039).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
        End If
        .Range("G1028").Select
    End With
Call Application_Event_Handler(True)
End Function

Function Copy_Paste_Ranges(intFrom As Integer, intTo As Integer, intColumn As Integer)
    With wks_ForecastFlow
        .Range("N" & intFrom & ":N" & intTo).Copy
        .Range(.Cells(intFrom, 15), .Cells(intTo, intColumn)).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
    End With
End Function

Function Create_Shares_Table()
    Dim intLoop As Integer
    Dim intRow As Integer
    Dim strRange As String
''    'CLEAR TABLES
''    intRow = 3065
''    For intLoop = 1 To 15
''        wks_ForecastFlow.Range("M" & intRow & ":RR" & intRow + 10).Clear
''        intRow = intRow + 34
''    Next intLoop
    
    If frm_Create_Forecast.lbl_3.Caption = "P" Or frm_Create_Forecast.lbl_5.Caption = "P" Or frm_Create_Forecast.lbl_6.Caption = "P" Then
        
        If frm_Create_Forecast.lbl_3.Caption = "P" Then
            wks_Vars.Range("CL1").Value = "Peak Shares"
            strRange = "CL1:CQ11"
        ElseIf frm_Create_Forecast.lbl_5.Caption = "P" Then
            wks_Vars.Range("CS1").Value = "Peak Shares"
            strRange = "CS1:CX11"
        ElseIf frm_Create_Forecast.lbl_6.Caption = "P" Then
            wks_Vars.Range("CL1").Value = "Share Steal"
            strRange = "CL1:CQ11"
        End If
        
        With wks_ForecastFlow
            intRow = wks_Vars.Range("EB21").Value - 1
            For intLoop = 1 To 15
                wks_Vars.Range(strRange).Copy
                .Range("M" & intRow).PasteSpecial xlPasteAll
                Application.CutCopyMode = False
                intRow = intRow + 34
            Next intLoop
        End With
    End If
    
    If frm_Create_Forecast.lbl_4.Caption = "P" Then
        With wks_ForecastFlow
            intRow = wks_Vars.Range("EB21").Value - 1
            For intLoop = 1 To 15
                .Range("G" & intRow + 1 & ":K" & intRow + 5).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 34
            Next intLoop
        End With
    Else
        With wks_ForecastFlow
            intRow = wks_Vars.Range("EB21").Value - 1
            For intLoop = 1 To 15
                .Range("G" & intRow + 1 & ":K" & intRow + 5).Interior.Color = RGB(217, 217, 217)
                .Range("H" & intRow + 1 & ":H" & intRow + 5).Interior.Color = RGB(255, 255, 204)
                intRow = intRow + 34
            Next intLoop
        End With
    End If
    
End Function

Function Clear_All_Code()
Call Application_Event_Handler(False)
     Call Clear_All_Sheets
Call Application_Event_Handler(True)
End Function

Function Clear_All_Sheets()
    Dim intRow As Integer
    Dim intLoop As Integer
    With wks_ForecastFlow
        .Range("O6:RR5259").Clear
        .Range("A9:RR985").Clear
        .Range("G1006:N1024").ClearContents
        .Range("G1050:N1068").ClearContents
        .Range("G1094:N1182").ClearContents
        .Range("G1278:N1366").ClearContents
        .Range("G1390:N1478").ClearContents
        ''Conversion
        .Range("A1615").Value = 2
        .Range("G1618:N1781").ClearContents
        intRow = wks_Vars.Range("EB12").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A1784").Value = 2
        .Range("G1787:N1950").ClearContents
        intRow = wks_Vars.Range("EB13").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A1953").Value = 2
        .Range("G1956:N2119").ClearContents
        intRow = wks_Vars.Range("EB14").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A2122").Value = 2
        .Range("G2125:N2288").ClearContents
        intRow = wks_Vars.Range("EB20").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":J" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A2291").Value = 2
        .Range("G2294:N2457").ClearContents
        intRow = wks_Vars.Range("EB15").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A2460").Value = 2
        .Range("G2463:N2626").ClearContents
        intRow = wks_Vars.Range("EB16").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A2629").Value = 2
        .Range("G2632:N2795").ClearContents
        intRow = wks_Vars.Range("EB17").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        .Range("A2798").Value = 2
        .Range("G2801:N2964").ClearContents
        intRow = wks_Vars.Range("EB18").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        intRow = wks_Vars.Range("EB21").Value - 1
        For intLoop = 1 To 15
            wks_ForecastFlow.Range("M" & intRow & ":RR" & intRow + 10).Clear
            intRow = intRow + 34
        Next intLoop
        ''Product Shares
        .Range("A3059").Value = 2
        .Range("A3061").Value = 1
        intRow = wks_Vars.Range("EB21").Value
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).ClearContents
            .Range("G" & intRow & ":K" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
            .Range("G" & intRow & ":N" & intRow + 9).ClearContents
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 23
        Next intLoop
        ''Events
        intRow = 3579
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).ClearContents
            intRow = intRow + 34
        Next intLoop
        ''PrbAdjustment
        .Range("A4759").Value = 2
        .Range("G4762:N4925").ClearContents
        intRow = 4762
        For intLoop = 1 To 15
            .Range("G" & intRow & ":N" & intRow + 9).Interior.Color = RGB(255, 255, 204)
            intRow = intRow + 11
        Next intLoop
        ''Analyst
        .Range("I1028:N1033").Clear
        .Range("G1035:N1039").ClearContents
    End With
    With wks_Vars
        .Range("A2:I2").ClearContents
        .Range("L3:T7").ClearContents
        .Range("W:W").ClearContents
        .Range("V3").Value = 1
        .Range("M1").Value = 0
        .Range("R1").Value = 0
        .Range("AD2:AK11").ClearContents
        .Range("BK1").Value = 1
    End With
    wks_Project.Range("A2:J2").Clear
    wks_Products.Range("A2:E11").Clear
    wks_SegmentDetails.Range("B2:I8").Clear
    wks_Segments.Range("B2:B16").Clear
    wks_Indication.Range("A2:A500").Clear
    wks_MasterList.Cells.Clear
    wks_EPI_Data.Cells.Clear
    wks_Historical_Data.Cells.Clear
    wks_Conversion_Data.Cells.Clear
    wks_AdvancedPricing.Cells.Clear
    wks_Shares.Cells.Clear
    wks_SOB.Cells.Clear
    wks_Events.Cells.Clear
    wks_Output.Cells.Clear
    
End Function

Function HideRows_Range(intStart As Double, intEnd As Double)
    wks_ForecastFlow.Range("A" & intStart & ":A" & intEnd).EntireRow.Hidden = True
End Function

Function Drop_Down_Change()
Call Application_Event_Handler(False)
    'BACKUP DATA
    Call BackEndSaveData
    wks_Vars.Range("CB13").Value = wks_Vars.Range("CB16").Value
    wks_Vars.Range("CB14").Value = wks_Vars.Range("CB17").Value
    'REVERSE BACKUP
    If wks_Home.Range("O1").Value = 0 Then
        Call FrontEndSaveData
    End If
Call Application_Event_Handler(True)
End Function

Function Segment_DropDown_Fill()
    Dim intLoop As Integer
    wks_ForecastFlow.Shapes("drp_Segments").Visible = msoTrue
    With wks_ForecastFlow.Shapes("drp_Segments").ControlFormat
        .RemoveAllItems
        For intLoop = 2 To 16
            If wks_Vars.Range("AC" & intLoop).Value <> 0 Then
                .AddItem wks_Vars.Range("AC" & intLoop).Value
            End If
        Next intLoop
        .LinkedCell = "Vars!$AR$1"
        .DropDownLines = 15
    End With
    wks_ForecastFlow.Shapes("drp_Segments").Visible = msoFalse
End Function

Function Hide_Inline_Shapes()
    With wks_ForecastFlow
        .Shapes("Txt_DataAvailable").Visible = msoFalse
        .Shapes("Drp_DataAvailable").Visible = msoFalse
        .Shapes("Shp_Historical").Visible = msoFalse
        .Shapes("Drp_Hist_ARR").Visible = msoFalse
        .Shapes("Shp_Hist_ARR_Refresh").Visible = msoFalse
        .Shapes("Txt_Hist_Refresh").Visible = msoFalse
        .Shapes("Shp_Product_Units").Visible = msoFalse
        .Shapes("Shp_Trended_Data").Visible = msoFalse
        .Shapes("Txt_Trending").Visible = msoFalse
        .Shapes("shp_Patients").Visible = msoFalse
    End With
End Function

Function Show_Inline_Shapes()
    With wks_ForecastFlow
        .Shapes("Txt_DataAvailable").Visible = msoCTrue
        .Shapes("Drp_DataAvailable").Visible = msoCTrue
        .Shapes("Shp_Historical").Visible = msoCTrue
        If wks_Vars.Range("I2").Value Then
            .Shapes("Drp_Hist_ARR").Visible = msoCTrue
            .Shapes("Shp_Hist_ARR_Refresh").Visible = msoCTrue
            .Shapes("Txt_Hist_Refresh").Visible = msoCTrue
        Else
            .Shapes("Drp_Hist_ARR").Visible = msoFalse
            .Shapes("Shp_Hist_ARR_Refresh").Visible = msoFalse
            .Shapes("Txt_Hist_Refresh").Visible = msoFalse
        End If
        .Shapes("Shp_Product_Units").Visible = msoCTrue
        .Shapes("Shp_Trended_Data").Visible = msoCTrue
        .Shapes("Txt_Trending").Visible = msoCTrue
        .Shapes("shp_Patients").Visible = msoCTrue
    End With
End Function
