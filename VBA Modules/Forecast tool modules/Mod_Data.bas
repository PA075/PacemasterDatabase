Attribute VB_Name = "Mod_Data"
''Option Explicit

Function Create_Forecast_Generic()
    frm_Generic.Show
End Function

Function Create_Forecast_Generic_Edit()
    frm_Generic_Edit.Show
End Function

Function ScrollToSection()
    Dim finalNumber As Integer
    finalNumber = Workbooks(1).Worksheets("SPDocLib").Cells(1, 4).Value
    Call WakeupWorkbook
    ActiveWindow.ScrollRow = finalNumber
End Function

Function WakeupWorkbook()
    Workbooks(1).Activate
    Workbooks(1).Worksheets("Generic_Forecast").Select
End Function

Function InitializeDisplay()
On Error Resume Next
    Workbooks(1).Activate
    Workbooks(1).Worksheets("Generic_Forecast").Select
    ActiveWindow.DisplayHeadings = False
    ActiveWindow.DisplayWorkbookTabs = False
    ActiveWindow.DisplayHorizontalScrollBar = True
    ActiveWindow.DisplayVerticalScrollBar = True
End Function

Function Scenario_DropDown_Message()
    Dim intRow As Integer
    Dim strRange As String
    wks_Vars1.Calculate
    intRow = wks_Vars1.Range("O15").Value
    
    If intRow = 0 Then
        Scenario_DropDown_Message = 0
        Exit Function
    End If
    If wks_Vars1.Range("N13").Value = 1 Then
        Scenario_DropDown_Message = 0
        Exit Function
    End If
    strRange = "E" & intRow & ":RP" & intRow + 15
    If Application.WorksheetFunction.Sum(wks_Backup_Data.Range(strRange)) = 0 Then
        Scenario_DropDown_Message = 1
    Else
        Scenario_DropDown_Message = 0
    End If
End Function

Function Drop_Down_Change()
Dim intRng2 As Integer
Dim intProdSelct As Integer, intRng As Integer, intSKU As Integer
    Dim intProdSelct2 As Integer, intProdSelct3 As Integer
Application_Events_Handler (False)
wks_Forecast.Unprotect
wks_Vars.Calculate
intRng2 = 9 + wks_Vars.Range("N2").Value
    intRng = 9 + wks_Vars.Range("N2").Value
    intSKU = wks_M_List.Range("I" & intRng).Value
    wks_Vars.Range("Q1").Value = intSKU
    wks_Vars.Calculate
    wks_Vars.Range("J1").Value = wks_Vars.Range("P3").Value
    wks_Vars.Range("B18").Value = wks_Vars.Range("N2").Value
    wks_Vars.Range("B20").Value = wks_Vars.Range("N3").Value
    wks_Vars.Range("B22").Value = wks_Vars.Range("N4").Value
    intProdSelct = wks_Vars.Range("B18").Value
    intProdSelct2 = wks_Vars.Range("B20").Value
    intProdSelct3 = wks_Vars.Range("B22").Value
    wks_Vars.Range("O1").Value = wks_Vars.Range("E18").Value
        
    Call Back_Data
    
    wks_Vars.Range("E18").Value = intProdSelct
    wks_Vars.Range("E20").Value = intProdSelct2
    wks_Vars.Range("E22").Value = intProdSelct3
    
    wks_Vars1.Range("N6").Value = intProdSelct
    wks_Vars1.Range("N7").Value = intProdSelct2
    wks_Vars1.Range("B8").Value = intProdSelct3
    
    If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
        ''wks_Forecast.Range("F14").Value = wks_Vars.Range("P2").Value
       '' wks_Forecast.Range("F50").Value = wks_Vars.Range("P2").Value
        wks_Forecast.Range("F14").Interior.Color = RGB(255, 255, 255)
        wks_Forecast.Range("F50").Interior.Color = RGB(255, 255, 255)
''        wks_Forecast.Shapes("shp_Share_Trend").Visible = msoTrue
        Call BDL_Inline_Hide_Unhide
        Call BDL_Inline_Formula
    Else
        wks_Forecast.Range("F14").Interior.Color = RGB(255, 255, 204)
        wks_Forecast.Range("F50").Interior.Color = RGB(255, 255, 204)
        Call BDL_Pipeline_Hide_Unhide
        Call BDL_Pipeline_Formula
    End If
    
    'Call Data_Clear
    Call Save_Retrive
    Call For_Total_Selection
    
    wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    'Penetration type
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
       wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1
    End If
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1 Or wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
        If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
          wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        Else
          wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        End If
    ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 3 Then
        wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 2 Then
        wks_Forecast.Range("G114:" & wks_Vars.Range("K2").Value & 114).Formula = "=G67"
        wks_Forecast.Range("" & wks_Vars.Range("L2").Value & 114 & ":NB114").Interior.Color = RGB(255, 255, 204)
    End If
    
    wks_Vars.Range("M33").Value = wks_Vars.Range("D22").Value
    wks_Trending.Range("A89:A326").EntireRow.Hidden = True
    wks_Forecast.Range("A90:A93").EntireRow.Hidden = False
    wks_Forecast.Range("A109").EntireRow.Hidden = True
    wks_Forecast.Range("F101").Value = "Evented Shares"
    wks_Forecast.Range("F102:F106").Formula = "=if(F95="""","""",F95)"
    wks_Forecast.Range("F108").Value = "Available Market Units"
    
    Call Case_Message
    
    wks_Forecast.Activate
If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Application_Events_Handler (True)
End Function

Function Drop_Down_Product()
Dim intRng2 As Integer
Dim intProdSelct As Integer, intRng As Integer, intSKU As Integer
    Dim intProdSelct2 As Integer, intProdSelct3 As Integer
