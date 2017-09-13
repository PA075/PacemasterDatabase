Attribute VB_Name = "mod_Consolidater"
Option Explicit

Function Activate_Consolidater()
    Dim intLoop As Integer, intStart As Integer, intEnd As Integer
    ''Application.Calculation = xlCalculationManual
    Call Application_Events_Handler(False)
'    wks_Forecast.Shapes("shp_PleaseWait").Visible = msoCTrue
    wks_Vars.Calculate
    wks_Vars.Range("Q34").Value = "Yes"
    Call Back_Data

    wks_Vars.Range("Q13").Value = 3
    Call Consolidater_HideUnhide
    Call Consolidator_Columns
    wks_Consolidator.Activate
    Call Application_Events_Handler(True)
End Function

Function ProductNames_SKU()
Call Application_Events_Handler(False)
    Dim intRow As Integer
    Dim intLoop As Integer, intSKU As Integer
    intRow = 15
    With wks_Consolidator
        For intLoop = 1 To 50
            Call All_Parameter_Values(intRow, 0, "=Master_List!B" & intLoop + 9, "=Master_List!D" & intLoop + 9)
            intRow = intRow + 1
            For intSKU = 1 To 10
                Call All_Parameter_Values(intRow, 1, "=SKU_InformationOld!" & wks_SKU_info.Cells(intSKU + 1, intLoop + 1).Address, "")
                intRow = intRow + 1
            Next intSKU
        Next intLoop
    End With
Call Application_Events_Handler(True)
End Function

Function All_Parameter_Values(intRow As Integer, intIndent As Integer, strValue As String, strType As String)
    With wks_Consolidator
        .Range("F" & intRow).Formula = strValue
        .Range("F" & intRow + 554).Formula = strValue
        .Range("F" & intRow + 1108).Formula = strValue
        .Range("F" & intRow + 1662).Formula = strValue
        .Range("F" & intRow + 2216).Formula = strValue
        .Range("F" & intRow + 2770).Formula = strValue
        .Range("F" & intRow + 3324).Formula = strValue
        .Range("F" & intRow + 3878).Formula = strValue
        
        If strType <> "" Then
            .Range("E" & intRow).Formula = strType
            .Range("E" & intRow + 554).Formula = strType
            .Range("E" & intRow + 1108).Formula = strType
            .Range("E" & intRow + 1662).Formula = strType
            .Range("E" & intRow + 2216).Formula = strType
            .Range("E" & intRow + 2770).Formula = strType
            .Range("E" & intRow + 3324).Formula = strType
            .Range("E" & intRow + 3878).Formula = strType
        End If
        
        .Range("F" & intRow).IndentLevel = intIndent
        .Range("F" & intRow + 554).IndentLevel = intIndent
        .Range("F" & intRow + 1108).IndentLevel = intIndent
        .Range("F" & intRow + 1662).IndentLevel = intIndent
        .Range("F" & intRow + 2216).IndentLevel = intIndent
        .Range("F" & intRow + 2770).IndentLevel = intIndent
        .Range("F" & intRow + 3324).IndentLevel = intIndent
        .Range("F" & intRow + 3878).IndentLevel = intIndent
        
        If intIndent = 0 Then
            .Range("F" & intRow).Font.Bold = True
            .Range("F" & intRow + 554).Font.Bold = True
            .Range("F" & intRow + 1108).Font.Bold = True
            .Range("F" & intRow + 1662).Font.Bold = True
            .Range("F" & intRow + 2216).Font.Bold = True
            .Range("F" & intRow + 2770).Font.Bold = True
            .Range("F" & intRow + 3324).Font.Bold = True
            .Range("F" & intRow + 3878).Font.Bold = True
        End If
    End With
End Function

Function Consolideter_Case()
Call Application_Events_Handler(False)
    Call Consolidater_HideUnhide
    Call Consolidator_Columns
Call Application_Events_Handler(True)
End Function

Function Consolideter_Period()
Call Application_Events_Handler(False)
    Call Consolidator_Columns
Call Application_Events_Handler(True)
End Function

