Attribute VB_Name = "mod_Front_to_Back"
Option Explicit
Dim strCountry As String, strScenario As String

Function BackEndSaveData()
    strCountry = wks_Vars.Range("V4").Value
    strScenario = wks_Vars.Range("V5").Value
    
    Call EPI_Data_Save
    Call Historical_Data_Save
    Call Output_Data_Save
    Call Conversion_Data_Save
    Call Advanced_Pricing_Data_Save
    Call Shares_Data_Save
    Call Source_Data_Save
    Call Events_Data_Save
    Call MasterList_Save
End Function

Function EPI_Data_Save()
    Dim intRow As Integer
    Dim intParameter As Integer
    Dim intLoop As Integer
    
    intRow = wks_Vars.Range("CC2").Value
    intParameter = 1
    
    With wks_ForecastFlow
        For intLoop = 10 To 985
            If .Range("G" & intLoop).Interior.Color = RGB(255, 255, 204) Then
                wks_EPI_Data.Range("B" & intRow).Value = strCountry
                wks_EPI_Data.Range("C" & intRow).Value = strScenario
                wks_EPI_Data.Range("D" & intRow).Value = "Parameter" & intParameter
                .Range("G" & intLoop & ":" & wks_Vars.Range("J8").Value & intLoop).Copy
                wks_EPI_Data.Range("E" & intRow).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                intParameter = intParameter + 1
                intRow = intRow + 1
            End If
        Next intLoop
    End With
    For intLoop = intParameter To 100
        wks_EPI_Data.Range("B" & intRow).Value = strCountry
        wks_EPI_Data.Range("C" & intRow).Value = strScenario
        wks_EPI_Data.Range("D" & intRow).Value = "Parameter" & intLoop
        intRow = intRow + 1
    Next intLoop
End Function

Function Historical_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intInline As Integer
    Dim intPipeline As Integer
    intForecastRow = wks_Vars.Range("EB2").Value
    intRow = wks_Vars.Range("CC3").Value
    
    intInline = wks_Vars.Range("M1").Value
    intPipeline = wks_Vars.Range("R1").Value
    
    If intInline <> 0 Then
        intInline = intInline - 1
    End If
    
    With wks_ForecastFlow
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Hist Units"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 7
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Hist Patients"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 7
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Hist Revenue"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 9
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Analyst Report"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 21
        intRow = intRow + 5
        
        'Modification Factor
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Factor Units"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 7
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Factor Patients"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 7
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Factor Revenue"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = "All"
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 30
        intRow = intRow + 5
        
        'PRODUCT SPLIT
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
    
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
        
        wks_Historical_Data.Range("B" & intRow & ":B" & intRow + intInline).Value = strCountry
        wks_Historical_Data.Range("C" & intRow & ":C" & intRow + intInline).Value = strScenario
        wks_Historical_Data.Range("D" & intRow & ":D" & intRow + intInline).Value = "Product Split"
        wks_Historical_Data.Range("E" & intRow & ":E" & intRow + intInline).Value = .Range("E" & intForecastRow - 1).Value
        .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
        wks_Historical_Data.Range("F" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intForecastRow = intForecastRow + 6
        intRow = intRow + 5
    End With
End Function

Function Output_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intInline As Integer
    Dim intPipeline As Integer
    Dim intLoop As Integer
    
    intRow = wks_Vars.Range("CC6").Value
    
    intInline = wks_Vars.Range("M1").Value
    intPipeline = wks_Vars.Range("R1").Value
    
    If intInline <> 0 Then
        intInline = intInline - 1
    End If
    If intPipeline <> 0 Then
        intPipeline = intPipeline - 1
    End If
    
    With wks_ForecastFlow
        'TRENDED DATA
        intForecastRow = wks_Vars.Range("EB3").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 4).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 4).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 4).Value = "Trended Data"
            wks_Output.Range("E" & intRow & ":E" & intRow + 4).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 6
            intRow = intRow + 5
        Next intLoop

        'Modification Factor
        intForecastRow = wks_Vars.Range("EB4").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 4).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 4).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 4).Value = "Trended Factor"
            wks_Output.Range("E" & intRow & ":E" & intRow + 4).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 4).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 6
            intRow = intRow + 5
        Next intLoop
        
        'PRODUCT SHARES
        intForecastRow = wks_Vars.Range("EB5").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Product Shares"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 12).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 34
            intRow = intRow + 10
        Next intLoop

        ''OUTPUT Patients
        intForecastRow = wks_Vars.Range("EB6").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Patients"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop

        ''Units
        intForecastRow = wks_Vars.Range("EB7").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Units"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop

        ''GROSS REVENUE
        intForecastRow = wks_Vars.Range("EB8").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Gross Revenue"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop
        
        ''NET REVENUE
        intForecastRow = wks_Vars.Range("EB9").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Net Revenue"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop

        ''PAG REVENUE
        intForecastRow = wks_Vars.Range("EB10").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Prob Adj Gross Revenue"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop
        
        ''PAN REVENUE
        intForecastRow = wks_Vars.Range("EB11").Value
        For intLoop = 1 To 15
            wks_Output.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Output.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Output.Range("D" & intRow & ":D" & intRow + 9).Value = "Prob Adj Net Revenue"
            wks_Output.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Output.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop
    End With
