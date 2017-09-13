Attribute VB_Name = "mod_Backup"
Option Explicit

Function Back_Data()
    Dim intRow As Integer, intLoop As Integer
    wks_Vars1.Calculate
    wks_Vars1.Range("N1").Value = wks_Vars.Range("B18").Value
    wks_Vars1.Range("N2").Value = wks_Vars.Range("B20").Value
    wks_Vars1.Range("N3").Value = wks_Vars.Range("B22").Value
    
    wks_Vars1.Range("N6").Value = wks_Vars.Range("E18").Value
    wks_Vars1.Range("N7").Value = wks_Vars.Range("E20").Value
    wks_Vars1.Range("N8").Value = wks_Vars.Range("E22").Value
    wks_Vars1.Calculate
    
    If wks_Vars1.Range("O9").Value = 0 Then Exit Function
        
    With wks_Historical
        intRow = wks_Vars1.Range("S2").Value
        .Range("A" & intRow & ":A" & intRow + 63).Value = wks_Vars1.Range("O6").Value
        .Range("B" & intRow & ":B" & intRow + 63).Value = wks_Vars1.Range("O7").Value
        .Range("C" & intRow & ":C" & intRow + 63).Value = wks_Vars1.Range("O8").Value
        'Producy type
        .Range("NB" & intRow & ":NB" & intRow + 63).Value = wks_M_List.Range("D" & wks_Vars1.Range("N1").Value + 9).Value
        .Range("D" & intRow & ":D" & intRow + 15).Value = "Market TRx"
        .Range("D" & intRow + 16 & ":D" & intRow + 31).Value = "Conversion Factor"
        .Range("D" & intRow + 32 & ":D" & intRow + 47).Value = "Market Units"
        .Range("D" & intRow + 48 & ":D" & intRow + 63).Value = "Market Dollars"
        .Range("D" & intRow + 48 + 16 & ":D" & intRow + 48 + 16 + 14).Value = "Modification Factor"
        
        wks_Forecast.Range("F14:NB29").Copy
        .Range("E" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F32:NB47").Copy
        .Range("E" & intRow + 16).PasteSpecial xlPasteValues
         Application.CutCopyMode = False
        wks_Forecast.Range("F50:NB65").Copy
        .Range("E" & intRow + 32).PasteSpecial xlPasteValues
         Application.CutCopyMode = False
        wks_Forecast.Range("F70:NB85").Copy
        .Range("E" & intRow + 48).PasteSpecial xlPasteValues
         Application.CutCopyMode = False
         wks_Trending.Range("F34:NB49").Copy
         .Range("E" & intRow + 48 + 16).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
    End With
    
    With wks_Backup_Data
        intRow = wks_Vars1.Range("S3").Value
        .Range("A" & intRow & ":A" & intRow + 15).Value = wks_Vars1.Range("O6").Value
        .Range("B" & intRow & ":B" & intRow + 15).Value = wks_Vars1.Range("O7").Value
        .Range("C" & intRow & ":C" & intRow + 15).Value = wks_Vars1.Range("O8").Value
        'Producy type
        .Range("RQ" & intRow & ":RQ" & intRow + 15).Value = wks_M_List.Range("D" & wks_Vars1.Range("N1").Value + 9).Value
        
        wks_Forecast.Range("F91:NB91").Copy
        .Range("D" & intRow).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F150:NB150").Copy
        .Range("D" & intRow + 1).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F153:NB153").Copy
        .Range("D" & intRow + 2).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F156:NB156").Copy
        .Range("D" & intRow + 3).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F160:NB160").Copy
        .Range("D" & intRow + 4).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F162:NB162").Copy
        .Range("D" & intRow + 5).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F164:NB164").Copy
        .Range("D" & intRow + 6).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F166:NB166").Copy
        .Range("D" & intRow + 7).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Trending.Range("F347:NB347").Copy
        .Range("D" & intRow + 13).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Forecast.Range("F108:NB108").Copy
        .Range("D" & intRow + 15).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
    End With
    
''    With wks_PackData
''        intRow = wks_Vars1.Range("S4").Value
''        .Range("A" & intRow & ":A" & intRow + 44).Value = wks_Vars1.Range("O6").Value
''        .Range("B" & intRow & ":B" & intRow + 44).Value = wks_Vars1.Range("O7").Value
''        .Range("C" & intRow & ":C" & intRow + 44).Value = wks_Vars1.Range("O8").Value
''        .Range("RR" & intRow & ":RR" & intRow + 44).Value = wks_Vars.Range("Q9").Value
''        .Range("D" & intRow & ":D" & intRow + 14).Value = "Split%"
''        .Range("D" & intRow + 15 & ":D" & intRow + 29).Value = "Price"
''        .Range("D" & intRow + 30 & ":D" & intRow + 44).Value = "GTN"
''        wks_Forecast.Range("F172:NB186").Copy
''        .Range("E" & intRow).PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
''        wks_Forecast.Range("F206:NB220").Copy
''        .Range("E" & intRow + 15).PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
''        wks_Forecast.Range("F223:NB237").Copy
''        .Range("E" & intRow + 30).PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
''    End With
    
    With wks_Events
        intRow = wks_Vars1.Range("S5").Value
        .Range("A" & intRow & ":A" & intRow + 15).Value = wks_Vars1.Range("O6").Value
        .Range("B" & intRow & ":B" & intRow + 15).Value = wks_Vars1.Range("O7").Value
        .Range("C" & intRow & ":C" & intRow + 15).Value = wks_Vars1.Range("O8").Value
        .Range("D" & intRow & ":D" & intRow + 9).Value = "Event1"
        .Range("D" & intRow + 10).Value = "Event2"
        .Range("D" & intRow + 11 & ":D" & intRow + 15).Value = "Event3"
        
        wks_Forecast.Range("F121:M130").Copy
        .Range("E" & intRow).PasteSpecial xlPasteValuesAndNumberFormats
        Application.CutCopyMode = False
        If wks_Vars.Range("Q8").Value = 1 Then
            .Range("M" & intRow & ":M" & intRow + 9).Value = wks_Vars.Range("Q8").Value - 1
        Else
            .Range("M" & intRow & ":M" & intRow + 9).Value = wks_Vars.Range("Q8").Value - 1
        End If
        For intLoop = 0 To 9
            .Range("N" & intRow + intLoop).Value = intLoop + 1
        Next intLoop
        
        wks_Forecast.Range("G113:K113").Copy
        .Range("H" & intRow + 10).PasteSpecial xlPasteValuesAndNumberFormats
        Application.CutCopyMode = False
        .Range("E" & intRow + 10).Value = "Penetration"
        .Range("M" & intRow + 10).Value = 1
        .Range("N" & intRow + 10).Value = 1
        wks_Forecast.Range("F95:M99").Copy
        .Range("E" & intRow + 11).PasteSpecial xlPasteValuesAndNumberFormats
        Application.CutCopyMode = False
        If wks_Vars.Range("Q7").Value = 0 Then
            .Range("M" & intRow + 11 & ":M" & intRow + 15).Value = wks_Vars.Range("Q7").Value
        Else
            .Range("M" & intRow + 11 & ":M" & intRow + 15).Value = wks_Vars.Range("Q7").Value - 1
        End If
         For intLoop = 0 To 4
            .Range("N" & intRow + 11 + intLoop).Value = intLoop + 1
        Next intLoop
    End With
    With wks_Penetration_Type
        wks_Forecast.Range("G114:NB114").Copy
        .Range("C" & wks_Vars1.Range("O9").Value).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("RO" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N18").Value
        .Range("RP" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N20").Value
        .Range("RQ" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N34").Value
        .Range("RR" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N15").Value
        
        .Range("RS" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("B41").Value
        .Range("RT" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("D41").Value
    End With
    
    With wks_Previous
        .Range("B1").Value = wks_Vars1.Range("N1").Value
        .Range("B2").Value = wks_Vars1.Range("N2").Value
        .Range("B3").Value = wks_Vars1.Range("N3").Value
    End With
End Function

Function Save_Retrive()
    Dim intRow As Integer
    With wks_Historical
        intRow = wks_Vars1.Range("T2").Value
        .Range("E" & intRow & ":NA" & intRow + 14).Copy
        wks_Forecast.Range("F14:NB29").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("E" & intRow + 16 & ":NA" & intRow + 30).Copy
        wks_Forecast.Range("F32:NB47").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("E" & intRow + 32 & ":NA" & intRow + 46).Copy
        wks_Forecast.Range("F50:NB65").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("F" & intRow + 48 & ":NA" & intRow + 62).Copy
        wks_Forecast.Range("G70:NB85").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("F" & intRow + 48 + 16 & ":NA" & intRow + 48 + 16 + 14).Copy
        wks_Trending.Range("G34:NB49").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
    End With
    
    With wks_Backup_Data
        intRow = wks_Vars1.Range("T3").Value
        'clear trending data & uptake
        wks_Forecast.Range("G91:NB91").ClearContents
        wks_Forecast.Range("L113:M113").ClearContents
        .Range("E" & intRow & ":MZ" & intRow).Copy
        wks_Forecast.Range("G91:NB91").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        'PASTING IN TRENDING SHEET
        .Range("E" & intRow & ":MZ" & intRow).Copy
        wks_Trending.Range("G333").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("E" & intRow & ":MZ" & intRow).Copy
        wks_Trending.Range("G335").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("E" & intRow + 1 & ":MZ" & intRow + 1).Copy
        wks_Forecast.Range("G150:NB150").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("E" & intRow + 2 & ":MZ" & intRow + 2).Copy
        wks_Forecast.Range("G153:NB153").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("E" & intRow + 3 & ":MZ" & intRow + 3).Copy
        wks_Forecast.Range("G156:NB156").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        .Range("E" & intRow + 13 & ":MZ" & intRow + 13).Copy
        wks_Trending.Range("G347:NB347").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
    End With
    
''    With wks_PackData
''        intRow = wks_Vars1.Range("T4").Value
''        .Range("E" & intRow & ":NA" & intRow + 14).Copy
''        wks_Forecast.Range("F172:NB186").PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
''        .Range("E" & intRow + 15 & ":NA" & intRow + 29).Copy
''        wks_Forecast.Range("F206:NB220").PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
''        .Range("E" & intRow + 30 & ":NA" & intRow + 44).Copy
''        wks_Forecast.Range("F223:NB237").PasteSpecial xlPasteValues
''        Application.CutCopyMode = False
''    End With
    
    With wks_Events
        intRow = wks_Vars1.Range("T5").Value
        .Range("E" & intRow & ":L" & intRow + 9).Copy
        wks_Forecast.Range("F121:M130").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Vars.Range("Q8").Value = .Range("M" & intRow).Value + 1
        .Range("H" & intRow + 10 & ":L" & intRow + 10).Copy
        wks_Forecast.Range("G113:K113").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("E" & intRow + 11 & ":L" & intRow + 15).Copy
        wks_Forecast.Range("F95:M99").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        If .Range("M" & intRow + 11).Value <> "" Then
            wks_Vars.Range("Q7").Value = .Range("M" & intRow + 11).Value + 1
        Else
            wks_Vars.Range("Q7").Value = 3
        End If
    End With
    With wks_Penetration_Type
        .Range("C" & wks_Vars1.Range("O4").Value & ":RN" & wks_Vars1.Range("O4").Value).Copy
        wks_Forecast.Range("G114").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        
        If .Range("RO" & wks_Vars1.Range("O4").Value).Value = "" Or .Range("RO" & wks_Vars1.Range("O4").Value).Value = 0 Then .Range("RO" & wks_Vars1.Range("O4").Value).Value = 1
        If .Range("RP" & wks_Vars1.Range("O4").Value).Value = "" Or .Range("RP" & wks_Vars1.Range("O4").Value).Value = 0 Then .Range("RP" & wks_Vars1.Range("O4").Value).Value = 1
        If .Range("RQ" & wks_Vars1.Range("O4").Value).Value = "" Or .Range("RQ" & wks_Vars1.Range("O4").Value).Value = 0 Then .Range("RQ" & wks_Vars1.Range("O4").Value).Value = 1
        If .Range("RR" & wks_Vars1.Range("O4").Value).Value = "" Or .Range("RR" & wks_Vars1.Range("O4").Value).Value = 0 Then .Range("RR" & wks_Vars1.Range("O4").Value).Value = 1
        If .Range("RS" & wks_Vars1.Range("O4").Value).Value = "" Or .Range("RS" & wks_Vars1.Range("O4").Value).Value = 0 Then .Range("RS" & wks_Vars1.Range("O4").Value).Value = 1
        If .Range("RT" & wks_Vars1.Range("O4").Value).Value = "" Or .Range("RT" & wks_Vars1.Range("O4").Value).Value = 0 Then .Range("RT" & wks_Vars1.Range("O4").Value).Value = 1
        
        wks_Vars.Range("N18").Value = .Range("RO" & wks_Vars1.Range("O4").Value).Value
        wks_Vars.Range("N20").Value = .Range("RP" & wks_Vars1.Range("O4").Value).Value
        wks_Vars.Range("N34").Value = .Range("RQ" & wks_Vars1.Range("O4").Value).Value
        wks_Vars.Range("N15").Value = .Range("RR" & wks_Vars1.Range("O4").Value).Value
        
        wks_Vars.Range("B41").Value = .Range("RS" & wks_Vars1.Range("O4").Value).Value
        wks_Vars.Range("D41").Value = .Range("RT" & wks_Vars1.Range("O4").Value).Value
    End With
    Call No_Events_Actual
    Call Event_Erosion_actual
End Function