Application_Events_Handler (False)
wks_Forecast.Unprotect
wks_Vars.Calculate
intRng2 = 9 + wks_Vars.Range("N2").Value
    intRng = 9 + wks_Vars.Range("N2").Value
    intSKU = wks_M_List.Range("I" & intRng).Value
    wks_Vars.Range("Q1").Value = intSKU
    wks_Vars.Calculate
    wks_Vars.Range("J1").Value = wks_Vars.Range("P3").Value
    wks_Vars.Range("B18").Value = wks_Vars.Range("N2").Value
    wks_Vars.Range("B20").Value = wks_Vars.Range("N3").Value
    wks_Vars.Range("B22").Value = wks_Vars.Range("N4").Value
    intProdSelct = wks_Vars.Range("B18").Value
    intProdSelct2 = wks_Vars.Range("B20").Value
    intProdSelct3 = wks_Vars.Range("B22").Value
    wks_Vars.Range("O1").Value = wks_Vars.Range("E18").Value
    
    'wks_Forecast.Shapes("Drp_SKU").Visible = msoFalse
    'wks_Forecast.Shapes("TxtSKU").Visible = msoFalse
    
    If wks_M_List.Range("H" & intRng).Value = True Then
        'wks_Forecast.Shapes("Drp_SKU").Visible = msoFalse
        'wks_Forecast.Shapes("TxtSKU").Visible = msoFalse
        wks_Forecast.Range("C168").Value = "Pack Split"
        wks_Vars.Range("P5").Value = wks_Vars.Range("P3").Value
        Call SKU_Rnange_DropDwon
    Else
'    wks_Vars.Range("E20").Value = wks_Vars.Range("E18").Value
        wks_Vars.Range("E20").Value = 1
        wks_Vars.Range("N3").Value = 1
    End If
        
    Call Back_Data
    
    wks_Vars.Range("E18").Value = intProdSelct
    wks_Vars.Range("E20").Value = intProdSelct2
    wks_Vars.Range("E22").Value = intProdSelct3
    
    If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
        ''wks_Forecast.Range("F14").Value = wks_Vars.Range("P2").Value
       '' wks_Forecast.Range("F50").Value = wks_Vars.Range("P2").Value
        wks_Forecast.Range("F14").Interior.Color = RGB(255, 255, 255)
        wks_Forecast.Range("F50").Interior.Color = RGB(255, 255, 255)
''        wks_Forecast.Shapes("shp_Share_Trend").Visible = msoTrue
        Call BDL_Inline_Hide_Unhide
        Call BDL_Inline_Formula
    Else
        wks_Forecast.Range("F14").Interior.Color = RGB(255, 255, 204)
        wks_Forecast.Range("F50").Interior.Color = RGB(255, 255, 204)
        Call BDL_Pipeline_Hide_Unhide
        Call BDL_Pipeline_Formula
    End If
    
    'Call Data_Clear
    Call Save_Retrive
    Call For_Total_Selection
    
    wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1 Or wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
        If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
          wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        Else
          wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        End If
    ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 3 Then
        wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 2 Then
        wks_Forecast.Range("G114:" & wks_Vars.Range("K2").Value & 114).Formula = "=G67"
        wks_Forecast.Range("" & wks_Vars.Range("L2").Value & 114 & ":NB114").Interior.Color = RGB(255, 255, 204)
    End If
    
    wks_Vars.Range("M33").Value = wks_Vars.Range("D22").Value
    wks_Trending.Range("A89:A326").EntireRow.Hidden = True
    wks_Forecast.Range("A90:A93").EntireRow.Hidden = False
    wks_Forecast.Range("A109").EntireRow.Hidden = True
    wks_Forecast.Range("F101").Value = "Evented Shares"
    wks_Forecast.Range("F102:F106").Formula = "=if(F95="""","""",F95)"
    wks_Forecast.Range("F108").Value = "Available Market Units"
    'Penetration type
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
       wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1
    End If
    wks_Forecast.Activate
If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Application_Events_Handler (True)
End Function

Function Drop_Down_Product_2()
Application.ScreenUpdating = False
wks_Forecast.Unprotect
    Dim intProdSelct As Integer, intRng As Integer, intSKU As Integer
    Dim intProdSelct2 As Integer, intProdSelct3 As Integer
    intRng = 9 + wks_Vars.Range("N2").Value
    intSKU = wks_M_List.Range("I" & intRng).Value
    wks_Vars.Range("Q1").Value = intSKU
    intProdSelct = wks_Vars.Range("B18").Value
    intProdSelct2 = wks_Vars.Range("B20").Value
    intProdSelct3 = wks_Vars.Range("B22").Value
    wks_Vars.Range("O1").Value = wks_Vars.Range("E18").Value
    
    'wks_Forecast.Shapes("Drp_SKU").Visible = msoFalse
    'wks_Forecast.Shapes("TxtSKU").Visible = msoFalse
    
    If wks_M_List.Range("H" & intRng).Value = True Then
        'wks_Forecast.Shapes("Drp_SKU").Visible = msoTrue
        'wks_Forecast.Shapes("TxtSKU").Visible = msoTrue
        wks_Forecast.Range("C168").Value = "Pack Split"
        Call SKU_Rnange_DropDwon
    Else
