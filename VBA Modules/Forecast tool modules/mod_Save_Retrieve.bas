Attribute VB_Name = "mod_Save_Retrieve"
Option Explicit

Function Application_Events_Handler(blnStatus As Boolean)
    On Error Resume Next
    Application.ScreenUpdating = blnStatus
    Application.EnableEvents = False
    Application.DisplayAlerts = blnStatus
    If blnStatus = False Then
        Application.Calculation = xlCalculationManual
    Else
        Application.Calculation = xlCalculationAutomatic
    End If
End Function

Function Save_Forecast_Offline()
    Call Save_Forecast
    Call Save_in_Local_Drive
End Function

Function Save_Forecast()
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim strPath As String
    Dim actsheet As String
    Dim thisWB As Workbook
    Dim intLoop As Integer, intNext As Integer, intRow As Integer, intLast As Variant
    
Call Application_Events_Handler(False)
    Application.DisplayAlerts = False
    actsheet = "Generic_Forecast"
    If Not ActiveSheet Is Nothing Then
        actsheet = ActiveSheet.Name
    End If
    Set thisWB = ThisWorkbook
    Call Back_Data
    
    Set objExcel = CreateObject("Excel.Application")
    
    Set wb = objExcel.Workbooks.Add
    
    Set ws = wb.Sheets(1)
    ws.Name = "ProjectDetails"
