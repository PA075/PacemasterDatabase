Attribute VB_Name = "mod_Pricing"
Option Explicit
 
Sub Price_Calculation()
Dim intRng As Integer, intCell As Integer, strRng As String, intComp As Integer, i As Integer
Dim intFrom As Integer, intRow As Integer
Call Application_Events_Handler(False)
'wks_Forecast.Shapes("shp_PleaseWait").Visible = msoCTrue
wks_Vars.Calculate
wks_Vars1.Calculate
intFrom = wks_Vars1.Range("T3").Value
intRng = 9 + wks_Vars.Range("N2").Value
''Call Back_Data
intCell = wks_M_List.Range("K" & intRng).Value
         'Incorrect date
    If wks_Vars.Range("M12").Value = "Incorrect Date" Then
        MsgBox "Please enter correct Generic Erosion date.", vbOKOnly
        Exit Sub
    End If

wks_Price.Activate
 
With wks_Price
    .Range("G1:NB1").EntireColumn.Hidden = False
    .Shapes("shp_price_hist").Visible = msoFalse
    .Shapes("shp_price_hist_1").Visible = msoFalse
    .Shapes("ChartPrice_hist_1").Visible = msoFalse
    .Shapes("shp_price_chart").Visible = msoFalse
        If wks_Forecast.Range("J113").Value = "" Then
            MsgBox "Provide launch date", vbOKOnly
            wks_Forecast.Activate
            Exit Sub
        End If
     If wks_M_List.Range("L" & intRng).Value = True Then
        If wks_Forecast.Range("L96").Value = "" Then
            MsgBox "Provide Generic Erosion date", vbOKOnly
            wks_Forecast.Activate
            Exit Sub
        End If
     End If
    
    If wks_M_List.Range("D" & intRng).Value = "Inline" Then
        .Range("A22:A60").EntireRow.Hidden = True
        .Range("A13:A23").EntireRow.Hidden = False
        .Shapes("DD_Month1").Visible = msoTrue
        .Shapes("TxtMonth1").Visible = msoTrue
        .Shapes("shp_price_hist").Visible = msoTrue
        .Shapes("Price_ApplyMaster1").Visible = msoTrue
        .Shapes("shp_price_chart").Visible = msoFalse
        .Shapes("DD_Month2").Visible = msoFalse
        .Shapes("TxtMonth2").Visible = msoFalse
        .Shapes("Price_ApplyMaster2").Visible = msoFalse
        .Shapes("TxtMonth3").Visible = msoFalse
        .Shapes("DD_Month3").Visible = msoFalse
        .Shapes("Price_ApplyMaster4").Visible = msoFalse
        .Shapes("TxtPrice_Select").Visible = msoFalse
        .Shapes("DD_Price_select").Visible = msoFalse
        .Shapes("shp_DD_Price").Visible = msoFalse
        .Shapes("shp_price_hist_1").Visible = msoTrue
        .Shapes("ChartPrice_hist_1").Visible = msoFalse
        .Shapes("TxtCompSelect").Visible = msoFalse
        .Shapes("DD_Price_Comp").Visible = msoFalse
        .Shapes("shp_Price_Comp").Visible = msoFalse
       
        If wks_M_List.Range("B8").Value = "TRx" Then
            .Range("G14:NB14").Formula = "=IFERROR(Generic_Forecast!G70/Generic_Forecast!G14,0)"
            .Range("F25:F39").Formula = "=G14"
        Else
            .Range("G14:NB14").Formula = "=IFERROR(Generic_Forecast!G70/Generic_Forecast!G50,0)"
            .Range("F25:F39").Formula = "=G50"
        End If
       
        .Range("G20:" & wks_Vars.Range("L2").Value & 20).Formula = "=G14"
        .Range(wks_Vars.Range("L2").Value & 20 & ":" & "IL" & 20).Formula = "=" & wks_Vars.Range("K2").Value & "20*(1+" & wks_Vars.Range("L2").Value & "18)"
    Else
        .Range("A13:A23").EntireRow.Hidden = True
        .Range("A24:A60").EntireRow.Hidden = False
        .Range("A24:A39").EntireRow.Hidden = True
        .Range("A24:A" & intCell + 24).EntireRow.Hidden = False
        .Shapes("DD_Month1").Visible = msoFalse
        .Shapes("TxtMonth1").Visible = msoFalse
        .Shapes("Price_ApplyMaster1").Visible = msoFalse
        .Shapes("shp_price_hist").Visible = msoFalse
        .Shapes("DD_Month2").Visible = msoTrue
        .Shapes("TxtMonth2").Visible = msoTrue
        .Shapes("Price_ApplyMaster2").Visible = msoTrue
        .Shapes("shp_price_chart").Visible = msoTrue
        .Shapes("TxtMonth3").Visible = msoTrue
        .Shapes("DD_Month3").Visible = msoTrue
        .Shapes("Price_ApplyMaster4").Visible = msoTrue
        .Shapes("TxtPrice_Select").Visible = msoTrue
        .Shapes("DD_Price_select").Visible = msoTrue
        .Shapes("shp_DD_Price").Visible = msoTrue
        .Shapes("shp_price_hist_1").Visible = msoFalse
        .Shapes("ChartPrice_hist_1").Visible = msoFalse
        .Shapes("TxtCompSelect").Visible = msoTrue
        .Shapes("DD_Price_Comp").Visible = msoTrue
        .Shapes("shp_Price_Comp").Visible = msoTrue
       
        If wks_M_List.Range("B8").Value = "TRx" Then
            .Range("G25:NB40").Formula = "=IFERROR(Generic_Forecast!G70/Generic_Forecast!G14,0)"
        Else
            .Range("G25:NB40").Formula = "=IFERROR(Generic_Forecast!G70/Generic_Forecast!G50,0)"
        End If
        Call Copy_Paste_Values(.Range("G25:" & wks_Vars.Range("K4").Value & "40"), .Range("G25:" & wks_Vars.Range("K4").Value & "40"))
        .Range("F25:F39").Formula = "=Generic_Forecast!F50"
        intRng = 9 + wks_Vars.Range("N2").Value
        intComp = wks_M_List.Range("K" & intRng).Value
        wks_Vars.Range("A26:A" & intComp + 26).Value = wks_Forecast.Range("F14:F" & intComp + 13).Value
        wks_Vars.Range("A26:A" & intComp + 26).Value = wks_Forecast.Range("F50:F" & intComp + 49).Value
        wks_Vars.Range("A" & intComp + 26).Value = "Total Market"
        wks_Vars.Range("A" & intComp + 27).Value = "Manual"
       
        'strRng = "Vars!" & wks_Vars.Range("A26:A" & intCell + 27).Address
        With wks_Price.Shapes("DD_Price_Comp").ControlFormat
            .RemoveAllItems
            For i = 1 To intComp
                .AddItem wks_Forecast.Range("F" & 49 + i).Value
            Next i
            .AddItem "Total Market"
            If wks_M_List.Range("L" & intRng).Value Then
                .AddItem "WAC Price"
            Else
            End If
            .LinkedCell = "Vars!$N$20"
            .DropDownLines = 15
        End With
        If wks_Penetration_Type.Range("RP" & wks_Vars1.Range("O4").Value).Value = "" Or wks_Penetration_Type.Range("RP" & wks_Vars1.Range("O4").Value).Value = 0 Then wks_Penetration_Type.Range("RP" & wks_Vars1.Range("O4").Value).Value = 1
        wks_Vars.Range("N20").Value = wks_Penetration_Type.Range("RP" & wks_Vars1.Range("O4").Value).Value
        If wks_Penetration_Type.Range("RP" & wks_Vars1.Range("O4").Value).Value > wks_Price.Shapes("DD_Price_Comp").ControlFormat.ListCount Then
            wks_Penetration_Type.Range("RP" & wks_Vars1.Range("O4").Value).Value = wks_Price.Shapes("DD_Price_Comp").ControlFormat.ListCount
        End If
        'Brand
        If wks_M_List.Range("L" & intRng).Value = True Then
            .Range("A41").EntireRow.Hidden = False
            .Range("F54").Value = "First Generic Launch Price"
        Else
            .Range("A41").EntireRow.Hidden = True
            .Range("F54").Value = "Launch Price"
            .Range("A46:A54").EntireRow.Hidden = True
            .Shapes("TxtMonth2").Visible = msoFalse
            .Shapes("DD_Month2").Visible = msoFalse
            .Shapes("Price_ApplyMaster2").Visible = msoFalse
        End If
   
        .Range(wks_Vars.Range("L4").Value & 1 & ":NB1").EntireColumn.Hidden = True
    End If