'    wks_Vars.Range("E20").Value = wks_Vars.Range("E18").Value
        wks_Vars.Range("E20").Value = 1
        wks_Vars.Range("N3").Value = 1
    End If
    
    ''Call BackUp_data
    Call Drop_Dwon_Sce
    
    wks_Vars.Range("E18").Value = intProdSelct
    wks_Vars.Range("E20").Value = intProdSelct2
    wks_Vars.Range("E22").Value = intProdSelct3
    Call Save_Retrive
    Call For_Total_Selection
    'Events
    If wks_M_List.Range("L" & 9 + intRng).Value = True Then
      wks_Vars.Range("Q7").Value = 3
        Call Event_Erosion_actual
    Else
        wks_Vars.Range("Q7").Value = 1
        Call Event_Erosion_actual
    End If
    wks_Forecast.Activate
    Application.CutCopyMode = False
If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Application.ScreenUpdating = True
End Function


Function Drop_Dwon_SKU()
Application_Events_Handler (False)
wks_Forecast.Unprotect
    Dim intSKUselect As Integer, intSKUselect2 As Integer
    Dim intRng2 As Integer
    wks_Vars.Range("Q2").Value = wks_Vars.Range("E18").Value
    wks_Vars.Range("B18").Value = wks_Vars.Range("N2").Value
    wks_Vars.Range("B20").Value = wks_Vars.Range("N3").Value
    wks_Vars.Range("B22").Value = wks_Vars.Range("N4").Value
    wks_Vars.Range("P5").Value = wks_Vars.Range("P3").Value
    intSKUselect = wks_Vars.Range("B18").Value
    intSKUselect2 = wks_Vars.Range("B20").Value
    Call Back_Data
    wks_Vars.Range("E18").Value = intSKUselect
    wks_Vars.Range("E20").Value = intSKUselect2
    If wks_Vars.Range("N3").Value <> 1 + wks_M_List.Range("I" & 9 + wks_Vars.Range("N2").Value).Value Then Call Save_Retrive
    Call For_Total_Selection
    
    intRng2 = 9 + wks_Vars.Range("N2").Value
    If wks_Vars.Range("N3").Value <> 1 + wks_M_List.Range("I" & 9 + wks_Vars.Range("N2").Value).Value Then
        wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
        If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1 Or wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
            If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
              wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
            Else
              wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
            End If
        ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 3 Then
            wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
        ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 2 Then
            wks_Forecast.Range("G114:" & wks_Vars.Range("K2").Value & 114).Formula = "=G67"
            wks_Forecast.Range("" & wks_Vars.Range("L2").Value & 114 & ":NB114").Interior.Color = RGB(255, 255, 204)
        End If
    End If
    
    wks_Vars.Range("M33").Value = wks_Vars.Range("D22").Value
    wks_Forecast.Activate
If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Application_Events_Handler (True)
End Function

Function For_Total_Selection()
Dim intRng As Integer
intRng = 9 + wks_Vars.Range("N2").Value
    wks_Forecast.Shapes("Picture 16").Visible = msoFalse
    wks_Forecast.Shapes("shp_Advanced_Trends").Visible = msoTrue
'    wks_Forecast.Shapes("shp_Advanced_Trends1").Visible = msoTrue
    wks_Forecast.Shapes("shp_Advanced_Price_O").Visible = msoTrue
'    wks_Forecast.Shapes("shp_Advanced_Price").Visible = msoTrue
    wks_Forecast.Shapes("shp_Advanced_Price_PS").Visible = msoFalse
    wks_Forecast.Shapes("shp_Advanced_Price_GTN").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = msoTrue
    wks_Forecast.Shapes("TxtEvents").Visible = msoTrue
    wks_Forecast.Shapes("drp_Dwn_Events").Visible = msoTrue
    wks_Forecast.Shapes("TxtPacks").Visible = msoTrue
    wks_Forecast.Shapes("drpDwn_Packs").Visible = msoTrue
    If wks_M_List.Range("H" & intRng).Value = True Then
        If wks_Vars.Range("N3").Value = 1 + wks_M_List.Range("I" & 9 + wks_Vars.Range("N2").Value).Value Then
            wks_Forecast.Range("A11:A260").EntireRow.Hidden = True      'check  shp_Advanced_Price_Split_G2
            wks_Forecast.Range("A255:A260").EntireRow.Hidden = False
            
            wks_Forecast.Shapes("shp_Advanced_Trends").Visible = msoFalse
'            wks_Forecast.Shapes("shp_Advanced_Trends1").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_O").Visible = msoFalse
'            wks_Forecast.Shapes("shp_Advanced_Price").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_PS").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_GTN").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = msoFalse
            wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = msoFalse
            wks_Forecast.Shapes("TxtPacks").Visible = msoFalse
            wks_Forecast.Shapes("drpDwn_Packs").Visible = msoFalse
            wks_Forecast.Shapes("TxtEvents").Visible = msoFalse
            wks_Forecast.Shapes("drp_Dwn_Events").Visible = msoFalse
            
            With wks_Forecast.Range("G256:" & wks_Vars.Range("K4").Value & 259)
                .Formula = "=SUMIFS(ForecastData!F:F,ForecastData!$A:$A,Vars!$P$2,ForecastData!$C:$C,Vars!$P$4,ForecastData!$E:$E,$F256)"
                .Value = .Value
            End With
            With wks_Forecast.Range("G260:" & wks_Vars.Range("K4").Value & 260)
                .Formula = "=IFERROR(G259/G257,0)"
                .Value = .Value
            End With
        Else
            wks_Forecast.Range("A256:A260").EntireRow.Hidden = True
            wks_Forecast.Shapes("Picture 16").Visible = msoTrue
        End If
    End If
    
End Function

Function Drop_Dwon_Sce()
Dim strVal As String
Dim intRng2 As Integer