''    Call Save_Repeated_Copy_Paste("ProjectDetails", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("ProjectDetails", wb, "A", "L", thisWB, "A", "L")
    Application.CutCopyMode = False
    
    Set ws = wb.Sheets.Add
    ws.Name = "ProductDetails"
''    Call Save_Repeated_Copy_Paste("ProductDetails", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("ProductDetails", wb, "A", "J", thisWB, "A", "J")
    
    Set ws = wb.Sheets.Add
    ws.Name = "ScenarioTable"
''    Call Save_Repeated_Copy_Paste("ScenarioTable", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("ScenarioTable", wb, "A", "B", thisWB, "A", "B")
   
    Set ws = wb.Sheets.Add
    ws.Name = "ForecastData"
''    Call Save_Repeated_Copy_Paste("ForecastData", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("ForecastData", wb, "B", "RR", thisWB, "A", "RQ")
       On Error Resume Next
    'Create named ranges
        With wb.Sheets("ForecastData")
            intLast = .Columns(2).Find("*", , , , xlByColumns, xlPrevious).Row
            .Range("A1").Value = "ID"
            .Range("A2:A" & intLast).Formula = "=Row()-1"
            .Range("A2:A" & intLast).Value = .Range("A2:A" & intLast).Value
            
            .Range("RS1").Value = "ID"
            .Range("RS2:RS" & intLast).Value = .Range("A2:A" & intLast).Value
            
           .Range("A1:IK" & intLast).Name = "ForecastData1"
           .Range("IL1:RS" & intLast).Name = "ForecastData2"
           With .Range("A2:RR" & intLast)
            If Not .Find(what:="#N/A") Is Nothing Then
                 .Replace "#N/A", "", xlWhole
            End If
           End With
           With .Range("F2:RQ" & intLast)
            If Not .Find(what:=" ") Is Nothing Then
                 .Replace " ", "", xlPart
            End If
            If Not .Find(what:="-") Is Nothing Then
                 .Replace "-", "", xlWhole
            End If
           End With
           Call Clear_Blanks(wb, "ForecastData", "F2:RR" & intLast)
        End With
    
    Set ws = wb.Sheets.Add
    ws.Name = "HistoricalData"
''    Call Save_Repeated_Copy_Paste("HistoricalData", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("HistoricalData", wb, "B", "NC", thisWB, "A", "NB")
    'Create named ranges
        With wb.Sheets("HistoricalData")
           intLast = .Columns(2).Find("*", , , , xlByColumns, xlPrevious).Row
           .Range("A1").Value = "ID"
           .Range("A2:A" & intLast).Formula = "=Row()-1"
           .Range("A2:A" & intLast).Value = .Range("A2:A" & intLast).Value
           
           .Range("ND1").Value = "ID"
            .Range("ND2:ND" & intLast).Value = .Range("A2:A" & intLast).Value
            
           .Range("A1:IL" & intLast).Name = "HistoricalData1"
           .Range("IM1:ND" & intLast).Name = "HistoricalData2"
           With .Range("F2:F" & intLast)
            If Not .Find(what:=0) Is Nothing Then
                .Replace 0, "", xlWhole
            End If
           End With
           With .Range("A2:ND" & intLast)
            If Not .Find(what:="#N/A") Is Nothing Then
                 .Replace "#N/A", "", xlWhole
            End If
           End With
           With .Range("G2:NB" & intLast)
            If Not .Find(what:=" ") Is Nothing Then
                 .Replace " ", "", xlPart
            End If
            If Not .Find(what:="-") Is Nothing Then
                 .Replace "-", "", xlWhole
            End If
           End With
           Call Clear_Blanks(wb, "HistoricalData", "G2:RR" & intLast)
        End With
        
    Set ws = wb.Sheets.Add
    ws.Name = "PackInfo"
''    Call Save_Repeated_Copy_Paste("PackInfo", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("PackInfo", wb, "B", "RS", thisWB, "A", "RR")
    
    'Create named ranges
        With wb.Sheets("PackInfo")
           intLast = .Columns(2).Find("*", , , , xlByColumns, xlPrevious).Row
           .Range("A1").Value = "ID"
           .Range("A2:A" & intLast).Formula = "=Row()-1"
           .Range("A2:A" & intLast).Value = .Range("A2:A" & intLast).Value
           
           .Range("RT1").Value = "ID"
           .Range("RT2:RT" & intLast).Value = .Range("A2:A" & intLast).Value
           
           .Range("A1:IL" & intLast).Name = "PackInfo1"
           .Range("IM1:RT" & intLast).Name = "PackInfo2"
           With .Range("A2:RR" & intLast)
            If Not .Find(what:="#N/A") Is Nothing Then
                 .Replace "#N/A", "", xlWhole
            End If
           End With
           Call Clear_Blanks(wb, "PackInfo", "A2:RS" & intLast)
        End With
    
    Set ws = wb.Sheets.Add
    ws.Name = "SKU_InformationOld"
''    Call Save_Repeated_Copy_Paste("SKU_InformationOld", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("SKU_InformationOld", wb, "A", "AY", thisWB, "A", "AY")
    
    Set ws = wb.Sheets.Add
    ws.Name = "SKU_Information"
        intRow = 1
        With ws
            .Range("A1").Value = "SKU_Order"
            .Range("B1").Value = "ProductName"
            .Range("C1").Value = "SKU_Name"
            For intLoop = 1 To wks_ProjectDetails.Range("J2").Value
                For intNext = 1 To wks_Product_Details.Range("G" & 1 + intLoop).Value
                    ws.Range("A" & intRow + intNext).Value = intNext
                    ws.Range("B" & intRow + intNext).Value = wks_Product_Details.Range("A" & 1 + intLoop).Value
                    If wks_SKU_info.Cells(1 + intNext, 1 + intLoop).Value = "" Then
                        ws.Range("C" & intRow + intNext).Value = "All"
                    Else
                        ws.Range("C" & intRow + intNext).Value = wks_SKU_info.Cells(1 + intNext, 1 + intLoop).Value
                    End If
                Next intNext
                intRow = intRow + intNext - 1
            Next intLoop
        End With
    
    Set ws = wb.Sheets.Add
    ws.Name = "ForecastEvents"
''    Call Save_Repeated_Copy_Paste("ForecastEvents", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("ForecastEvents", wb, "A", "N", thisWB, "A", "N")
    
     With wb.Sheets("ForecastEvents")
        intLast = .Columns(2).Find("*", , , , xlByColumns, xlPrevious).Row
           With .Range("A2:RR" & intLast)
            If Not .Find(what:="#N/A") Is Nothing Then
                 .Replace "#N/A", "", xlWhole
            End If
           End With
        .Range("I:J").ClearFormats
        .Range("K2:K" & intLast).NumberFormat = "MMM-YYYY"
     End With
     
    Set ws = wb.Sheets.Add
    ws.Name = "PenetrationType"
''    Call Save_Repeated_Copy_Paste("PenetrationType", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("PenetrationType", wb, "B", "RX", thisWB, "A", "RW")
    'Create named ranges
        With wb.Sheets("PenetrationType")
            .Range("A1").Value = "Combination"
           intLast = .Columns(2).Find("*", , , , xlByColumns, xlPrevious).Row
           .Range("A1").Value = "ID"
            .Range("A2:A" & intLast).Formula = "=Row()-1"
            .Range("A2:A" & intLast).Value = .Range("A2:A" & intLast).Value
            
           .Range("RY1").Value = "ID"
            .Range("RY2:RY" & intLast).Value = .Range("A2:A" & intLast).Value
            
           .Range("A1:II" & intLast).Name = "PenetrationType1"
           .Range("IJ1:RY" & intLast).Name = "PenetrationType2"
           .Range("A" & intLast + 1 & ":XFD1048576").Clear
           With .Range("A2:RR" & intLast)
            If Not .Find(what:="#N/A") Is Nothing Then
                 .Replace "#N/A", "", xlWhole
            End If
           End With
           Call Clear_Blanks(wb, "PenetrationType", "A2:RR" & intLast)
        End With
        
    Set ws = wb.Sheets.Add
    ws.Name = "Assumptions"
''    Call Save_Repeated_Copy_Paste("Assumptions", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("Assumptions", wb, "A", "E", thisWB, "A", "E")
    
    Set ws = wb.Sheets.Add
    ws.Name = "Indication"
''    Call Save_Repeated_Copy_Paste("Indication", wb, thisWB)
    Call Save_Repeated_Copy_Paste_By_Range("Indication", wb, "A", "A", thisWB, "A", "A")
     
    strPath = ThisWorkbook.Path & "\" & ThisWorkbook.Sheets("ProjectDetails").Range("A2").Value & ".xlsb"
    If Dir(strPath) <> "" Then Kill strPath
    
    wb.SaveAs strPath, 50
    Application.DisplayAlerts = False
    wb.Application.CutCopyMode = False
    wb.Close False
    Set ws = Nothing
    Set wb = Nothing
''    Call Kill_Process_ObjExcel(objExcel)
    Set objExcel = Nothing
''    Call Optinal_ReversData
    ThisWorkbook.Sheets("" & actsheet).Activate
Application.DisplayAlerts = True
Call Application_Events_Handler(True)
Save_Forecast = strPath
End Function

Function Clear_Blanks(wb As Workbook, shtName As String, strRange As String)
On Error Resume Next
    wb.Sheets(shtName).Range(strRange).SpecialCells(xlCellTypeBlanks).Clear
End Function

Function Retrieve_Forecast()
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim thisWB As Workbook
    Dim intNext As Integer, intLoop As Integer
    Dim intRng2 As Integer
    Dim prodName As String
    Dim intProdCount As Integer
    
    Call InitializeDisplay
    Call Application_Events_Handler(False)
    
    Call Data_Clear
    
    Set objExcel = CreateObject("Excel.Application")
    Set wb = objExcel.Workbooks.Open(ThisWorkbook.Path & "\" & wks_Home.Range("A1").Value)
    wb.Windows(1).Visible = False
    Set thisWB = ThisWorkbook
    intRng2 = 9 + wks_Vars.Range("N2").Value
    Call Repeated_Copy_Paste_By_Range("ProjectDetails", wb, "A", "L", thisWB, "A", "L")
    Call Repeated_Copy_Paste_By_Range("PackInfo", wb, "B", "RS", thisWB, "A", "RR")
    Call Repeated_Copy_Paste_By_Range("ScenarioTable", wb, "A", "B", thisWB, "A", "B")
    Call Repeated_Copy_Paste_By_Range("ProductDetails", wb, "A", "J", thisWB, "A", "J")
    Call Repeated_Copy_Paste_By_Range("HistoricalData", wb, "B", "NC", thisWB, "A", "NB")
    Call Repeated_Copy_Paste_By_Range("ForecastData", wb, "B", "RR", thisWB, "A", "RQ")
    Call Repeated_Copy_Paste_By_Range("SKU_Information", wb, "A", "C", thisWB, "A", "C")
    Call Repeated_Copy_Paste_By_Range("SKU_InformationOld", wb, "A", "AY", thisWB, "A", "AY")
    Call Repeated_Copy_Paste_By_Range("ForecastEvents", wb, "A", "N", thisWB, "A", "N")
    Call Repeated_Copy_Paste_By_Range("PenetrationType", wb, "B", "RX", thisWB, "A", "RW")
    
    wb.Application.CutCopyMode = False
    wb.Close False
    Set wb = Nothing
    
''    Call Kill_Process_ObjExcel(objExcel)
    Set objExcel = Nothing
    
    wks_Vars.Range("B18,B20,B22,E18,E20,E22").Value = 1
    
    With wks_M_List
        .Range("B2").Value = wks_ProjectDetails.Range("A2").Value
        .Range("B3").Value = wks_ProjectDetails.Range("B2").Value
        .Range("B4").Value = wks_ProjectDetails.Range("C2").Value
        .Range("B5").Value = wks_ProjectDetails.Range("D2").Value
        .Range("C5").Value = wks_ProjectDetails.Range("E2").Value
        .Range("B6").Value = wks_ProjectDetails.Range("F2").Value
        .Range("C6").Value = wks_ProjectDetails.Range("G2").Value
        .Range("C7").Value = wks_ProjectDetails.Range("H2").Value
        .Range("B8").Value = wks_ProjectDetails.Range("I2").Value
        .Range("C9").Value = wks_ProjectDetails.Range("J2").Value
        .Range("C60").Value = wks_ProjectDetails.Range("K2").Value
        .Range("B10:B59").Value = wks_Product_Details.Range("A2:A51").Value
        .Range("D10:D59").Value = wks_Product_Details.Range("B2:B51").Value
        .Range("E10:E59").Value = wks_Product_Details.Range("C2:C51").Value
        .Range("F10:F59").Value = wks_Product_Details.Range("D2:D51").Value
        .Range("G10:G59").Value = wks_Product_Details.Range("E2:E51").Value
        .Range("H10:H59").Value = wks_Product_Details.Range("F2:F51").Value
        .Range("I10:I59").Value = wks_Product_Details.Range("G2:G51").Value
        .Range("J10:J59").Value = wks_Product_Details.Range("H2:H51").Value
        .Range("K10:K59").Value = wks_Product_Details.Range("I2:I51").Value
        .Range("L10:L59").Value = wks_Product_Details.Range("J2:J51").Value
        .Range("B61:B65").Value = wks_Scenario.Range("B2:B6").Value
    End With
    
    If wks_Previous.Range("B1").Value <> "" Or wks_Previous.Range("B1").Value <> 0 Then
        wks_Vars.Range("B18,E18").Value = wks_Previous.Range("B1").Value
    Else
        wks_Vars.Range("B18,E18").Value = 1
    End If
    
    If wks_Previous.Range("B2").Value <> "" Or wks_Previous.Range("B2").Value <> 0 Then
        wks_Vars.Range("B20,E20").Value = wks_Previous.Range("B2").Value
    Else
        wks_Vars.Range("B20,E20").Value = 1
    End If
    
    If wks_Previous.Range("B3").Value <> "" Or wks_Previous.Range("B3").Value <> 0 Then
        wks_Vars.Range("B22,E22").Value = wks_Previous.Range("B3").Value
    Else
        wks_Vars.Range("B22,E22").Value = 1
    End If
    
    wks_Vars.Calculate
    
''    intProdCount = 0
''    ''For intNext = 1 To 15 'Prod fill
''    For intNext = 1 To 50 'Prod fill
''        prodName = wks_Product_Details.Range("A" & 1 + intNext).Value
''        If prodName = "" Then
''            Exit For
''        End If
''        wks_Vars1.Range("AB" & 1 + intNext).Value = prodName
''        intProdCount = intProdCount + 1
''    Next intNext
    
    intProdCount = wks_M_List.Range("C9").Value
    wks_Vars1.Range("AB2:AB" & intProdCount + 1).Value = wks_M_List.Range("B10:B" & intProdCount + 9).Value
    
    For intLoop = 1 To intProdCount
        For intNext = 1 To 10 'SKU fill
            If wks_SKU_info.Cells(1 + intNext, 1 + intLoop).Value = "" Then
                wks_Vars1.Range("AD" & 1 + (intLoop - 1) * 10 + intNext).Value = "All"
            Else
                wks_Vars1.Range("AD" & 1 + (intLoop - 1) * 10 + intNext).Value = wks_SKU_info.Cells(1 + intNext, 1 + intLoop).Value
            End If
        Next intNext
    Next intLoop
    
    ''wks_Vars.Range("Q36").Value = "Import"
    Call Create_Forecast_Master
    
'    Application.Calculate
    Call Reverse_BackUp_data_Retrieve
    Call No_Packs_Actual
    Call No_Events
    Call Event_Erosion
    wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1 Then
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
    wks_Forecast.Activate
    If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Call Application_Events_Handler(True)
End Function

Function Retrieve_Forecast_From_Offline()
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim strFileName As String
    Dim intNext As Integer, intLoop As Integer
    Dim thisWB As Workbook
    Dim intRng2 As Integer
    strFileName = Select_File_From_Folder
    If strFileName = "" Then
        MsgBox "Please select a file", vbInformation + vbOKOnly, "PharmaACE"
        Exit Function
    End If
    
Call Application_Events_Handler(False)
    Set objExcel = CreateObject("Excel.Application")
    
    Set wb = objExcel.Workbooks.Open(strFileName)
    Set thisWB = ThisWorkbook
    intRng2 = 9 + wks_Vars.Range("N2").Value
    Call Repeated_Copy_Paste_By_Range("ProjectDetails", wb, "A", "L", thisWB, "A", "L")
    Call Repeated_Copy_Paste_By_Range("PackInfo", wb, "B", "RS", thisWB, "A", "RR")
    Call Repeated_Copy_Paste_By_Range("ScenarioTable", wb, "A", "B", thisWB, "A", "B")
    Call Repeated_Copy_Paste_By_Range("ProductDetails", wb, "A", "J", thisWB, "A", "J")
    Call Repeated_Copy_Paste_By_Range("HistoricalData", wb, "B", "NC", thisWB, "A", "NB")
    Call Repeated_Copy_Paste_By_Range("ForecastData", wb, "B", "RR", thisWB, "A", "RQ")
    Call Repeated_Copy_Paste_By_Range("SKU_Information", wb, "A", "C", thisWB, "A", "C")
    Call Repeated_Copy_Paste_By_Range("SKU_InformationOld", wb, "A", "AY", thisWB, "A", "AY")
    Call Repeated_Copy_Paste_By_Range("ForecastEvents", wb, "A", "N", thisWB, "A", "N")
    Call Repeated_Copy_Paste_By_Range("PenetrationType", wb, "B", "RX", thisWB, "A", "RW")
    
    wb.Application.CutCopyMode = False
    wb.Close False
    Set wb = Nothing
    
''    Call Kill_Process_ObjExcel(objExcel)
    Set objExcel = Nothing
    wks_Vars.Calculate
    
    wks_Vars.Range("B18,B20,B22,E18,E20,E22").Value = 1
    
    With wks_M_List
        .Range("B2").Value = wks_ProjectDetails.Range("A2").Value
        .Range("B3").Value = wks_ProjectDetails.Range("B2").Value
        .Range("B4").Value = wks_ProjectDetails.Range("C2").Value
        .Range("B5").Value = wks_ProjectDetails.Range("D2").Value
        .Range("C5").Value = wks_ProjectDetails.Range("E2").Value
        .Range("B6").Value = wks_ProjectDetails.Range("F2").Value
        .Range("C6").Value = wks_ProjectDetails.Range("G2").Value
        .Range("C7").Value = wks_ProjectDetails.Range("H2").Value
        .Range("B8").Value = wks_ProjectDetails.Range("I2").Value
        .Range("C9").Value = wks_ProjectDetails.Range("J2").Value
        .Range("C60").Value = wks_ProjectDetails.Range("K2").Value
        .Range("B10:B59").Value = wks_Product_Details.Range("A2:A51").Value
        .Range("D10:D59").Value = wks_Product_Details.Range("B2:B51").Value
        .Range("E10:E59").Value = wks_Product_Details.Range("C2:C51").Value
        .Range("F10:F59").Value = wks_Product_Details.Range("D2:D51").Value
        .Range("G10:G59").Value = wks_Product_Details.Range("E2:E51").Value
        .Range("H10:H59").Value = wks_Product_Details.Range("F2:F51").Value
        .Range("I10:I59").Value = wks_Product_Details.Range("G2:G51").Value
        .Range("J10:J59").Value = wks_Product_Details.Range("H2:H51").Value
        .Range("K10:K59").Value = wks_Product_Details.Range("I2:I51").Value
        .Range("L10:L59").Value = wks_Product_Details.Range("J2:J51").Value
        .Range("B61:B65").Value = wks_Scenario.Range("B2:B6").Value
    End With
    
    If wks_Previous.Range("B1").Value <> "" Or wks_Previous.Range("B1").Value <> 0 Then
        wks_Vars.Range("B18,E18").Value = wks_Previous.Range("B1").Value
    Else
        wks_Vars.Range("B18,E18").Value = 1
    End If
    
    If wks_Previous.Range("B2").Value <> "" Or wks_Previous.Range("B2").Value <> 0 Then
        wks_Vars.Range("B20,E20").Value = wks_Previous.Range("B2").Value
    Else
        wks_Vars.Range("B20,E20").Value = 1
    End If
    
    If wks_Previous.Range("B3").Value <> "" Or wks_Previous.Range("B3").Value <> 0 Then
        wks_Vars.Range("B22,E22").Value = wks_Previous.Range("B3").Value
    Else
        wks_Vars.Range("B22,E22").Value = 1
    End If
    
    wks_Vars.Calculate
    
    For intNext = 1 To 15 'Prod fill
        wks_Vars1.Range("AB" & 1 + intNext).Value = wks_Product_Details.Range("A" & 1 + intNext).Value
    Next intNext
    
    For intLoop = 1 To 50
        For intNext = 1 To 10 'SKU fill
            If wks_SKU_info.Cells(1 + intNext, 1 + intLoop).Value = "" Then
                wks_Vars1.Range("AD" & 1 + (intLoop - 1) * 10 + intNext).Value = "All"
            Else
                wks_Vars1.Range("AD" & 1 + (intLoop - 1) * 10 + intNext).Value = wks_SKU_info.Cells(1 + intNext, 1 + intLoop).Value
            End If
        Next intNext
    Next intLoop
    
    ''wks_Vars.Range("Q36").Value = "Import"
    Call Create_Forecast_Master
    
'    Application.Calculate
    Call Reverse_BackUp_data_Retrieve
    Call No_Packs_Actual
    Call No_Events
    Call Event_Erosion
    wks_Forecast.Range("G114:NB114").Interior.Color = RGB(255, 255, 255)
    If wks_Penetration_Type.Range("B" & wks_Vars1.Range("O4").Value).Value = 1 Then
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
    wks_Forecast.Activate
    If wks_Home.Range("T1").Value = 3 Then wks_Forecast.Protect
Call Application_Events_Handler(True)
    Call Ass_Drp_Down_Fill
End Function

Function Select_File_From_Folder()
    Dim intChoice As Integer
    Dim strPath As String
    
    Select_File_From_Folder = ""
    
    Select_File_From_Folder = Application.GetOpenFilename(FileFilter:="Excel Files (*.XLS*), *.XLS*", Title:="Select File To Be Opened")
    If Select_File_From_Folder = False Then Select_File_From_Folder = ""
End Function

Function Repeated_Copy_Paste(strSheetName As String, wb As Workbook, thisWB As Workbook)
    Dim ws As Worksheet
    Set ws = wb.Sheets(strSheetName)
abcd:
    On Error GoTo abcd
    ws.Cells.Copy
    thisWB.Sheets(strSheetName).Range("A1").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    Set ws = Nothing
End Function

Function Repeated_Copy_Paste_By_Range(strSheetName As String, wb As Workbook, srcStartCol As String, srcEndCol As String, thisWB As Workbook, dstStartCol As String, dstEndCol As String)
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim srcRange As String, dstRange As String
    Set ws = wb.Sheets(strSheetName)
abcd:
    On Error GoTo abcd
    ''thisWB.Sheets(strSheetName).Range(dstRange).Value = ws.Range(srcRange).Value
    lastRow = ws.Cells(1048576, 1).End(xlUp).Row
    srcRange = srcStartCol & 1 & ":" & srcEndCol & lastRow
    ''srcRange = srcStartCol & ":" & srcEndCol
    dstRange = dstStartCol & 1 & ":" & dstEndCol & lastRow
    ''dstRange = dstStartCol & ":" & dstEndCol
    ''dstRange = dstStartCol & "1"
    ''''''thisWB.Sheets(strSheetName).Range(dstRange).Value = ws.Range(srcRange).Value
    ''ws.Range(srcRange).Copy Destination:=thisWB.Sheets(strSheetName).Range(dstRange)
''    ws.Range(srcRange).Copy
''    thisWB.Sheets(strSheetName).Range("A1").PasteSpecial xlPasteValues
''    Application.CutCopyMode = False
''    Set ws = Nothing
    
    thisWB.Sheets(strSheetName).Range(dstRange).Value = ws.Range(srcRange).Value
End Function

Function Save_Repeated_Copy_Paste(strSheetName As String, wb As Workbook, thisWB As Workbook)
    Dim ws As Worksheet
    Dim strRng As String
    Set ws = wb.Sheets(strSheetName)
abcd:
    On Error GoTo abcd
    thisWB.Sheets(strSheetName).Cells.Copy
'    ws.Range(strRng).Value = ThisWorkbook.Sheets(strSheetName).Cells(1, 1).CurrentRegion.Value
    ws.Range("A1").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    Set ws = Nothing
End Function

Function Save_Repeated_Copy_Paste_By_Range(strSheetName As String, wb As Workbook, srcStartCol As String, srcEndCol As String, thisWB As Workbook, dstStartCol As String, dstEndCol As String)
    Dim ws As Worksheet, thisWs As Worksheet
    Dim lastRow As Long
    Dim srcRange As String, dstRange As String
    Set ws = wb.Sheets(strSheetName)
    Set thisWs = thisWB.Sheets(strSheetName)
abcd:
    On Error GoTo abcd
    ''thisWB.Sheets(strSheetName).Range(dstRange).Value = ws.Range(srcRange).Value
    lastRow = thisWs.Cells(1048576, 1).End(xlUp).Row
    srcRange = srcStartCol & 1 & ":" & srcEndCol & lastRow
    ''srcRange = srcStartCol & ":" & srcEndCol
    dstRange = dstStartCol & 1 & ":" & dstEndCol & lastRow
    
    ws.Range(srcRange).Value = thisWB.Sheets(strSheetName).Range(dstRange).Value
End Function

Function Reverse_BackUp_data_Retrieve()
Dim intFrom As Integer, intRng As Integer, intRng2 As Integer, intRng3 As Integer, intRng4 As Integer
wks_Vars1.Calculate
intRng = wks_Vars1.Range("T2").Value
intRng2 = wks_Vars1.Range("T3").Value
intRng3 = wks_Vars1.Range("T5").Value
intRng4 = wks_Vars1.Range("T4").Value
    With wks_Forecast 'wks_Backup_Data
'        intFrom = wks_Vars.Range("D22").Value
               
        Call Copy_Paste_Values(wks_Events.Range("H" & intRng3 + 10 & ":L" & intRng3 + 10), .Range("G113:K113"))
        Call Copy_Paste_Values(wks_Events.Range("E" & intRng3 & ":L" & intRng3 + 9), .Range("F121:M130"))
         Call Copy_Paste_Values(wks_Events.Range("E" & intRng3 + 11 & ":L" & intRng3 + 15), .Range("F95:M99"))
        Call Copy_Paste_Values(wks_Events.Range("M" & intRng3 + 10), wks_Vars.Range("Q8"))
        Call Copy_Paste_Values(wks_PackData.Range("RR" & intRng3), wks_Vars.Range("Q9"))
        Call Copy_Paste_Values(wks_Historical.Range("E" & intRng & ":" & wks_Vars.Range("K4").Value & intRng + 14), .Range("F14:" & wks_Vars.Range("K4").Value & "29"))
        Call Copy_Paste_Values(wks_Historical.Range("F" & intRng + 16 & ":" & wks_Vars.Range("K4").Value & intRng + 16 + 14), .Range("G32:" & wks_Vars.Range("K4").Value & "46"))
        Call Copy_Paste_Values(wks_Historical.Range("F" & intRng + 48 & ":" & wks_Vars.Range("K4").Value & intRng + 48 + 14), .Range("G70:" & wks_Vars.Range("K4").Value & "84"))
        Call Copy_Paste_Values(wks_Historical.Range("F" & intRng + 48 + 16 & ":" & wks_Vars.Range("K4").Value & intRng + 48 + 16 + 14), wks_Trending.Range("G34:" & wks_Vars.Range("K4").Value & "49"))
        Call Copy_Paste_Values(wks_Historical.Range("E" & intRng + 32 & ":" & wks_Vars.Range("K4").Value & intRng + 32 + 14), .Range("F50:" & wks_Vars.Range("K4").Value & "64"))
'        Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intFrom + 48 & ":IK" & intFrom + 48), .Range("F92:NB92"))
        Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intRng2 & ":" & wks_Vars.Range("K4").Value & intRng2), .Range("G91:" & wks_Vars.Range("K4").Value & "91"))
        Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intRng2 + 1 & ":" & wks_Vars.Range("K4").Value & intRng2 + 1), .Range("G150:" & wks_Vars.Range("K4").Value & "150"))
        Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intRng2 + 2 & ":" & wks_Vars.Range("K4").Value & intRng2 + 2), .Range("G153:" & wks_Vars.Range("K4").Value & "153"))
        Call Copy_Paste_Values(wks_Backup_Data.Range("E" & intRng2 + 3 & ":" & wks_Vars.Range("K4").Value & intRng2 + 3), .Range("G156:" & wks_Vars.Range("K4").Value & "156"))
        Call Copy_Paste_Values(wks_PackData.Range("E" & intRng4 & ":" & wks_Vars.Range("K4").Value & intRng4 + 14), .Range("G172:" & wks_Vars.Range("K4").Value & "186"))
        Call Copy_Paste_Values(wks_PackData.Range("E" & intRng4 + 15 & ":" & wks_Vars.Range("K4").Value & intRng4 + 15 + 14), .Range("G206:" & wks_Vars.Range("K4").Value & "220"))
        Call Copy_Paste_Values(wks_PackData.Range("E" & intRng4 + 15 + 15 & ":" & wks_Vars.Range("K4").Value & intRng4 + 15 + 15 + 14), .Range("G223:" & wks_Vars.Range("K4").Value & "237"))
        Call Copy_Paste_Values(wks_Penetration_Type.Range("C" & wks_Vars1.Range("O9").Value & ":RN" & wks_Vars1.Range("O9").Value), .Range("G114"))
'        .Range("F32:NB47").Value = wks_Backup_Data.Range("E" & intFrom + 16 & ":IK" & intFrom + 31).Value
'        .Range("F70:NB85").Value = wks_Backup_Data.Range("E" & intFrom + 32 & ":IK" & intFrom + 47).Value
'        .Range("F92:NB92").Value = wks_Backup_Data.Range("E" & intFrom + 48 & ":IK" & intFrom + 48).Value
'        .Range("F96:NB110").Value = wks_Backup_Data.Range("E" & intFrom + 49 & ":IK" & intFrom + 63).Value
'        .Range("F150:NB150").Value = wks_Backup_Data.Range("E" & intFrom + 64 & ":IK" & intFrom + 64).Value
'        .Range("F153:NB153").Value = wks_Backup_Data.Range("E" & intFrom + 65 & ":IK" & intFrom + 65).Value
'        .Range("F156:NB156").Value = wks_Backup_Data.Range("E" & intFrom + 66 & ":IK" & intFrom + 66).Value
'
'        .Range("F172:NB186").Value = wks_Backup_Data.Range("E" & intFrom + 70 & ":IJ" & intFrom + 84).Value
'        .Range("F206:NB220").Value = wks_Backup_Data.Range("E" & intFrom + 85 & ":IK" & intFrom + 99).Value
'        .Range("F50:NB65").Value = wks_Backup_Data.Range("E" & intFrom + 100 & ":IK" & intFrom + 115).Value
'
'        .Range("F223:NB237").Value = wks_Backup_Data.Range("E" & intFrom + 116 & ":IK" & intFrom + 130).Value
    End With
End Function

'SAVEAS FUNCTION FOR OFFLINE MODE
Function Save_in_Local_Drive()
    Dim ObjWshShell As Object, userProfilePath As String
    Dim strFileName As String
    Dim strDestinationPath As String, strMsg As String
    
    Set ObjWshShell = CreateObject("WScript.Shell")
    userProfilePath = ObjWshShell.ExpandEnvironmentStrings("%UserProfile%")
    
    strFileName = ThisWorkbook.Sheets("ProjectDetails").Range("A2").Value & ".xlsb"
ReRun:
    strDestinationPath = GetFolderName(userProfilePath & "\Desktop")
    If strDestinationPath = "" Then
        strMsg = MsgBox("You have clicked on 'Cancel'. Are you sure you dont want to save the file?", vbYesNo, "PharmaACE")
        If strMsg = vbYes Then GoTo ReRun
    End If
    
    If strDestinationPath <> "" Then
        Save_in_Local_Drive = Move_File_To_Another_Folder(strFileName, ThisWorkbook.Path & "\", strDestinationPath)
        If Save_in_Local_Drive = 0 Then
            Save_in_Local_Drive = "File not exists"
        ElseIf Save_in_Local_Drive = 1 Then
            Save_in_Local_Drive = "File saved successfully"
        ElseIf Save_in_Local_Drive = 2 Then
            strMsg = MsgBox("File already exits in the folder. Do you want to replace the existing file?", vbInformation + vbYesNo, "PharmaACE")
            If strMsg = vbYes Then
                Save_in_Local_Drive = Move_File_To_Another_Folder_Replace(strFileName, ThisWorkbook.Path & "\", strDestinationPath)
                Save_in_Local_Drive = "File saved successfully"
            ElseIf strMsg = vbNo Then
AgainFileName:
                strMsg = InputBox("Enter new file name:", "New file name")
                If strMsg = "" Then
                    MsgBox "File name cannot be empty", vbInformation + vbOKOnly, "PharmaACE"
                    GoTo AgainFileName
                End If
                Name ThisWorkbook.Path & "\" & strFileName As strDestinationPath & "\" & strMsg & "." & Right(strFileName, 4)   ' Move and rename file.
                Save_in_Local_Drive = "File saved successfully"
            End If
        End If
    Else
        Save_in_Local_Drive = "File save cancelled"
    End If
End Function

Function GetFolderName(Optional OpenAt As String) As String
    Dim lCount As Long
    
    GetFolderName = vbNullString
    
    With Application.FileDialog(msoFileDialogFolderPicker)
        .InitialFileName = OpenAt
        .Show
        For lCount = 1 To .SelectedItems.Count
            GetFolderName = .SelectedItems(lCount)
        Next lCount
    End With
End Function

Function Move_File_To_Another_Folder(sFile As String, sSource As String, sDestination As String)
    Dim FSO As Object
    'Create Object
    Set FSO = CreateObject("Scripting.FileSystemObject")
    'Checking If File Is Located in the Source Folder
    If Not FSO.FileExists(sSource & sFile) Then
        Move_File_To_Another_Folder = 0
''        MsgBox "Specified File Not Found", vbInformation, "Not Found"
    ElseIf Not FSO.FileExists(sDestination & "\" & sFile) Then
        FSO.CopyFile (sSource & sFile), sDestination & "\", True
        Move_File_To_Another_Folder = 1
''        MsgBox "Specified File Copied Successfully", vbInformation, "Done!"
    Else
        Move_File_To_Another_Folder = 2
''        MsgBox "Specified File Already Exists In The Destination Folder", vbExclamation, "File Already Exists"
    End If
End Function

Function Move_File_To_Another_Folder_Replace(sFile As String, sSource As String, sDestination As String)
    Dim FSO As Object
    'Create Object
    Set FSO = CreateObject("Scripting.FileSystemObject")

    FSO.CopyFile (sSource & sFile), sDestination & "\", True
    Move_File_To_Another_Folder_Replace = 1
End Function

'CLEAR ALL CODE
Function Clear_All_Code()
    Call Data_Clear
End Function