End With
With wks_Penetration_Type
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
End With
With wks_Backup_Data
    intRow = wks_Vars1.Range("T3").Value
    
    .Range("E" & intRow + 8 & ":MZ" & intRow + 8).Copy
    wks_Price.Range("G18:NB18").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    .Range("E" & intRow + 9 & ":MZ" & intRow + 9).Copy
    wks_Price.Range("G41:NB41").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    .Range("E" & intRow + 10 & ":MZ" & intRow + 10).Copy
    wks_Price.Range("G49:NB49").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    .Range("E" & intRow + 11 & ":MZ" & intRow + 11).Copy
    wks_Price.Range("G52:NB52").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    .Range("E" & intRow + 12 & ":MZ" & intRow + 12).Copy
    wks_Price.Range("G58:NB58").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    
    .Range("E" & intRow + 14 & ":MZ" & intRow + 14).Copy
    wks_Price.Range("G54:NB54").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
End With
wks_Price.Activate
Call Select_Comopitetor
Call Price_selection
Call Application_Events_Handler(True)
wks_Price.Range("C10").Select
wks_Price.Range("C12").Select
End Sub
 
Sub Apply_Master_Month_Change() 'For market price change
    Dim intFrom As Integer, intLoop As Integer
    Dim intMatch As Integer
    intFrom = 18
    intMatch = wks_Vars.Range("N15").Value '
    Call Application_Events_Handler(False)
    With wks_Price
        .Range("G18:NB18").ClearContents
        For intLoop = wks_Vars.Range("L6").Value To wks_Vars.Range("L8").Value
            If intMatch = Month(wks_Price.Cells(10, intLoop).Value) Then
                wks_Price.Cells(intFrom, intLoop).Value = .Range("E18").Value
            End If
        Next intLoop
    End With
    Call Application_Events_Handler(True)