Application_Events_Handler (False)
wks_Forecast.Unprotect
    Dim intSKUselect As Integer, intSKUselect2 As Integer, intSKUselect3 As Integer
    intRng2 = 9 + wks_Vars.Range("N2").Value
    wks_Vars.Range("B18").Value = wks_Vars.Range("N2").Value
    wks_Vars.Range("B20").Value = wks_Vars.Range("N3").Value
    wks_Vars.Range("B22").Value = wks_Vars.Range("N4").Value
    
    intSKUselect = wks_Vars.Range("B20").Value
    intSKUselect2 = wks_Vars.Range("B22").Value
    intSKUselect3 = wks_Vars.Range("B18").Value
     
    Call Back_Data
    wks_Vars.Range("E20").Value = intSKUselect
    wks_Vars.Range("E22").Value = intSKUselect2
    wks_Vars.Range("E18").Value = intSKUselect3
    Call Save_Retrive
    ''Call For_Total_Selection
    
    If wks_Vars.Range("N4").Value = 2 Then
       Call Case_Message
    ElseIf wks_Vars.Range("N4").Value = 3 Then
        Call Case_Message
    ElseIf wks_Vars.Range("N4").Value = 1 Then
        Call Case_Message
    End If
    
    wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1 Or wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
        If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
          wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,G67,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        Else
          wks_Forecast.Range("G114:NB114").Formula = "=IF(G$10<$J113,0,P_MB_Transition($G113,$H113,$I113,$K113*24,,$J113,G$10,12,""Monthly""))"
        End If
    ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 3 Then
        wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    ElseIf wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 2 Then
        wks_Forecast.Range("G114:" & wks_Vars.Range("K2").Value & 114).Formula = "=G67"
        wks_Forecast.Range("" & wks_Vars.Range("L2").Value & 114 & ":NB114").Interior.Color = RGB(255, 255, 204)
    End If
wks_Vars.Range("M33").Value = wks_Vars.Range("D22").Value
'Penetration type
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = "" Then
       wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1
    End If
wks_Forecast.Activate
If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Application_Events_Handler (True)
End Function
Function Case_Message()
    If wks_Home.Range("O1").Value = 1 Then
        Call Optinal_ReversData
    Else
        Exit Function
    End If

End Function

Function Optinal_ReversData()
Dim intFrom As Integer, intFrom2 As Integer, intFrom3 As Integer
    With wks_Forecast
        
        intRng3 = wks_Vars.Range("N10").Value
        intFrom = wks_Vars1.Range("S2").Value
        intFrom2 = wks_Vars1.Range("S3").Value
        intFrom3 = wks_Vars1.Range("S5").Value
        If wks_M_List.Range("B8").Value = "TRx" Then
            Call Copy_Paste_Values(wks_Historical.Range("E" & intFrom & ":" & wks_Vars.Range("K4").Value & intFrom + 14), .Range("F14:" & wks_Vars.Range("K4").Value & "28"))
            Call Copy_Paste_Values(wks_Historical.Range("E" & intFrom + 16 & ":" & wks_Vars.Range("K4").Value & intFrom + 30), .Range("F32:" & wks_Vars.Range("K4").Value & "46"))
            Call Copy_Paste_Values(wks_Historical.Range("E" & intFrom + 48 & ":" & wks_Vars.Range("K4").Value & intFrom + 62), .Range("F70:" & wks_Vars.Range("K4").Value & "84"))
            Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intFrom2 & ":" & wks_Vars.Range("K4").Value & intFrom2), .Range("G91:" & wks_Vars.Range("K4").Value & "91"))
            Call Copy_Paste_Values(wks_Events.Range("H" & intFrom3 + 10 & ":L" & intFrom3 + 10), .Range("G113:K113"))
            .Range("L113:M113").ClearContents
            Call Copy_Paste_Values(wks_Events.Range("E" & intFrom3 + 11 & ":L" & intFrom3 + 11 + 4), .Range("F95:M99"))
            Call Copy_Paste_Values(wks_Events.Range("E" & intFrom3 & ":L" & intFrom3 + 9), .Range("F121:M121"))
            wks_Vars.Range("Q8").Value = wks_Events.Range("M" & intFrom3).Value + 1
            wks_Vars.Range("Q7").Value = wks_Events.Range("M" & intFrom3 + 11).Value + 1
            Call No_Events
            Call Event_Erosion
        Else
            Call Copy_Paste_Values(wks_Historical.Range("E" & intFrom + 32 & ":" & wks_Vars.Range("K4").Value & intFrom + 46), .Range("F50:" & wks_Vars.Range("K4").Value & "64"))
            Call Copy_Paste_Values(wks_Historical.Range("E" & intFrom + 48 & ":" & wks_Vars.Range("K4").Value & intFrom + 62), .Range("F70:" & wks_Vars.Range("K4").Value & "84"))
            Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intFrom2 & ":" & wks_Vars.Range("K4").Value & intFrom2), .Range("G91:" & wks_Vars.Range("K4").Value & "91"))
            Call Copy_Paste_Values(wks_Events.Range("H" & intFrom3 + 10 & ":L" & intFrom3 + 10), .Range("G113:K113"))
            .Range("L113:M113").ClearContents
            Call Copy_Paste_Values(wks_Events.Range("E" & intFrom3 + 11 & ":L" & intFrom3 + 11 + 4), .Range("F95:M99"))
            Call Copy_Paste_Values(wks_Events.Range("E" & intFrom3 & ":L" & intFrom3 + 9), .Range("F121:M121"))
            wks_Vars.Range("Q8").Value = wks_Events.Range("M" & intFrom3).Value + 1
            wks_Vars.Range("Q7").Value = wks_Events.Range("M" & intFrom3 + 11).Value + 1
            Call No_Events
            Call Event_Erosion
   
            .Range("F70:F84").Formula = "=IF(F50="""","""",F50)"
        End If
        .Range("G29:NB29").Formula = "=SUM(G$14:G$28)"
        .Range("G47:NB47").Formula = "=SUM(G$32:G$46)"
        .Range("G65:NB65").Formula = "=SUM(G$50:G$64)"
        .Range("G85:NB85").Formula = "=SUM(G$70:G$84)"
        .Range("F65").Value = "Total Market Units"
        .Range("A47:A47").EntireRow.Hidden = True
        
    End With