Function Consolidator_Columns()
    With wks_Consolidator
        .Range("G1:ABF1").EntireColumn.Hidden = True
        If wks_Vars.Range("Q13").Value = 1 Then
            .Range("YA1:" & wks_Vars1.Range("O19").Value).EntireColumn.Hidden = False
            .Range("A13").Value = "CY"
        ElseIf wks_Vars.Range("Q13").Value = 2 Then
            .Range("AAA1:" & wks_Vars1.Range("O20").Value).EntireColumn.Hidden = False
            .Range("A13").Value = "FY"
        ElseIf wks_Vars.Range("Q13").Value = 3 Then
            .Range("G1:" & wks_Vars.Range("K4").Value & "1").EntireColumn.Hidden = False
            .Range("A13").Value = "Monthly"
        ElseIf wks_Vars.Range("Q13").Value = 4 Then
            .Range("SA1:" & wks_Vars1.Range("O18").Value).EntireColumn.Hidden = False
            .Range("A13").Value = "Quarterly"
        End If
    End With
End Function

Function Consolidater_HideUnhide()
    Dim intRow As Integer, intConsolidator As Integer, intHist As Integer
    Dim intLoop As Integer, intSKU As Integer, intLoop2 As Integer
     If wks_Vars.Range("Q17").Value = 1 Then
        intRow = 2
        intHist = 65
    ElseIf wks_Vars.Range("Q17").Value = 2 Then
        intRow = 18
        intHist = 144
    ElseIf wks_Vars.Range("Q17").Value = 3 Then
        intRow = 34
        intHist = 223
    ElseIf wks_Vars.Range("Q17").Value = 4 Then
        intRow = 50
        intHist = 302
    ElseIf wks_Vars.Range("Q17").Value = 5 Then
        intRow = 66
        intHist = 381
    End If
    
    With wks_Consolidator
        .Range("H15:ABF4444").Clear
        
        .Range("G15:G4444").Copy
        .Range("H15:NB4444").PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        
        .Range("G15:G4444").Copy
        .Range("SA15:WP4444").PasteSpecial xlPasteFormats
        Application.CutCopyMode = False
        
        .Range("G15:G4444").Copy
        .Range("YA15:ZF4444").PasteSpecial xlPasteFormats
        Application.CutCopyMode = False
        
        .Range("G15:G4444").Copy
        .Range("AAA15:ABF4444").PasteSpecial xlPasteFormats
        Application.CutCopyMode = False
        
        .Range("A15:A564").EntireRow.Hidden = True
        .Range("A569:A1118").EntireRow.Hidden = True
        .Range("A1123:A1672").EntireRow.Hidden = True
        .Range("A1677:A2226").EntireRow.Hidden = True
        .Range("A2231:A2780").EntireRow.Hidden = True
        .Range("A2785:A3334").EntireRow.Hidden = True
        .Range("A3339:A3888").EntireRow.Hidden = True
        .Range("A3893:A4442").EntireRow.Hidden = True
        
        For intLoop = 1 To wks_M_List.Range("C9").Value
            intConsolidator = ((intLoop - 1) * 11) + 15
            'MARKET UNITS
            Call Insert_Formula(intConsolidator)
            'PRODUCT UNITS
            Call Insert_Formula(intConsolidator + 1108)
            'GROSS SALES
            Call Insert_Formula(intConsolidator + 1662)
            'GROSS PRICE
            Call Insert_Formula_Average(intConsolidator + 2216)
            'GTN
            Call Insert_Formula_Average(intConsolidator + 2770)
            'NET SALES
            Call Insert_Formula(intConsolidator + 3324)
            'MARKET SALES
            Call Insert_Formula(intConsolidator + 554)
            'NET PRICE
            Call Insert_Formula_Average(intConsolidator + 3878)
            
            intConsolidator = intConsolidator + 1
            
            intSKU = wks_M_List.Range("I" & intLoop + 9).Value
            For intLoop2 = 1 To intSKU
                'MARKET UNITS
                wks_Backup_Data.Range("E" & intRow & ":MZ" & intRow).Copy
                .Range("G" & intConsolidator).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                Call Insert_Formula(intConsolidator)
                'PRODUCT UNITS
                wks_Backup_Data.Range("E" & intRow + 4 & ":MZ" & intRow + 4).Copy
                .Range("G" & intConsolidator + 1108).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                Call Insert_Formula(intConsolidator + 1108)
                'GROSS SALES
                wks_Backup_Data.Range("E" & intRow + 5 & ":MZ" & intRow + 5).Copy
                .Range("G" & intConsolidator + 1662).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                Call Insert_Formula(intConsolidator + 1662)
                'GROSS PRICE
                Call Insert_Formula_Average(intConsolidator + 2216)
                'GTN
                wks_Backup_Data.Range("E" & intRow + 3 & ":MZ" & intRow + 3).Copy
                .Range("G" & intConsolidator + 2770).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                Call Insert_Formula_Average(intConsolidator + 2770)
                'NET SALES
                wks_Backup_Data.Range("E" & intRow + 7 & ":MZ" & intRow + 7).Copy
                .Range("G" & intConsolidator + 3324).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                Call Insert_Formula(intConsolidator + 3324)
                'MARKET SALES
                wks_Historical.Range("F" & intHist & ":NA" & intHist).Copy
                .Range("G" & intConsolidator + 554).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                Call Insert_Formula(intConsolidator + 554)
                'NET PRICE
                Call Insert_Formula_Average(intConsolidator + 3878)
                
                intConsolidator = intConsolidator + 1
                
                intRow = intRow + 48
                intHist = intHist + 237
            Next intLoop2
        Next intLoop
        
        .Calculate
        .Range("SA15:ABF4444").Value = .Range("SA15:ABF4444").Value
    End With
