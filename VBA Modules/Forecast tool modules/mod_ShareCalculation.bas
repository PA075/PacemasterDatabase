Attribute VB_Name = "mod_ShareCalculation"
Option Explicit

Function ShareCalculation()
    Call Application_Event_Handler(False)
    Call ShareCalculation_1
    Call Inline_Shares_1
    Call Application_Event_Handler(True)
End Function

Function ShareCalculation_1()
    If wks_Vars.Range("H2").Value = 1 Then
        Call Fair_Share_Capture
    ElseIf wks_Vars.Range("H2").Value = 2 Then
        Call Sourced_Share_Capture
    ElseIf wks_Vars.Range("H2").Value = 3 Then
        Call SteadyStateShareDynamics
    ElseIf wks_Vars.Range("H2").Value = 4 Then
        Call Sequenced_Share_Dynamics
    ElseIf wks_Vars.Range("H2").Value = 5 Then
        Call Share_Steal
    End If
End Function

Function Fair_Share_Capture()
    Dim intRow As Integer
    Dim intLoop As Integer
    With wks_O1A
        .Range("P9").Value = wks_Vars.Range("J2").Value
        With .Range("Q9:" & wks_Vars.Range("J12").Value & 9)
            .Formula = "=DATE(YEAR(P9),MONTH(P9)+1,1)"
            .Calculate
            .Value = .Value
        End With
        
        .Range("P16:P248").Copy
        .Range("Q16:" & wks_Vars.Range("J12").Value & 248).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
    End With
    
    With wks_ForecastFlow
        intRow = wks_Vars.Range("EB21").Value
        .Range("H" & intRow & ":H" & intRow + 4).Copy
        wks_O1A.Range("D17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
        wks_O1A.Range("D28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Launch Date
        .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
        wks_O1A.Range("E28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Peak Share
        .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
        wks_O1A.Range("I28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Months To Peak
        .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
        wks_O1A.Range("G28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Curve Type
        .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
        wks_O1A.Range("F28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O1A.Calculate
        
        wks_O1A.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
        .Range("G" & intRow + 11).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O1A.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
        .Range("G" & intRow + 16).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 34
        
        If .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 2 Then
            For intLoop = 1 To 14
                If .Range("E" & intRow - 1).Value <> 0 Or .Range("E" & intRow - 1).Value <> "" Then
                    .Range("H" & intRow & ":H" & intRow + 4).Copy
                    wks_O1A.Range("D17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
                    wks_O1A.Range("D28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Launch Date
                    .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
                    wks_O1A.Range("E28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Peak Share
                    .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
                    wks_O1A.Range("I28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Months To Peak
                    .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
                    wks_O1A.Range("G28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Curve Type
                    .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
                    wks_O1A.Range("F28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O1A.Calculate
                    
                    wks_O1A.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
                    .Range("G" & intRow + 11).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O1A.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
                    .Range("G" & intRow + 16).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                End If
                intRow = intRow + 34
            Next intLoop
        End If
    End With
    With wks_O1A
        .Range("Q16:" & wks_Vars.Range("J12").Value & 248).Clear
    End With
End Function

Function Sourced_Share_Capture()
    Dim intRow As Integer
    Dim intLoop As Integer
    With wks_O1
        .Range("P9").Value = wks_Vars.Range("J2").Value
        With .Range("Q9:" & wks_Vars.Range("J12").Value & 9)
            .Formula = "=DATE(YEAR(P9),MONTH(P9)+1,1)"
            .Calculate
            .Value = .Value
        End With
        
        .Range("P16:P83").Copy
        .Range("Q16:" & wks_Vars.Range("J12").Value & 83).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
    End With
    
    With wks_ForecastFlow
        intRow = wks_Vars.Range("EB22").Value
        .Range("H" & intRow & ":H" & intRow + 4).Copy
        wks_O1.Range("D17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
        wks_O1.Range("D28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Launch Date
        .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
        wks_O1.Range("E28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Peak Share
        .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
        wks_O1.Range("I28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Months To Peak
        .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
        wks_O1.Range("G28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Curve Type
        .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
        wks_O1.Range("F28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Shares
        .Range("N" & intRow & ":R" & intRow + 4).Copy
        wks_O1.Range("D42").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("N" & intRow + 5 & ":R" & intRow + 9).Copy
        wks_O1.Range("D52").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O1.Calculate
        
        wks_O1.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
        .Range("G" & intRow + 11).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O1.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
        .Range("G" & intRow + 16).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 34
        
        If .Range("A" & wks_Vars.Range("EB22").Value - 7).Value = 2 Then
            For intLoop = 1 To 14
                If .Range("E" & intRow - 1).Value <> 0 Or .Range("E" & intRow - 1).Value <> "" Then
                    .Range("H" & intRow & ":H" & intRow + 4).Copy
                    wks_O1.Range("D17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
                    wks_O1.Range("D28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Launch Date
                    .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
                    wks_O1.Range("E28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Peak Share
                    .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
                    wks_O1.Range("I28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Months To Peak
                    .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
                    wks_O1.Range("G28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Curve Type
                    .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
                    wks_O1.Range("F28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Shares
                    .Range("N" & intRow & ":R" & intRow + 4).Copy
                    wks_O1.Range("D42").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("N" & intRow + 5 & ":R" & intRow + 9).Copy
                    wks_O1.Range("D52").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O1.Calculate
                    
                    wks_O1.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
                    .Range("G" & intRow + 11).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O1.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
                    .Range("G" & intRow + 16).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                End If
                intRow = intRow + 34
            Next intLoop
        End If
    End With
    With wks_O1
        .Range("Q16:" & wks_Vars.Range("J12").Value & 83).Clear
    End With
End Function
Function SteadyStateShareDynamics()
    Dim intRow As Integer
    Dim intLoop As Integer
    With wks_O1A_New
        .Range("P9").Value = wks_Vars.Range("J2").Value
        With .Range("Q9:" & wks_Vars.Range("J12").Value & 9)
            .Formula = "=DATE(YEAR(P9),MONTH(P9)+1,1)"
            .Calculate
            .Value = .Value
        End With
        
        .Range("P16:P83").Copy
        .Range("Q16:" & wks_Vars.Range("J12").Value & 83).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
    End With
    
    With wks_ForecastFlow
        intRow = wks_Vars.Range("EB21").Value
        'Starting Share
        .Range("H" & intRow & ":H" & intRow + 4).Copy
        wks_O1A_New.Range("D17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
        wks_O1A_New.Range("D28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Launch Date
        .Range("G" & intRow & ":G" & intRow + 4).Copy
        wks_O1A_New.Range("E17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
        wks_O1A_New.Range("E28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Peak Share
        .Range("I" & intRow & ":I" & intRow + 4).Copy
        wks_O1A_New.Range("I17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
        wks_O1A_New.Range("I28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Months To Peak
        .Range("J" & intRow & ":J" & intRow + 4).Copy
        wks_O1A_New.Range("G17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
        wks_O1A_New.Range("G28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Curve Type
        .Range("K" & intRow & ":K" & intRow + 4).Copy
        wks_O1A_New.Range("F17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
        wks_O1A_New.Range("F28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        
        wks_O1A_New.Calculate
        
        wks_O1A_New.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
        .Range("G" & intRow + 11).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O1A_New.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
        .Range("G" & intRow + 16).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 34
        
        If .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 2 Then
            For intLoop = 1 To 14
                If .Range("E" & intRow - 1).Value <> 0 Or .Range("E" & intRow - 1).Value <> "" Then
                    'Starting Share
                    .Range("H" & intRow & ":H" & intRow + 4).Copy
                    wks_O1A_New.Range("D17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
                    wks_O1A_New.Range("D28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Launch Date
                    .Range("G" & intRow & ":G" & intRow + 4).Copy
                    wks_O1A_New.Range("E17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
                    wks_O1A_New.Range("E28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Peak Share
                    .Range("I" & intRow & ":I" & intRow + 4).Copy
                    wks_O1A_New.Range("I17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
                    wks_O1A_New.Range("I28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Months To Peak
                    .Range("J" & intRow & ":J" & intRow + 4).Copy
                    wks_O1A_New.Range("G17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
                    wks_O1A_New.Range("G28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Curve Type
                    .Range("K" & intRow & ":K" & intRow + 4).Copy
                    wks_O1A_New.Range("F17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
                    wks_O1A_New.Range("F28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O1A_New.Calculate
                    
                    wks_O1A_New.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
                    .Range("G" & intRow + 11).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O1A_New.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
                    .Range("G" & intRow + 16).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                End If
                intRow = intRow + 34
            Next intLoop
        End If
    End With
    With wks_O1A_New
        .Range("Q16:" & wks_Vars.Range("J12").Value & 83).Clear
    End With
End Function
Function Sequenced_Share_Dynamics()
    Dim intRow As Integer
    Dim intLoop As Integer
    With wks_O3
        .Range("P9").Value = wks_Vars.Range("J2").Value
        With .Range("Q9:" & wks_Vars.Range("J12").Value & 9)
            .Formula = "=DATE(YEAR(P9),MONTH(P9)+1,1)"
            .Calculate
            .Value = .Value
        End With
        
        .Range("P16:P248").Copy
        .Range("Q16:" & wks_Vars.Range("J12").Value & 248).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
    End With
    
    With wks_ForecastFlow
        intRow = wks_Vars.Range("EB21").Value
        .Range("H" & intRow & ":H" & intRow + 4).Copy
        wks_O3.Range("D17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
        wks_O3.Range("D28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Launch Date
        .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
        wks_O3.Range("E28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Peak Share
        .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
        wks_O3.Range("I28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Months To Peak
        .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
        wks_O3.Range("G28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Curve Type
        .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
        wks_O3.Range("F28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Shares
        .Range("N" & intRow & ":R" & intRow + 4).Copy
        wks_O3.Range("D42").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("N" & intRow + 5 & ":R" & intRow + 9).Copy
        wks_O3.Range("D52").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O3.Calculate
        
        wks_O3.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
        .Range("G" & intRow + 11).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O3.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
        .Range("G" & intRow + 16).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 34
        
        If .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 2 Then
            For intLoop = 1 To 14
                If .Range("E" & intRow - 1).Value <> 0 Or .Range("E" & intRow - 1).Value <> "" Then
                    .Range("H" & intRow & ":H" & intRow + 4).Copy
                    wks_O3.Range("D17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
                    wks_O3.Range("D28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Launch Date
                    .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
                    wks_O3.Range("E28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Peak Share
                    .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
                    wks_O3.Range("I28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Months To Peak
                    .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
                    wks_O3.Range("G28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Curve Type
                    .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
                    wks_O3.Range("F28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Shares
                    .Range("N" & intRow & ":R" & intRow + 4).Copy
                    wks_O3.Range("D42").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("N" & intRow + 5 & ":R" & intRow + 9).Copy
                    wks_O3.Range("D52").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O3.Calculate
                    
                    wks_O3.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
                    .Range("G" & intRow + 11).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O3.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
                    .Range("G" & intRow + 16).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                End If
                intRow = intRow + 34
            Next intLoop
        End If
    End With
    With wks_O3
        .Range("Q16:" & wks_Vars.Range("J12").Value & 248).Clear
    End With
End Function
Function Share_Steal()
    Dim intRow As Integer
    Dim intLoop As Integer
    With wks_O2
        .Range("P9").Value = wks_Vars.Range("J2").Value
        With .Range("Q9:" & wks_Vars.Range("J12").Value & 9)
            .Formula = "=DATE(YEAR(P9),MONTH(P9)+1,1)"
            .Calculate
            .Value = .Value
        End With
        
        .Range("P16:P248").Copy
        .Range("Q16:" & wks_Vars.Range("J12").Value & 248).PasteSpecial xlPasteAll
        Application.CutCopyMode = False
    End With
    
    With wks_ForecastFlow
        intRow = wks_Vars.Range("EB21").Value
        .Range("H" & intRow & ":H" & intRow + 4).Copy
        wks_O2.Range("D17").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
        wks_O2.Range("D28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Launch Date
        .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
        wks_O2.Range("E28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Peak Share
        .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
        wks_O2.Range("I28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Months To Peak
        .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
        wks_O2.Range("G28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Curve Type
        .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
        wks_O2.Range("F28").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        'Shares
        .Range("N" & intRow & ":R" & intRow + 4).Copy
        wks_O2.Range("D42").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("N" & intRow + 5 & ":R" & intRow + 9).Copy
        wks_O2.Range("D52").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O2.Calculate
        
        wks_O2.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
        .Range("G" & intRow + 11).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        wks_O2.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
        .Range("G" & intRow + 16).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        intRow = intRow + 34
        
        If .Range("A" & wks_Vars.Range("EB21").Value - 7).Value = 2 Then
            For intLoop = 1 To 14
                If .Range("E" & intRow - 1).Value <> 0 Or .Range("E" & intRow - 1).Value <> "" Then
                    .Range("H" & intRow & ":H" & intRow + 4).Copy
                    wks_O2.Range("D17").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("H" & intRow + 5 & ":H" & intRow + 9).Copy
                    wks_O2.Range("D28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Launch Date
                    .Range("G" & intRow + 5 & ":G" & intRow + 9).Copy
                    wks_O2.Range("E28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Peak Share
                    .Range("I" & intRow + 5 & ":I" & intRow + 9).Copy
                    wks_O2.Range("I28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Months To Peak
                    .Range("J" & intRow + 5 & ":J" & intRow + 9).Copy
                    wks_O2.Range("G28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Curve Type
                    .Range("K" & intRow + 5 & ":K" & intRow + 9).Copy
                    wks_O2.Range("F28").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    'Shares
                    .Range("N" & intRow & ":R" & intRow + 4).Copy
                    wks_O2.Range("D42").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    .Range("N" & intRow + 5 & ":R" & intRow + 9).Copy
                    wks_O2.Range("D52").PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O2.Calculate
                    
                    wks_O2.Range("P17:" & wks_Vars.Range("J12").Value & 21).Copy
                    .Range("G" & intRow + 11).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                    
                    wks_O2.Range("P28:" & wks_Vars.Range("J12").Value & 32).Copy
                    .Range("G" & intRow + 16).PasteSpecial xlPasteValues
                    Application.CutCopyMode = False
                End If
                intRow = intRow + 34
            Next intLoop
        End If
    End With
    With wks_O2
        .Range("Q16:" & wks_Vars.Range("J12").Value & 248).Clear
    End With
End Function

Function Inline_Shares()
    Call Application_Event_Handler(False)
    Call Inline_Shares_1
    Call Application_Event_Handler(True)
End Function

Function Inline_Shares_1()
    Dim intRow As Integer
    Dim intRow1 As Integer
    Dim intRow2 As Integer
    Dim intLoop As Integer
    With wks_ForecastFlow
        intRow = wks_Vars.Range("EB21").Value + 11
        intRow1 = wks_Vars.Range("EB21").Value - 98
        intRow2 = wks_Vars.Range("EB21").Value - 2080
        For intLoop = 1 To 15
            .Range("G" & intRow).Formula = "=IFERROR(G" & intRow1 & "/G$" & intRow2 & ",0)"
            .Range("G" & intRow).Copy
            .Range("G" & intRow & ":" & wks_Vars.Range("J9").Value & intRow + 4).PasteSpecial xlPasteFormulas
            Application.CutCopyMode = False
            .Calculate
            .Range("G" & intRow & ":" & wks_Vars.Range("J9").Value & intRow + 4).Calculate
            .Range("G" & intRow & ":" & wks_Vars.Range("J9").Value & intRow + 4).Value = .Range("G" & intRow & ":" & wks_Vars.Range("J9").Value & intRow + 4).Value
            intRow = intRow + 34
            intRow1 = intRow1 + 6
            intRow2 = intRow2 + 1
        Next intLoop
        intRow = wks_Vars.Range("EB21").Value + 11
        intRow1 = wks_Vars.Range("EB21").Value
        For intLoop = 1 To 15
            .Range(wks_Vars.Range("J9").Value & intRow & ":" & wks_Vars.Range("J9").Value & intRow + 4).Copy
            .Range("H" & intRow1).PasteSpecial xlPasteValues
            Application.CutCopyMode = False
            intRow = intRow + 34
            intRow1 = intRow1 + 34
        Next intLoop
    End With
End Function