End Function
Function SKU_Rnange_DropDwon()
Dim intLoop As Integer, intRng As Integer, intCell As Integer, intVar As Integer
''Dim strRng As String,
''Dim intRngSelect As Integer,
Dim strAddress As String '', strRng2 As String
intVar = 9 + wks_Vars.Range("B18").Value
intRng = 1
           
''    intCell = wks_Vars.Range("B18").Value
    wks_Vars.Range("Q1").Value = wks_Vars.Range("B18").Value
    intRng = 17 + wks_Vars.Range("B18").Value
''    intRngSelect = wks_Vars.Range("G" & intCell + 2).Value
    strAddress = Range(wks_Vars.Cells(2, intRng), wks_Vars.Cells(2 + wks_M_List.Range("I" & intVar).Value, intRng)).Address
    ''strRng = "Vars!" & Range(wks_Vars.Cells(2, intRng), wks_Vars.Cells(2 + wks_M_List.Range("I" & intVar).Value, intRng)).Address
    wks_Vars.Range("J3:J" & wks_M_List.Range("I" & intVar).Value + 3).Value = wks_Vars.Range("" & strAddress).Value
    ''strRng2 = "Vars!" & Range(wks_Vars.Cells(2, intRng), wks_Vars.Cells(1 + wks_M_List.Range("I" & intVar).Value, intRng)).Address
'    With wks_Forecast.Shapes("Drp_SKU").ControlFormat
'        .ListFillRange = strRng
'        .LinkedCell = "Vars!$N$3"
'        .DropDownLines = 15
'    End With
''    With wks_Summary.Shapes("Drp_SKU").ControlFormat
''        .ListFillRange = strRng2
''        .LinkedCell = "Vars!$AJ$2"
''        .DropDownLines = 15
''    End With
'    With wks_Graphs.Shapes("Drp_SKU2").ControlFormat
'        .ListFillRange = strRng2
'        .LinkedCell = "Vars!$AJ$2"
'        .DropDownLines = 15
'    End With
    
End Function

Function BackUp_data()
Dim intFrom As Long, intRng As Integer, intRng2 As Integer, intRng3 As Integer
intRng = wks_Vars.Range("N2").Value
intRng2 = wks_Vars.Range("N4").Value
intRng3 = wks_Vars.Range("N11").Value
    wks_Vars.Calculate
    With wks_Forecast 'wks_Backup_Data
        intFrom = wks_Vars.Range("F22").Value
         
         wks_Backup_Data.Range("E" & intFrom & ":" & wks_Vars.Range("K4").Value & intFrom + 15).Value = .Range("F14:" & wks_Vars.Range("K4").Value & "29").Value
         wks_Backup_Data.Range("E" & intFrom + 16 & ":" & wks_Vars.Range("K4").Value & intFrom + 31).Value = .Range("F32:" & wks_Vars.Range("K4").Value & "47").Value
         wks_Backup_Data.Range("E" & intFrom + 32 & ":" & wks_Vars.Range("K4").Value & intFrom + 47).Value = .Range("F70:NB85").Value
         wks_Backup_Data.Range("E" & intFrom + 48 & ":" & wks_Vars.Range("K4").Value & intFrom + 48).Value = .Range("F92:NB92").Value
         wks_Backup_Data.Range("E" & intFrom + 49 & ":" & wks_Vars.Range("K4").Value & intFrom + 63).Value = .Range("F96:NB110").Value
         wks_Backup_Data.Range("E" & intFrom + 64 & ":" & wks_Vars.Range("K4").Value & intFrom + 64).Value = .Range("F150:NB150").Value
         wks_Backup_Data.Range("E" & intFrom + 65 & ":" & wks_Vars.Range("K4").Value & intFrom + 65).Value = .Range("F153:NB153").Value
         wks_Backup_Data.Range("E" & intFrom + 66 & ":" & wks_Vars.Range("K4").Value & intFrom + 66).Value = .Range("F156:NB156").Value
         wks_Backup_Data.Range("E" & intFrom + 67 & ":" & wks_Vars.Range("K4").Value & intFrom + 67).Value = .Range("F160:NB160").Value
         wks_Backup_Data.Range("E" & intFrom + 68 & ":" & wks_Vars.Range("K4").Value & intFrom + 68).Value = .Range("F164:NB164").Value
         wks_Backup_Data.Range("E" & intFrom + 69 & ":" & wks_Vars.Range("K4").Value & intFrom + 69).Value = .Range("F166:NB166").Value
         wks_Backup_Data.Range("E" & intFrom + 70 & ":" & wks_Vars.Range("K4").Value & intFrom + 84).Value = .Range("F172:NB186").Value
         wks_Backup_Data.Range("E" & intFrom + 85 & ":IK" & intFrom + 99).Value = .Range("F206:NB220").Value
         wks_Backup_Data.Range("E" & intFrom + 100 & ":IK" & intFrom + 115).Value = .Range("F50:NB65").Value
         wks_Backup_Data.Range("E" & intFrom + 116 & ":IK" & intFrom + 130).Value = .Range("F223:NB237").Value
         wks_Backup_Data.Range("E" & intFrom + 131 & ":IK" & intFrom + 145).Value = wks_Trending.Range("F34:NB48").Value
         wks_Backup_Data.Range("E" & intFrom + 146 & ":IK" & intFrom + 146).Value = wks_Price.Range("F18:NB18").Value
         wks_Backup_Data.Range("E" & intFrom + 147 & ":IK" & intFrom + 147).Value = wks_Price.Range("F49:NB49").Value
         wks_Backup_Data.Range("E" & intFrom + 148 & ":IK" & intFrom + 148).Value = wks_Price.Range("F58:NB58").Value
         wks_Backup_Data.Range("E" & intFrom + 149 & ":IK" & intFrom + 149).Value = wks_Price.Range("F52:NB52").Value
         wks_Backup_Data.Range("E" & intFrom + 150 & ":IK" & intFrom + 150).Value = wks_Price.Range("F54:NB54").Value
         wks_Backup_Data.Range("F" & intFrom + 151 & ":IK" & intFrom + 151).Value = wks_Price.Range("G41:NB41").Value

         wks_Events.Range("H" & intRng3 & ":N" & intRng3).Value = .Range("G113:M113").Value
         wks_Events.Range("M" & intRng3).Value = wks_Vars.Range("Q8").Value
         wks_Events.Range("E" & intRng3 + 1 & ":L" & intRng3 + 10).Value = .Range("F121:M130").Value
         wks_Events.Range("E" & intRng3 + 11 & ":L" & intRng3 + 15).Value = wks_Trending.Range("F357:M361").Value

         wks_Events.Range("A" & intRng3 & ":A" & intRng3 + 14).Value = wks_Vars.Range("Q30").Value
         wks_Events.Range("B" & intRng3 & ":B" & intRng3 + 14).Value = wks_Vars.Range("Q31").Value
         wks_Events.Range("C" & intRng3 & ":C" & intRng3 + 14).Value = wks_Vars.Range("Q32").Value
         wks_Events.Range("D" & intRng3 & ":D" & intRng3 + 14).Value = wks_M_List.Range("D" & intRng + 9).Value
         
        'Data_Specification
        wks_Vars.Calculate
         wks_Backup_Data.Range("A" & intFrom & ":A" & intFrom + 150).Value = wks_Vars.Range("P2").Value
         wks_Backup_Data.Range("B" & intFrom & ":B" & intFrom + 150).Value = wks_Vars.Range("P5").Value
         wks_Backup_Data.Range("C" & intFrom & ":C" & intFrom + 150).Value = wks_Vars.Range("Q4").Value
         wks_Backup_Data.Range("D" & intFrom & ":D" & intFrom + 150).Value = wks_M_List.Range("D" & intRng + 9).Value
         
         wks_M_List.Range("F" & intRng + 9).Value = wks_Forecast.Range("F118").Value
         wks_M_List.Range("J" & intRng + 9).Value = wks_Forecast.Range("F169").Value
         
    End With