End Sub
 
Function Save_ContinuePricing()        'For Pricing
Dim intRng As Integer, intRow As Integer
intRng = 9 + wks_Vars.Range("N2").Value
 
    If wks_M_List.Range("D" & intRng).Value = "Inline" Then
        Call Copy_Paste_Values(wks_Price.Range("G20:" & wks_Vars.Range("K4").Value & "20"), wks_Forecast.Range("G150:" & wks_Vars.Range("K4").Value & "150"))
    Else
        If wks_M_List.Range("L" & intRng).Value = False Then
            Call Copy_Paste_Values(wks_Price.Range("" & wks_Vars.Range("K10").Value & "60:" & wks_Vars.Range("K4").Value & "60"), wks_Forecast.Range("" & wks_Vars.Range("K10").Value & "150:" & wks_Vars.Range("K4").Value & "150"))
        Else
             Call Copy_Paste_Values(wks_Price.Range("" & wks_Vars.Range("K10").Value & "60:" & wks_Vars.Range("K4").Value & "60"), wks_Forecast.Range("" & wks_Vars.Range("K10").Value & "150:" & wks_Vars.Range("K4").Value & "150"))
        End If
    End If
    
    With wks_Penetration_Type
        .Range("RO" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N18").Value
        .Range("RP" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N20").Value
        .Range("RQ" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N34").Value
        .Range("RR" & wks_Vars1.Range("O9").Value).Value = wks_Vars.Range("N15").Value
    End With
    
    With wks_Backup_Data
        intRow = wks_Vars1.Range("S3").Value
        
        wks_Price.Range("F18:NB18").Copy
        .Range("D" & intRow + 8).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("D" & intRow + 8).Value = "Historical MasterInput"
        
        wks_Price.Range("F41:NB41").Copy
        .Range("D" & intRow + 9).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("D" & intRow + 9).Value = "WAC Price"
        
        wks_Price.Range("F49:NB49").Copy
        .Range("D" & intRow + 10).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("D" & intRow + 10).Value = "First MasterInput"
        
        wks_Price.Range("F52:NB52").Copy
        .Range("D" & intRow + 11).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("D" & intRow + 11).Value = "Discount Factor"
        
        wks_Price.Range("F58:NB58").Copy
        .Range("D" & intRow + 12).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("D" & intRow + 12).Value = "Second MasterInput"
        
        wks_Price.Range("F54:NB54").Copy
        .Range("D" & intRow + 14).PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        .Range("D" & intRow + 14).Value = "Launch Price"
    End With
   
    wks_Forecast.Activate
End Function
 
Function Price_selection()
Dim intRng As Integer
intRng = 9 + wks_Vars.Range("N2").Value
With wks_Price
    If wks_Vars.Range("N18").Value = 1 Then
        .Range("A44:A52").EntireRow.Hidden = True
        .Shapes("TxtMonth2").Visible = msoFalse
        .Shapes("DD_Month2").Visible = msoFalse
        '.Shapes("shp_Month2").Visible = msoFalse
        .Shapes("Price_ApplyMaster2").Visible = msoFalse
        .Range("G54").Interior.Color = RGB(255, 255, 204) 'DD_Price_Comp
        .Range("G54").Value = .Range("G54").Value
        .Range("G54").EntireRow.Hidden = False
        .Shapes("TxtCompSelect").Visible = msoFalse
        .Shapes("DD_Price_Comp").Visible = msoFalse
        .Shapes("shp_Price_Comp").Visible = msoFalse
        .Range("G60:NB60").Value = ""
        If wks_M_List.Range("L" & intRng).Value = False And wks_M_List.Range("D" & intRng).Value = "Inline" Then
            .Range(wks_Vars.Range("K16").Value & 60).Formula = "=G54"
            Application.CutCopyMode = False
            .Range(wks_Vars.Range("L16").Value & 60 & ":" & wks_Vars.Range("K4").Value & 60).Formula = "=" & wks_Vars.Range("K16").Value & "60*(1+" & wks_Vars.Range("L16").Value & "58)"
        Else
            .Range(wks_Vars.Range("K10").Value & 60).Formula = "=G54"
            Application.CutCopyMode = False
            .Range(wks_Vars.Range("L10").Value & 60 & ":" & wks_Vars.Range("K4").Value & 60).Formula = "=" & wks_Vars.Range("K10").Value & "60*(1+" & wks_Vars.Range("L10").Value & "58)"
        End If
    Else
        .Range("A44:A52").EntireRow.Hidden = False
        .Shapes("TxtMonth2").Visible = msoTrue
        .Shapes("DD_Month2").Visible = msoTrue
        '.Shapes("shp_Month2").Visible = msoTrue
        .Shapes("Price_ApplyMaster2").Visible = msoTrue
        .Shapes("TxtCompSelect").Visible = msoTrue
        .Shapes("DD_Price_Comp").Visible = msoTrue
        .Shapes("shp_Price_Comp").Visible = msoTrue
        .Range("G54").Interior.Color = RGB(255, 255, 255)
       
        'Row 50 formula
       
        .Range("G50:NB50").Value = ""
        .Range("G60:NB60").Value = ""
        If wks_M_List.Range("L" & intRng).Value = False Then
                .Range("G50:" & wks_Vars.Range("K2").Value & "50").Formula = "=G44"
                .Range(wks_Vars.Range("L2").Value & 50 & ":" & wks_Vars.Range("K4").Value & 50).Formula = "=" & wks_Vars.Range("K2").Value & "50*(1+" & wks_Vars.Range("L2").Value & "49)"
                .Range("G54").Formula = "=G52*" & wks_Vars.Range("K10").Value & "50"
        Else
                .Range("G50:" & wks_Vars.Range("K2").Value & "50").Formula = "=G44"
                .Range(wks_Vars.Range("L2").Value & 50 & ":" & wks_Vars.Range("K4").Value & 50).Formula = "=" & wks_Vars.Range("K2").Value & "50*(1+" & wks_Vars.Range("L2").Value & "49)"
                .Range("G54").Formula = "=G52*" & wks_Vars.Range("M12").Value & "50"
        End If
        
        'Row 60
        If wks_M_List.Range("L" & intRng).Value = False Then
                .Range(wks_Vars.Range("K10").Value & 60).Formula = "=G54"
                .Range(wks_Vars.Range("L10").Value & 60 & ":" & wks_Vars.Range("K4").Value & 60).Formula = "=" & wks_Vars.Range("K10").Value & "60*(1+" & wks_Vars.Range("L10").Value & "58)"
        Else
                .Range(wks_Vars.Range("M12").Value & 60).Formula = "=G54"
                Application.CutCopyMode = False
                .Range(wks_Vars.Range("L12").Value & 60 & ":" & wks_Vars.Range("K4").Value & 60).Formula = "=" & wks_Vars.Range("M12").Value & "60*(1+" & wks_Vars.Range("L12").Value & "58)"
        End If
    End If
    
        If wks_M_List.Range("D" & intRng).Value = "Inline" Then
               .Range("G54").EntireRow.Hidden = True
        End If
End With
End Function
 
Function Select_Comopitetor()
Dim intRng As Integer, intRng2 As Integer, intCell As Integer
Call Application_Events_Handler(False)
intRng2 = 9 + wks_Vars.Range("N2").Value
intCell = 3 + wks_M_List.Range("K" & intRng2).Value
intRng = 24 + wks_Vars.Range("N20").Value
    If intCell = wks_Vars.Range("N20").Value Then
        wks_Price.Range("G44:NB44").Interior.Color = RGB(255, 255, 204)
        wks_Price.Range("G44:NB44").ClearContents
    Else
        wks_Price.Range("G44:NB44").Interior.Color = RGB(255, 255, 255)
        Call Copy_Paste_Values(wks_Price.Range("G" & intRng & ":" & wks_Vars.Range("K4").Value & intRng), wks_Price.Range("G44:" & wks_Vars.Range("K4").Value & "44"))
''        wks_Price.Range("G44:NB44").Value = wks_Price.Range("G" & intRng & ":NB" & intRng).Value
        If 1 + wks_M_List.Range("K" & intRng2).Value = wks_Vars.Range("N20").Value Then
            Call Copy_Paste_Values(wks_Price.Range("G40:" & wks_Vars.Range("K4").Value & "40"), wks_Price.Range("G44:" & wks_Vars.Range("K4").Value & "44"))
''            wks_Price.Range("G44:NB44").Value = wks_Price.Range("G40:NB40").Value
        ElseIf 2 + wks_M_List.Range("K" & intRng2).Value = wks_Vars.Range("N20").Value Then
            Call Copy_Paste_Values(wks_Price.Range("G41:NB41"), wks_Price.Range("G44:" & wks_Vars.Range("K4").Value & "44"))
       
        End If
    End If
Call Application_Events_Handler(True)
End Function
 
Sub Apply_Master_Month_Change2() 'For market price change
Dim intFrom As Integer, intLoop As Integer
Dim intMatch As Integer, intRng As Integer
Application.CutCopyMode = False
Call Application_Events_Handler(False)
wks_Vars.Calculate
intRng = 9 + wks_Vars.Range("N2").Value
intFrom = 49
intMatch = wks_Vars.Range("N15").Value
With wks_Price
    .Range("G49:NB49").ClearContents
    For intLoop = wks_Vars.Range("K6").Value To wks_Vars.Range("L8").Value
        If intMatch = Month(wks_Price.Cells(10, intLoop).Value) Then
            wks_Price.Cells(intFrom, intLoop).Value = .Range("E49").Value
        End If
    Next intLoop
End With
Call Application_Events_Handler(True)
End Sub
 
Sub Apply_Master_Month_Change3() 'For market price change
Dim intFrom As Integer, intLoop As Integer
Dim intMatch As Integer
Dim intRng As Integer
Application.CutCopyMode = False
Call Application_Events_Handler(False)
intFrom = 58
intRng = 9 + wks_Vars.Range("N2").Value
intMatch = wks_Vars.Range("N34").Value
With wks_Price
    .Range("G58:NB58").ClearContents
'    .Range("G60:NB60").ClearContents
    If wks_M_List.Range("L" & intRng).Value = False Then
        For intLoop = wks_Vars.Range("L17").Value To wks_Vars.Range("L8").Value
            If intMatch = Month(wks_Price.Cells(10, intLoop).Value) Then
                wks_Price.Cells(intFrom, intLoop).Value = .Range("E58").Value
            End If
        Next intLoop
    Else
        For intLoop = wks_Vars.Range("L11").Value To wks_Vars.Range("L8").Value
            If intMatch = Month(wks_Price.Cells(10, intLoop).Value) Then
                wks_Price.Cells(intFrom, intLoop).Value = .Range("E58").Value
            End If
        Next intLoop
    End If
End With
Call Application_Events_Handler(True)
End Sub