End Function

Function Insert_Formula(intRow As Integer)
    With wks_Consolidator
        .Range("G" & intRow).EntireRow.Hidden = False
        With .Range("SA" & intRow & ":WP" & intRow)
            .Formula = "=IFERROR(SUMIF($G$8:$NB$8,SA$9,$G" & intRow & ":$NB" & intRow & "),0)"
            .Calculate
''            .Value = .Value
        End With
        With .Range("YA" & intRow & ":ZF" & intRow)
            .Formula = "=IFERROR(SUMIF($G$6:$NB$6,YA$9,$G" & intRow & ":$NB" & intRow & "),0)"
            .Calculate
''            .Value = .Value
        End With
        With .Range("AAA" & intRow & ":ABF" & intRow)
            .Formula = "=IFERROR(SUMIF($G$7:$NB$7,AAA$9,$G" & intRow & ":$NB" & intRow & "),0)"
            .Calculate
''            .Value = .Value
        End With
    End With
End Function

Function Insert_Formula_Average(intRow As Integer)
    With wks_Consolidator
        .Range("G" & intRow).EntireRow.Hidden = False
        With .Range("SA" & intRow & ":WP" & intRow)
            .Formula = "=IFERROR(AVERAGEIF($G$8:$NB$8,SA$9,$G" & intRow & ":$NB" & intRow & "),0)"
            .Calculate
''            .Value = .Value
        End With
        With .Range("YA" & intRow & ":ZF" & intRow)
            .Formula = "=IFERROR(AVERAGEIF($G$6:$NB$6,YA$9,$G" & intRow & ":$NB" & intRow & "),0)"
            .Calculate
''            .Value = .Value
        End With
        With .Range("AAA" & intRow & ":ABF" & intRow)
            .Formula = "=IFERROR(AVERAGEIF($G$7:$NB$7,AAA$9,$G" & intRow & ":$NB" & intRow & "),0)"
            .Calculate
''            .Value = .Value
        End With
    End With
End Function