End Function

Function Reverse_BackUp_data()
Dim intFrom As Long, intRng As Integer, intRng2 As Integer, intRng3 As Integer, intHide As Integer
intRng = 9 + wks_Vars.Range("O2").Value
intRng2 = 9 + wks_Vars.Range("N2").Value
intRng3 = wks_Vars.Range("N10").Value
intHide = wks_Events.Range("M" & intRng3).Value - 1
    wks_Vars.Calculate
    With wks_Forecast 'wks_Backup_Data
        intFrom = wks_Vars.Range("D22").Value
        

        Call Copy_Paste_Values(wks_Events.Range("M" & intRng3), wks_Vars.Range("Q8"))
        
        .Range("F14:NB29").Value = wks_Backup_Data.Range("E" & intFrom & ":IK" & intFrom + 15).Value
        .Range("F32:NB47").Value = wks_Backup_Data.Range("E" & intFrom + 16 & ":IK" & intFrom + 31).Value
        .Range("F70:NB85").Value = wks_Backup_Data.Range("E" & intFrom + 32 & ":IK" & intFrom + 47).Value
        .Range("F92:NB92").Value = wks_Backup_Data.Range("E" & intFrom + 48 & ":IK" & intFrom + 48).Value
        .Range("F96:NB110").Value = wks_Backup_Data.Range("E" & intFrom + 49 & ":IK" & intFrom + 63).Value
        .Range("F150:NB150").Value = wks_Backup_Data.Range("E" & intFrom + 64 & ":IK" & intFrom + 64).Value
        .Range("F153:NB153").Value = wks_Backup_Data.Range("E" & intFrom + 65 & ":IK" & intFrom + 65).Value
        .Range("F156:NB156").Value = wks_Backup_Data.Range("E" & intFrom + 66 & ":IK" & intFrom + 66).Value

        .Range("F172:NB186").Value = wks_Backup_Data.Range("E" & intFrom + 70 & ":IJ" & intFrom + 84).Value
        .Range("F206:NB220").Value = wks_Backup_Data.Range("E" & intFrom + 85 & ":IK" & intFrom + 99).Value
        .Range("F50:NB65").Value = wks_Backup_Data.Range("E" & intFrom + 100 & ":IK" & intFrom + 115).Value
        .Range("F223:NB237").Value = wks_Backup_Data.Range("E" & intFrom + 116 & ":IK" & intFrom + 130).Value

        wks_Trending.Range("F34:NB48").Value = wks_Backup_Data.Range("E" & intFrom + 131 & ":IK" & intFrom + 145).Value
        wks_Price.Range("F18:NB18").Value = wks_Backup_Data.Range("E" & intFrom + 146 & ":IK" & intFrom + 146).Value
        wks_Price.Range("F49:NB49").Value = wks_Backup_Data.Range("E" & intFrom + 147 & ":IK" & intFrom + 147).Value
        wks_Price.Range("F58:NB58").Value = wks_Backup_Data.Range("E" & intFrom + 148 & ":IK" & intFrom + 148).Value
        wks_Price.Range("F52:NB52").Value = wks_Backup_Data.Range("E" & intFrom + 149 & ":IK" & intFrom + 149).Value
        wks_Price.Range("F54:NB54").Value = wks_Backup_Data.Range("E" & intFrom + 150 & ":IK" & intFrom + 150).Value
        wks_Price.Range("G41:NB41").Value = wks_Backup_Data.Range("F" & intFrom + 151 & ":IK" & intFrom + 151).Value

        .Range("G113:M113").Value = wks_Events.Range("H" & intRng3 & ":N" & intRng3).Value
        .Range("F121:M130").Value = wks_Events.Range("E" & intRng3 + 1 & ":L" & intRng3 + 10).Value
        wks_Trending.Range("F357:M361").Value = wks_Events.Range("E" & intRng3 + 11 & ":L" & intRng3 + 15).Value
        
        wks_Forecast.Range("F118").Value = wks_M_List.Range("F" & intRng).Value
        wks_Forecast.Range("F169").Value = wks_M_List.Range("J" & intRng).Value
        
        wks_Forecast.Range("F92").Value = "Trended Extended Units"
        wks_Forecast.Range("F150").Value = "Price"
        wks_Forecast.Range("F153").Value = "Probability of Success"
        wks_Forecast.Range("F156").Value = "GTN"
        
        If wks_M_List.Range("D" & intRng2).Value = "Pipeline" Then
            Call Create_BDL_Pipeline_Volume
        Else
            Call Create_BDL_Inline_Volume
        End If
        
        If wks_Events.Range("M" & intRng3).Value <> 0 Then
            wks_Forecast.Range("A120:A" & intHide + 120).EntireRow.Hidden = False
            wks_Forecast.Range("A131:A" & intHide + 132).EntireRow.Hidden = False
            wks_Forecast.Range("A143:A145").EntireRow.Hidden = False
        End If
            
        wks_Forecast.Range("F118").Value = wks_M_List.Range("F" & intRng + 1).Value
        wks_Forecast.Range("F169").Value = wks_M_List.Range("J" & intRng + 1).Value
        wks_Price.Range("F52").Value = "Discount Factor"
        wks_Price.Range("F54").Value = "Launch Price"
        wks_Forecast.Range("F91").Value = "Market Trend"
        
        wks_Vars.Range("Q30").Value = wks_Vars.Range("P2").Value
        wks_Vars.Range("Q31").Value = wks_Vars.Range("P3").Value
        wks_Vars.Range("Q32").Value = wks_Vars.Range("P4").Value
    End With