End Function
Function Conversion_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    
    intRow = wks_Vars.Range("CC4").Value
    
    With wks_ForecastFlow
        ''COMPLIANCE
        intForecastRow = wks_Vars.Range("EB12").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "Compliance"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''DOSING
        intForecastRow = wks_Vars.Range("EB13").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "Dosing"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''DOT
        intForecastRow = wks_Vars.Range("EB14").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "DoT"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''Price
        intForecastRow = wks_Vars.Range("EB15").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "Price"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''Market Access
        intForecastRow = wks_Vars.Range("EB16").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "Market Access"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''GTN
        intForecastRow = wks_Vars.Range("EB17").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "GTN"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''PlaceHolder
        intForecastRow = wks_Vars.Range("EB18").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "PlaceHolder"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        ''Probability of Success
        intForecastRow = wks_Vars.Range("EB19").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("B" & intRow & ":B" & intRow + 9).Value = strCountry
            wks_Conversion_Data.Range("C" & intRow & ":C" & intRow + 9).Value = strScenario
            wks_Conversion_Data.Range("D" & intRow & ":D" & intRow + 9).Value = "Prob Adj"
            wks_Conversion_Data.Range("E" & intRow & ":E" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":" & wks_Vars.Range("J8").Value & intForecastRow + 9).Copy
            wks_Conversion_Data.Range("F" & intRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
    End With
End Function

Function Advanced_Pricing_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    Dim intMonth As Integer
    
    intRow = wks_Vars.Range("CC8").Value
    
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB20").Value
        For intLoop = 1 To 15
            wks_AdvancedPricing.Range("A" & intRow & ":A" & intRow + 9).Value = strCountry
            wks_AdvancedPricing.Range("B" & intRow & ":B" & intRow + 9).Value = strScenario
            wks_AdvancedPricing.Range("C" & intRow & ":C" & intRow + 9).Value = "Advanced Pricing"
            wks_AdvancedPricing.Range("D" & intRow & ":D" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":J" & intForecastRow + 9).Copy
            wks_AdvancedPricing.Range("E" & intRow).PasteSpecial xlPasteValuesAndNumberFormats
            Application.CutCopyMode = False
            For intMonth = intRow To intRow + 9
                If wks_AdvancedPricing.Range("H" & intMonth).Value <> "" Then
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Jan" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 1
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Feb" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 2
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Mar" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 3
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Apr" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 4
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "May" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 5
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Jun" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 6
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Jul" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 7
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Aug" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 8
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Sep" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 9
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Oct" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 10
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Nov" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 11
                    If wks_AdvancedPricing.Range("H" & intMonth).Value = "Dec" Then wks_AdvancedPricing.Range("H" & intMonth).Value = 12
                End If
            Next intMonth
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop
    End With
End Function

Function Shares_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    
    intRow = wks_Vars.Range("CC5").Value
    
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB21").Value
        For intLoop = 1 To 15
            wks_Shares.Range("A" & intRow & ":A" & intRow + 9).Value = strCountry
            wks_Shares.Range("B" & intRow & ":B" & intRow + 9).Value = strScenario
            wks_Shares.Range("C" & intRow & ":C" & intRow + 9).Value = "Shares"
            wks_Shares.Range("D" & intRow & ":D" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("F" & intForecastRow & ":K" & intForecastRow + 9).Copy
            wks_Shares.Range("E" & intRow).PasteSpecial xlPasteValuesAndNumberFormats
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 34
        Next intLoop
    End With
End Function

Function Source_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    
    intRow = wks_Vars.Range("CC10").Value
    
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB22").Value
        For intLoop = 1 To 15
            wks_SOB.Range("A" & intRow & ":A" & intRow + 9).Value = strCountry
            wks_SOB.Range("B" & intRow & ":B" & intRow + 9).Value = strScenario
            wks_SOB.Range("C" & intRow & ":C" & intRow + 9).Value = "Source Of Business"
            wks_SOB.Range("D" & intRow & ":D" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("M" & intForecastRow & ":R" & intForecastRow + 9).Copy
            wks_SOB.Range("E" & intRow).PasteSpecial xlPasteValuesAndNumberFormats
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 34
        Next intLoop
    End With
End Function

Function Events_Data_Save()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    
    intRow = wks_Vars.Range("CC7").Value
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB23").Value
        For intLoop = 1 To 15
            wks_Events.Range("A" & intRow & ":A" & intRow + 9).Value = strCountry
            wks_Events.Range("B" & intRow & ":B" & intRow + 9).Value = strScenario
            wks_Events.Range("C" & intRow & ":C" & intRow + 9).Value = "Events"
            wks_Events.Range("D" & intRow & ":D" & intRow + 9).Value = .Range("E" & intForecastRow - 1).Value
            .Range("E" & intForecastRow & ":M" & intForecastRow + 9).Copy
            wks_Events.Range("E" & intRow).PasteSpecial xlPasteValuesAndNumberFormats
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 34
        Next intLoop
    End With
End Function

Function MasterList_Save()
    Dim intRow As Integer

    intRow = wks_Vars.Range("CC9").Value
    With wks_MasterList
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "HistoricalDataAvailableType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A1002").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "AnalystReportType"
        .Range("D" & intRow).Value = wks_Vars.Range("BO1").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "ComplianceType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A1615").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "DosingType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A1784").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "DoTType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A1953").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "Advanced Pricing OptionsType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A2122").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "PriceType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A2291").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "Market AccessType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A2460").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "GTNType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A2629").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "Prob AdjType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A4759").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "PlaceHolderType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A2798").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "ProductSharesType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A3059").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "ShareEntryType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A3061").Value
        intRow = intRow + 1
        
        .Range("A" & intRow).Value = strCountry
        .Range("B" & intRow).Value = strScenario
        .Range("C" & intRow).Value = "EventType"
        .Range("D" & intRow).Value = wks_ForecastFlow.Range("A3576").Value
        intRow = intRow + 1
    End With
End Function