Function Make_AsValue()
Dim intLoop As Integer, intStart As Integer, intEnd As Integer
Application.ScreenUpdating = False
intStart = 15
intEnd = 64
    For intLoop = 1 To 8
        Call Copy_Paste_Values(wks_Consolidator.Range("G" & intStart & ":" & wks_Vars.Range("K4").Value & intEnd), wks_Consolidator.Range("G" & intStart & ":" & wks_Vars.Range("K4").Value & intEnd))
        Call Copy_Paste_Values(wks_Consolidator.Range("G" & intStart + 434 & ":" & wks_Vars.Range("K4").Value & intEnd + 434), wks_Consolidator.Range("G" & intStart + 434 & ":" & wks_Vars.Range("K4").Value & intEnd + 434))
        Call Copy_Paste_Values(wks_Consolidator.Range("G" & intStart + 868 & ":" & wks_Vars.Range("K4").Value & intEnd + 868), wks_Consolidator.Range("G" & intStart + 868 & ":" & wks_Vars.Range("K4").Value & intEnd + 868))
        
''        wks_Consolidator.Range("G" & intStart & ":NB" & intEnd).Value = wks_Consolidator.Range("G" & intStart & ":NB" & intEnd).Value
''        wks_Consolidator.Range("G" & intStart + 434 & ":NB" & intEnd + 434).Value = wks_Consolidator.Range("G" & intStart + 434 & ":NB" & intEnd + 434).Value
''        wks_Consolidator.Range("G" & intStart + 868 & ":NB" & intEnd + 868).Value = wks_Consolidator.Range("G" & intStart + 868 & ":NB" & intEnd + 868).Value
        intStart = intStart + 54
        intEnd = intEnd + 54
    Next intLoop
Application.ScreenUpdating = True
End Function

'"""""""""""""""""""""""""""""""""""""""""""""""""""""Product Consolidator""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Function Prod_Cons_Activate()
''    Dim strRng As String, intRng As Integer
''    With wks_ProdCons
''        intRng = wks_M_List.Range("C9").Value
''        strRng = "Master_List!" & wks_M_List.Range(wks_M_List.Cells(10, 2), wks_M_List.Cells(9 + intRng, 2)).Address
''        With wks_ProdCons.Shapes("Drp_Product2").ControlFormat
''            .ListFillRange = strRng
''        End With
''        .Activate
''    End With
End Function

Function SKU_For_Consolidator()
    Dim intLoop As Integer, intRng As Integer, intCell As Integer, intVar As Integer, intStart As Integer, intEnd As Integer
    Dim strRng As String, intRngSelect As Integer, strAddress As String, intVar2 As Integer
    
    intVar2 = 9 + wks_Vars.Range("Q26").Value
    intStart = 15: intEnd = 14 + wks_M_List.Range("I" & intVar2).Value
    
    intVar = 9 + wks_Vars.Range("Q26").Value
    intRng = 1
           
    intCell = wks_Vars.Range("Q26").Value
    intRng = 17 + wks_Vars.Range("Q26").Value
    intRngSelect = wks_Vars.Range("G" & intCell + 2).Value
    strAddress = Range(wks_Vars.Cells(2, intRng), wks_Vars.Cells(2 + wks_Vars.Range("Q1").Value, intRng)).Address
    strRng = "Vars!" & Range(wks_Vars.Cells(2, intRng), wks_Vars.Cells(2 + wks_Vars.Range("Q1").Value, intRng)).Address
    wks_Vars.Range("AB3:AB" & wks_M_List.Range("I" & intVar).Value + 3).Value = wks_Vars.Range("" & strAddress).Value
    
''    With wks_ProdCons
''        For intLoop = 1 To 9
''            .Range("F" & intStart & ":F" & intEnd).Value = wks_Vars.Range("AB3:AB" & wks_M_List.Range("I" & intVar2).Value + 2).Value
''            .Range("F" & intStart + 172 & ":F" & intEnd + 172).Value = wks_Vars.Range("AB3:AB" & wks_M_List.Range("I" & intVar2).Value + 2).Value
''            .Range("F" & intStart + 344 & ":F" & intEnd + 344).Value = wks_Vars.Range("AB3:AB" & wks_M_List.Range("I" & intVar2).Value + 2).Value
''            intStart = intStart + 19
''            intEnd = intEnd + 19
''        Next intLoop
''    End With
End Function