End Function

Function Create_Forecast_Master()
    Dim intLoop As Integer, intRng As Integer, intCell As Integer
    Dim intVar As Integer, intRng2 As Integer
    wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
''    wks_Forecast.Shapes("shp_Share_Trend").Visible = msoFalse
    ''If wks_Vars.Range("Q36").Value <> "Import" Then
        wks_Vars.Range("E18").Value = 1
        wks_Vars.Range("E20").Value = 1
        wks_Vars.Range("E22").Value = 1
        wks_Vars.Range("N2").Value = 1
        wks_Vars.Range("N3").Value = 1
        wks_Vars.Range("N4").Value = 1
        wks_Vars.Range("Q7").Value = 0
        wks_Vars.Range("Q8").Value = 0
        wks_Vars.Range("Q9").Value = 0
        wks_Vars.Range("Q34").Value = "No"
        wks_Vars1.Range("N1").Value = 1
        wks_Vars1.Range("N2").Value = 1
        wks_Vars1.Range("N3").Value = 1
        wks_Vars1.Range("N6").Value = 1
        wks_Vars1.Range("N7").Value = 1
        wks_Vars1.Range("N8").Value = 1
    ''End If
    wks_Vars.Calculate
    wks_Forecast.Calculate
    
    wks_Forecast.Range("H1:NB1").EntireColumn.Hidden = False
    wks_Trending.Range("H1:NB1").EntireColumn.Hidden = False
    wks_Forecast.Range("G10").Value = wks_Vars.Range("N7").Value
    wks_Forecast.Calculate
    wks_Vars.Calculate
    
    'For SKU data validation
    wks_Vars.Range("R1:AA16").Value = wks_SKU_info.Range("B1:K16").Value
    intVar = wks_Vars.Range("N2").Value
    intCell = wks_M_List.Range("I" & intVar + 9).Value
    wks_Vars.Range("Q1").Value = intCell
    wks_Vars.Range("R" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 10).Value
    wks_Vars.Range("S" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 11).Value
    wks_Vars.Range("T" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 12).Value
    wks_Vars.Range("U" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 13).Value
    wks_Vars.Range("V" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 14).Value
    wks_Vars.Range("W" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 15).Value
    wks_Vars.Range("X" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 16).Value
    wks_Vars.Range("Y" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 17).Value
    wks_Vars.Range("Z" & intCell + 2).Value = "Total"
    intCell = wks_M_List.Range("I" & intVar + 18).Value
    wks_Vars.Range("AA" & intCell + 2).Value = "Total"
    
    ''Application.Calculate
    If wks_M_List.Range("H10").Value = True Then
        'wks_Forecast.Shapes("Drp_SKU").Visible = msoFalse
        'wks_Forecast.Shapes("TxtSKU").Visible = msoFalse
        Call SKU_Rnange_DropDwon
    End If
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'    Application.Calculate
    
    'çolor
    If wks_M_List.Range("D10").Value = "Pipeline" Then
        Call Create_BDL_Pipeline_Volume
    Else
        Call Create_BDL_Inline_Volume
    End If
