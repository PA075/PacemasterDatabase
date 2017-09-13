Attribute VB_Name = "mod_Back_to_Front"
Option Explicit

''Save_Retrive_Data
Function FrontEndSaveData()
    Call MasterList_Data_Retrive
    Call EPIDataRetrieve
    Call Historical_Data_Retrieve
    Call Output_Data_Retrive
    Call Conversion_Data_Retrive
    Call Shares_Data_Retrive
    Call Source_Data_Retrive
    Call ProductShares_Segment_Change_1
    Call Events_Data_Retrive
    Call AdvancedPrice_Data_Retrive
End Function

Function EPIDataRetrieve()
    Dim intRow As Integer
    Dim intLoop As Integer
   
    intRow = wks_Vars.Range("CD2").Value
   
    With wks_ForecastFlow
        For intLoop = 10 To 985
            If .Range("G" & intLoop).Interior.Color = RGB(255, 255, 204) Then
                wks_EPI_Data.Range("E" & intRow & ":RP" & intRow).Copy
                .Range("G" & intLoop).PasteSpecial xlPasteValues
                Application.CutCopyMode = False
                intRow = intRow + 1
            End If
        Next intLoop
    End With
End Function

Function Historical_Data_Retrieve()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    intForecastRow = wks_Vars.Range("EB2").Value
    intRow = wks_Vars.Range("CD3").Value
    With wks_Historical_Data
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 7

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 7

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 9

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 21

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 7

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 7

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 30

        ''Product Split
        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6

        .Range("G" & intRow & ":" & wks_Vars.Range("J8").Value & intRow + 4).Copy
        wks_ForecastFlow.Range("G" & intForecastRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 5
        intForecastRow = intForecastRow + 6
    End With
End Function

Function Output_Data_Retrive()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("CD6").Value
    With wks_ForecastFlow
        'TRENDED DATA
        intForecastRow = wks_Vars.Range("EB3").Value
        For intLoop = 1 To 15
            wks_Output.Range("G" & intRow & ":RR" & intRow + 4).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 6
            intRow = intRow + 5
        Next intLoop

        'Modification Factor
        intForecastRow = wks_Vars.Range("EB4").Value
        For intLoop = 1 To 15
            wks_Output.Range("G" & intRow & ":RR" & intRow + 4).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 6
            intRow = intRow + 5
        Next intLoop
        
        'PRODUCT SHARES
        intForecastRow = wks_Vars.Range("EB5").Value
        For intLoop = 1 To 15
            wks_Output.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 34
            intRow = intRow + 10
        Next intLoop
    End With
End Function

Function Conversion_Data_Retrive()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("CD4").Value
    With wks_ForecastFlow
        ''COMPLIANCE
        intForecastRow = wks_Vars.Range("EB12").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call Compliance_Segment_Change_1
        
        ''Dosing
        intForecastRow = wks_Vars.Range("EB13").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call Dosing_Segment_Change_1
        
        ''DOT
        intForecastRow = wks_Vars.Range("EB14").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call DoT_Segment_Change_1
        
        ''Price
        intForecastRow = wks_Vars.Range("EB15").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call Price_Segment_Change_1
        
        ''Market Access
        intForecastRow = wks_Vars.Range("EB16").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call MarketAccess_Segment_Change_1
        
        ''GTN
        intForecastRow = wks_Vars.Range("EB17").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call GTN_Segment_Change_1
        
        ''PlaceHolder
        intForecastRow = wks_Vars.Range("EB18").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call PlaceHolder_Segment_Change_1
        
        ''Probability Success
        intForecastRow = wks_Vars.Range("EB19").Value
        For intLoop = 1 To 15
            wks_Conversion_Data.Range("G" & intRow & ":RR" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 11
            intRow = intRow + 10
        Next intLoop
        Call Probability_Segment_Change_1
    End With
End Function
Function Shares_Data_Retrive()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("CD5").Value
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB21").Value
        For intLoop = 1 To 15
            wks_Shares.Range("F" & intRow & ":J" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 34
            intRow = intRow + 10
        Next intLoop
    End With
End Function

Function Source_Data_Retrive()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("CD10").Value
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB22").Value
        For intLoop = 1 To 15
            wks_SOB.Range("F" & intRow & ":J" & intRow + 9).Copy
            .Range("N" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intForecastRow = intForecastRow + 34
            intRow = intRow + 10
        Next intLoop
    End With
End Function

Function Events_Data_Retrive()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    intRow = wks_Vars.Range("CD7").Value
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB23").Value
        For intLoop = 1 To 15
            wks_Events.Range("G" & intRow & ":M" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 10
            intForecastRow = intForecastRow + 34
        Next intLoop
    End With
End Function
Function AdvancedPrice_Data_Retrive()
    Dim intRow As Integer
    Dim intForecastRow As Integer
    Dim intLoop As Integer
    Dim intMonth As Integer
    intRow = wks_Vars.Range("CD8").Value
    With wks_ForecastFlow
        intForecastRow = wks_Vars.Range("EB20").Value
        For intLoop = 1 To 15
            wks_AdvancedPricing.Range("F" & intRow & ":I" & intRow + 9).Copy
            .Range("G" & intForecastRow).PasteSpecial xlPasteValuesAndNumberFormats
            Application.CutCopyMode = False
            For intMonth = intForecastRow To intForecastRow + 9
                If .Range("I" & intMonth).Value <> "" Then
                    If .Range("I" & intMonth).Value = 1 Then .Range("I" & intMonth).Value = "Jan"
                    If .Range("I" & intMonth).Value = 2 Then .Range("I" & intMonth).Value = "Feb"
                    If .Range("I" & intMonth).Value = 3 Then .Range("I" & intMonth).Value = "Mar"
                    If .Range("I" & intMonth).Value = 4 Then .Range("I" & intMonth).Value = "Apr"
                    If .Range("I" & intMonth).Value = 5 Then .Range("I" & intMonth).Value = "May"
                    If .Range("I" & intMonth).Value = 6 Then .Range("I" & intMonth).Value = "Jun"
                    If .Range("I" & intMonth).Value = 7 Then .Range("I" & intMonth).Value = "Jul"
                    If .Range("I" & intMonth).Value = 8 Then .Range("I" & intMonth).Value = "Aug"
                    If .Range("I" & intMonth).Value = 9 Then .Range("I" & intMonth).Value = "Sep"
                    If .Range("I" & intMonth).Value = 10 Then .Range("I" & intMonth).Value = "Oct"
                    If .Range("I" & intMonth).Value = 11 Then .Range("I" & intMonth).Value = "Nov"
                    If .Range("I" & intMonth).Value = 12 Then .Range("I" & intMonth).Value = "Dec"
                End If
            Next intMonth
            intRow = intRow + 10
            intForecastRow = intForecastRow + 11
        Next intLoop
        Call AdvancePriceing_Segment_Change_1
    End With
End Function
Function MasterList_Data_Retrive()
    Dim intRow As Integer
    intRow = wks_Vars.Range("CD9").Value
    With wks_ForecastFlow
        .Range("A" & wks_Vars.Range("EB2").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        wks_Vars.Range("BO1").Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB12").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB13").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB14").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB20").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB15").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB16").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB17").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB19").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB18").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB21").Value - 5).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
        
        .Range("A" & wks_Vars.Range("EB23").Value - 3).Value = wks_MasterList.Range("D" & intRow).Value
        intRow = intRow + 1
    End With
End Function