Function ProdCons_HideUnhide()
Dim intStart As Integer, intEnd As Integer, intLoop As Integer, intRng As Integer, intTot As Integer
Application.ScreenUpdating = False
intRng = 9 + wks_Vars.Range("Q26").Value
''With wks_ProdCons
''    .Range("A7:A12").EntireRow.Hidden = True
''    .Range("A13:A530").EntireRow.Hidden = True
''    If wks_Vars.Range("Q15").Value = 1 Then
''        .Range("G186:AB355").ClearContents
''        .Range("A12:A12").EntireRow.Hidden = False
''        .Range("A185:A185").EntireRow.Hidden = False
''        .Range("A186:A355").EntireRow.Hidden = True
''        intStart = 186: intTot = 202
''        intEnd = 186 + wks_M_List.Range("I" & intRng).Value
''            For intLoop = 1 To 9
''                .Range("A" & intStart & ":A" & intEnd).EntireRow.Hidden = False
''                .Range("A" & intTot & ":A" & intTot + 1).EntireRow.Hidden = False
''                .Range("G" & intTot & ":NB" & intTot).Formula = "=SUM(G" & intStart + 1 & ":G" & intTot - 1 & ")"
''                intStart = intStart + 19
''                intEnd = intEnd + 19
''                intTot = intTot + 19
''            Next intLoop
''
''        intStart = 186: intTot = 202
''        intEnd = 186 + wks_M_List.Range("I" & intRng).Value
''        .Range("G" & intStart + 1 & ":AB" & intEnd).Formula = "=SUMIF($G$7:$NB$7,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 20 & ":AB" & intEnd + 19).Formula = "=SUMIF($G$7:$NB$7,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 39 & ":AB" & intEnd + 38).Formula = "=SUMIF($G$7:$NB$7,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 58 & ":AB" & intEnd + 57).Formula = "=SUMIF($G$7:$NB$7,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 77 & ":AB" & intEnd + 76).Formula = "=IFERROR(G244/G225,0)"
''        .Range("G" & intStart + 96 & ":AB" & intEnd + 95).Formula = "=IFERROR(G301/G244,0)"
''        .Range("G" & intStart + 115 & ":AB" & intEnd + 114).Formula = "=SUMIF($G$7:$NB$7,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 134 & ":AB" & intEnd + 133).Formula = "=IFERROR(G301/G225,0)"
''        .Range("G" & intStart + 153 & ":AB" & intEnd + 152).Formula = "=IFERROR(G225/G240,0)"
''        Call Copy_Paste_Values(.Range("G187:AB355"), .Range("G187:AB355"))
''''        .Range("G187:AB355").Value = .Range("G187:AB355").Value
''        .Range("AC187:NB355").ClearContents
''        .Range("A278").EntireRow.Hidden = True
''        .Range("A297").EntireRow.Hidden = True
''        .Range("A335").EntireRow.Hidden = True
''        .Range("A185").Value = "CY"
''
''    ElseIf wks_Vars.Range("Q15").Value = 2 Then
''        .Range("G186:AB355").ClearContents
''        .Range("A12:A12").EntireRow.Hidden = False
''        .Range("A185:A185").EntireRow.Hidden = False
''        .Range("A186:A355").EntireRow.Hidden = True
''        intStart = 186: intTot = 202
''        intEnd = 186 + wks_M_List.Range("I" & intRng).Value
''            For intLoop = 1 To 9
''                .Range("A" & intStart & ":A" & intEnd).EntireRow.Hidden = False
''                .Range("A" & intTot & ":A" & intTot + 1).EntireRow.Hidden = False   '=SUM(G15:G29)
''                .Range("G" & intTot & ":NB" & intTot).Formula = "=SUM(G" & intStart + 1 & ":G" & intTot - 1 & ")"
''                intStart = intStart + 19
''                intEnd = intEnd + 19
''                intTot = intTot + 19
''            Next intLoop
''
''        intStart = 186: intTot = 202
''        intEnd = 186 + wks_M_List.Range("I" & intRng).Value
''        .Range("G" & intStart + 1 & ":AB" & intEnd).Formula = "=SUMIF($G$8:$NB$8,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 20 & ":AB" & intEnd + 19).Formula = "=SUMIF($G$8:$NB$8,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 39 & ":AB" & intEnd + 38).Formula = "=SUMIF($G$8:$NB$8,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 58 & ":AB" & intEnd + 57).Formula = "=SUMIF($G$8:$NB$8,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 77 & ":AB" & intEnd + 76).Formula = "=IFERROR(G244/G225,0)"
''        .Range("G" & intStart + 96 & ":AB" & intEnd + 95).Formula = "=IFERROR(G301/G244,0)"
''        .Range("G" & intStart + 115 & ":AB" & intEnd + 114).Formula = "=SUMIF($G$8:$NB$8,$G$12:$AB$12,$G15:$NB15)"
''        .Range("G" & intStart + 134 & ":AB" & intEnd + 133).Formula = "=IFERROR(G301/G225,0)"
''        .Range("G" & intStart + 153 & ":AB" & intEnd + 152).Formula = "=IFERROR(G225/G240,0)"
''        Call Copy_Paste_Values(.Range("G187:AB355"), .Range("G187:AB355"))
''''        .Range("G187:AB355").Value = .Range("G187:AB355").Value
''        .Range("AC187:NB355").ClearContents
''        .Range("A278").EntireRow.Hidden = True
''        .Range("A297").EntireRow.Hidden = True
''        .Range("A335").EntireRow.Hidden = True
''        .Range("A185").Value = "FY"
''
''    ElseIf wks_Vars.Range("Q15").Value = 3 Then
''        .Range("G14:NB183").ClearContents
''        .Range("A10:A10").EntireRow.Hidden = False
''        .Range("A13:A13").EntireRow.Hidden = False
''        .Range("A14:A183").EntireRow.Hidden = True
''
''        intStart = 14: intTot = 30
''        intEnd = 14 + wks_M_List.Range("I" & intRng).Value
''            For intLoop = 1 To 9
''                .Range("A" & intStart & ":A" & intEnd).EntireRow.Hidden = False
''                .Range("A" & intTot & ":A" & intTot + 1).EntireRow.Hidden = False
''                .Range("G" & intTot & ":NB" & intTot).Formula = "=SUM(G" & intStart + 1 & ":G" & intTot - 1 & ")"
''                intStart = intStart + 19
''                intEnd = intEnd + 19
''                intTot = intTot + 19
''            Next intLoop
''
''        intStart = 14: intTot = 30
''        intEnd = 14 + wks_M_List.Range("I" & intRng).Value
''        .Range("G" & intStart + 1 & ":NB" & intEnd).Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$26,ForecastData!$C:$C,Vars!$Q$19,ForecastData!$B:$B,Pro_Cons!$F15,ForecastData!$E:$E,Vars!$P$20)"
''        .Range("G" & intStart + 20 & ":NB" & intEnd + 19).Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$26,ForecastData!$C:$C,Vars!$Q$19,ForecastData!$B:$B,Pro_Cons!$F34,ForecastData!$E:$E,Vars!$P$24)"
''        .Range("G" & intStart + 39 & ":NB" & intEnd + 38).Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$26,ForecastData!$C:$C,Vars!$Q$19,ForecastData!$B:$B,Pro_Cons!$F53,ForecastData!$E:$E,Vars!$P$23)"
''        .Range("G" & intStart + 58 & ":NB" & intEnd + 57).Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$26,ForecastData!$C:$C,Vars!$Q$19,ForecastData!$B:$B,Pro_Cons!$F72,ForecastData!$E:$E,Vars!$P$25)"
''        .Range("G" & intStart + 77 & ":NB" & intEnd + 76).Formula = "=IFERROR(G72/G53,0)"
''        .Range("G" & intStart + 96 & ":NB" & intEnd + 95).Formula = "=IFERROR(G129/G72, 0)"
''        .Range("G" & intStart + 115 & ":NB" & intEnd + 114).Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$26,ForecastData!$C:$C,Vars!$Q$19,ForecastData!$B:$B,Pro_Cons!$F129,ForecastData!$E:$E,Vars!$P$22)"
''        .Range("G" & intStart + 134 & ":NB" & intEnd + 133).Formula = "=IFERROR(G129/G53,0)"
''        .Range("G" & intStart + 153 & ":NB" & intEnd + 152).Formula = "=IFERROR(G53/G68,0)"
''        Call Copy_Paste_Values(.Range("G15:NB182"), .Range("G15:NB182"))
''''        .Range("G15:NB182").Value = .Range("G15:NB182").Value
''        .Range("A106").EntireRow.Hidden = True
''        .Range("A125").EntireRow.Hidden = True
''        .Range("A163").EntireRow.Hidden = True
''
''    ElseIf wks_Vars.Range("Q15").Value = 4 Then
''        .Range("G358:CH530").ClearContents
''        .Range("A11:A11").EntireRow.Hidden = False
''        .Range("A357:A357").EntireRow.Hidden = False
''        .Range("A358:A530").EntireRow.Hidden = True
''        intStart = 358: intTot = 374
''        intEnd = 358 + wks_M_List.Range("I" & intRng).Value
''            For intLoop = 1 To 9
''                .Range("A" & intStart & ":A" & intEnd).EntireRow.Hidden = False
''                .Range("A" & intTot & ":A" & intTot + 1).EntireRow.Hidden = False
''                .Range("G" & intTot & ":CH" & intTot).Formula = "=SUM(G" & intStart + 1 & ":G" & intTot - 1 & ")"
''                intStart = intStart + 19
''                intEnd = intEnd + 19
''                intTot = intTot + 19
''            Next intLoop
''
''        intStart = 358: intTot = 374
''        intEnd = 358 + wks_M_List.Range("I" & intRng).Value
''        .Range("G" & intStart + 1 & ":CH" & intEnd).Formula = "=SUMIF($G$9:$NB$9,G$11,$G15:$NB15)"
''        .Range("G" & intStart + 20 & ":CH" & intEnd + 19).Formula = "=SUMIF($G$9:$NB$9,G$11,$G34:$NB34)"
''        .Range("G" & intStart + 39 & ":CH" & intEnd + 38).Formula = "=SUMIF($G$9:$NB$9,G$11,$G53:$NB53)"
''        .Range("G" & intStart + 58 & ":CH" & intEnd + 57).Formula = "=SUMIF($G$9:$NB$9,G$11,$G72:$NB72)"
''        .Range("G" & intStart + 77 & ":CH" & intEnd + 76).Formula = "=IFERROR(G416/G397,0)"
''        .Range("G" & intStart + 96 & ":CH" & intEnd + 95).Formula = "=IFERROR(G473/G416,0)"
''        .Range("G" & intStart + 115 & ":CH" & intEnd + 114).Formula = "=SUMIF($G$9:$NB$9,G$11,$G129:$NB129)"
''        .Range("G" & intStart + 134 & ":CH" & intEnd + 133).Formula = "=IFERROR(G473/G397,0)"
''        .Range("G" & intStart + 153 & ":CH" & intEnd + 152).Formula = "=IFERROR(G397/G412,0)"
''        Call Copy_Paste_Values(.Range("G358:CH530"), .Range("G358:CH530"))
''''        .Range("G358:CH530").Value = .Range("G358:CH530").Value
''        .Range("CI359:NB530").ClearContents
''        .Range("A450").EntireRow.Hidden = True
''        .Range("A469").EntireRow.Hidden = True
''        .Range("A507").EntireRow.Hidden = True
''    End If
''End With
Application.ScreenUpdating = True
End Function
    
Function Product_consolidator()
    
    Call SKU_For_Consolidator
    Call ProdCons_HideUnhide
    
End Function

Function Paste_Formula()
    Dim intLoop As Integer
    Dim intRow As Integer
    intRow = 3893
''    For intLoop = 1 To 49
''        Range("G2785").Copy
''        Range("G" & intRow).PasteSpecial xlPasteAll
''        Application.CutCopyMode = False
''        intRow = intRow + 11
''    Next intLoop
    intRow = 3893
    For intLoop = 1 To 50
        Range("G" & intRow).Font.Bold = True
        intRow = intRow + 11
    Next intLoop
End Function