'    Application.Calculate
    intProdSelct = wks_M_List.Range("C34").Value
    wks_M_List.Range("F34").Value = intProdSelct
'    Application.Calculate
    intRng = wks_M_List.Range("C9").Value
    strRng = "Master_List!" & wks_M_List.Range(wks_M_List.Cells(10, 2), wks_M_List.Cells(9 + intRng, 2)).Address
   
    ''Application.Calculate
    intRng = wks_M_List.Range("C60").Value
    strRng = "Master_List!" & wks_M_List.Range(wks_M_List.Cells(61, 2), wks_M_List.Cells(60 + intRng, 2)).Address
'    With wks_Forecast.Shapes("cb_SKU").ControlFormat
'        .ListFillRange = strRng
'    End With
'    With wks_Consolidator.Shapes("Drp_SKU2").ControlFormat
'        .ListFillRange = strRng
'    End With
'    With wks_AsIs.Shapes("Drp_SKU2").ControlFormat
'        .ListFillRange = strRng
'    End With
    
''    wks_Forecast.Shapes("shp_Advanced_Price_Split_G2").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split_PGTN").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split_P").Visible = msoFalse
''    wks_Forecast.Shapes("shp_Advanced_Price_Split").Visible = msoFalse

    wks_Forecast.Range(wks_Vars.Range("L4").Value & 1 & ":NB1").EntireColumn.Hidden = True
    wks_Trending.Range(wks_Vars.Range("L4").Value & 1 & ":NB1").EntireColumn.Hidden = True
    
    wks_Vars.Range("M33").Value = wks_Vars.Range("D22").Value
    
    wks_Vars.Range("Q30").Value = wks_Vars.Range("P2").Value
    wks_Vars.Range("Q31").Value = wks_Vars.Range("P3").Value
    wks_Vars.Range("Q32").Value = wks_Vars.Range("P4").Value
    wks_Vars.Calculate
    wks_Product_Details.Range("G2:G100").Value = wks_M_List.Range("I10:I108").Value
    Call mod_Vars_Code
    
    wks_Forecast.Range("G10:" & wks_Vars.Range("K4").Value & "10").EntireColumn.Hidden = False
    wks_Trending.Range("G10:" & wks_Vars.Range("K4").Value & "10").EntireColumn.Hidden = False
    intRng2 = 9 + wks_Vars.Range("N2").Value
     
     With wks_Forecast
        .Range("G50:NB64").Interior.Color = RGB(255, 255, 255)
        .Range("G14:NB28").Interior.Color = RGB(255, 255, 255)
        .Range("G70:NB84").Interior.Color = RGB(255, 255, 255)
            If wks_M_List.Range("B8").Value = "Units" Then
                .Range("F50:F64").Interior.Color = RGB(255, 255, 204)
                .Range("G14:" & wks_Vars.Range("K2").Value & "28").Interior.Color = RGB(255, 255, 204)
                .Range("G50:" & wks_Vars.Range("K2").Value & "64").Interior.Color = RGB(255, 255, 204)
                .Range("G70:" & wks_Vars.Range("K2").Value & "84").Interior.Color = RGB(255, 255, 204)
            Else
                .Range("G14:" & wks_Vars.Range("K2").Value & "28").Interior.Color = RGB(255, 255, 204)
                .Range("F50:NB65").Interior.Color = RGB(255, 255, 255)
                .Range("G47:NB47").Interior.Color = RGB(255, 255, 255)
                .Range("G70:" & wks_Vars.Range("K2").Value & "84").Interior.Color = RGB(255, 255, 204)
            End If
      End With
     If wks_M_List.Range("D" & intRng2).Value = "Inline" Then
'        wks_Forecast.Range("F14").Value = wks_Vars.Range("P2").Value
'        wks_Forecast.Range("F50").Value = wks_Vars.Range("P2").Value
        wks_Forecast.Range("F14").Interior.Color = RGB(255, 255, 255)
        wks_Forecast.Range("F50").Interior.Color = RGB(255, 255, 255)
    Else
        wks_Forecast.Range("F14").Interior.Color = RGB(255, 255, 204)
        wks_Forecast.Range("F50").Interior.Color = RGB(255, 255, 204)
    End If
    'Hide drops
    
    'missing formulas
    wks_Forecast.Range("F101").Value = "Evented Shares"
    wks_Forecast.Range("F102:F106").Formula = "=if(F95="""","""",F95)"
    wks_Forecast.Range("F108").Value = "Available Market Units"
   
   'Events
    If wks_M_List.Range("L" & 10).Value = True Then
      wks_Vars.Range("Q7").Value = 3
        Call Event_Erosion_actual
    Else
        wks_Vars.Range("Q7").Value = 2
        Call Event_Erosion_actual
    End If
    wks_Forecast.Range("A90:A93").EntireRow.Hidden = False
    wks_Forecast.Range("A109").EntireRow.Hidden = True
'    wks_Forecast.Shapes("cb_product").Visible = msoFalse
'    wks_Forecast.Shapes("cb_SKU").Visible = msoFalse
'    'wks_Forecast.Shapes("Drp_SKU").Visible = msoFalse
'    wks_Forecast.Shapes("shp_Advanced_Trends").Top = wks_Forecast.Range("F90").Top + 2
'    wks_Forecast.Shapes("cht_trend").Top = wks_Forecast.Range("E90").Top + 2
    Call Ass_Drp_Down_Fill
    wks_Forecast.Activate
    
End Function

