Attribute VB_Name = "mod_Offline"
Option Explicit

Function Import_Offline()
    frm_Import_Offline.Show
End Function

Function Save_Offline_Version_Forecast_UserForm()
    frm_Save_Offline.Show
End Function

Function Save_Offline_Version_Forecast()
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim strPath As String
    Dim intHist As Long
    Dim intConv As Long
    Dim intOutput As Long
    Dim intEPI As Long
    
Call Application_Event_Handler(False)
    Call BackEndSaveData
    
    wks_Vars.Range("A2").Value = frm_Save_Offline.txt_Save.Text
    
    'CREATE MASTER_LIST SHEET
    With wks_Project
        .Range("A2").Value = wks_Vars.Range("A2").Value
        .Range("B2").Value = wks_Vars.Range("J2").Value
        .Range("C2").Value = wks_Vars.Range("J3").Value
        .Range("D2").Value = wks_Vars.Range("J4").Value
        .Range("E2").Value = wks_Vars.Range("H2").Value
        .Range("F2").Value = wks_Vars.Range("M1").Value
        .Range("G2").Value = wks_Vars.Range("R1").Value
        .Range("H2").Value = wks_Vars.Range("AM1").Value
    End With
    With wks_Products
        .Range("A2:D6").Value = wks_Vars.Range("L3:O7").Value
        .Range("E2:E6").Value = 1
        
        .Range("A7:D11").Value = wks_Vars.Range("Q3:T7").Value
        .Range("E7:E11").Value = 2
        
        .Range("D2:D11").Replace True, 1
        .Range("D2:D11").Replace False, 0
    End With
    With wks_SegmentDetails
        .Range("B2:I11").Value = wks_Vars.Range("AD2:AK11").Value
        
        .Range("C2:C11").Replace True, 1
        .Range("C2:C11").Replace False, 0
    End With
    With wks_Segments
        .Range("B2:B16").Value = wks_Vars.Range("AC2:AC16").Value
    End With
    intEPI = wks_Vars.Range("BZ2").Value
    With wks_EPI_Data
        .Range("A2:A" & intEPI + 1).Formula = "=Row()-1"
        .Range("A2:A" & intEPI + 1).Calculate
        .Range("A2:A" & intEPI + 1).Value = .Range("A2:A" & intEPI + 1).Value
        .Range("RQ2:RQ" & intEPI + 1).Value = .Range("A2:A" & intEPI + 1).Value
    End With
    intHist = wks_Vars.Range("BZ3").Value
    With wks_Historical_Data
        .Range("A2:A" & intHist + 1).Formula = "=Row()-1"
        .Range("A2:A" & intHist + 1).Calculate
        .Range("A2:A" & intHist + 1).Value = .Range("A2:A" & intHist + 1).Value
        .Range("RS2:RS" & intHist + 1).Value = .Range("A2:A" & intHist + 1).Value
        
        .Range("E1:F" & intHist + 1).Replace 0, "", xlWhole
    End With
    intConv = wks_Vars.Range("BZ4").Value
    With wks_Conversion_Data
        .Range("A2:A" & intConv + 1).Formula = "=Row()-1"
        .Range("A2:A" & intConv + 1).Calculate
        .Range("A2:A" & intConv + 1).Value = .Range("A2:A" & intConv + 1).Value
        .Range("RS2:RS" & intConv + 1).Value = .Range("A2:A" & intConv + 1).Value
        
        .Range("E1:F" & intConv + 1).Replace "0", "", xlWhole
    End With
    intOutput = wks_Vars.Range("BZ6").Value
    With wks_Output
        .Range("A2:A" & intOutput + 1).Formula = "=Row()-1"
        .Range("A2:A" & intOutput + 1).Calculate
        .Range("A2:A" & intOutput + 1).Value = .Range("A2:A" & intOutput + 1).Value
        .Range("RS2:RS" & intOutput + 1).Value = .Range("A2:A" & intOutput + 1).Value
        
        .Range("E1:F" & intOutput + 1).Replace "0", "", xlWhole
    End With
    
    With wks_AdvancedPricing
        .Range("G:G").ClearFormats
        .Range("I:I").ClearFormats
        .Range("D:F").Replace "0", "", xlWhole
        .Range("H:H").Replace "0", "", xlWhole
    End With
    With wks_Shares
        .Range("D:F").Replace "0", "", xlWhole
        .Range("G:J").ClearFormats
    End With
    With wks_Events
        .Range("D:D").Replace "0", "", xlWhole
        .Range("H:H").Replace "0", "", xlWhole
        .Range("I:M").ClearFormats
    End With
    With wks_Country
        wks_Vars.Range("W:W").Copy
        .Range("A1").PasteSpecial xlPasteAll
        Application.CutCopyMode = False
        .Range("A1").Value = "CountryName"
    End With
    With wks_SOB
        .Range("D:E").Replace "0", "", xlWhole
    End With
    
    Set objExcel = CreateObject("Excel.Application")
    
    Set wb = objExcel.Workbooks.Add
    
    Set ws = wb.Sheets(1)
    ws.Name = "ProjectDetails"
    Call Save_Repeated_Copy_Paste("ProjectDetails", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "ProductDetails"
    Call Save_Repeated_Copy_Paste("ProductDetails", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "SegmentDetails"
    Call Save_Repeated_Copy_Paste("SegmentDetails", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Segments"
    Call Save_Repeated_Copy_Paste("Segments", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "MasterList"
    Call Save_Repeated_Copy_Paste("MasterList", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "EPIData"
    Call Save_Repeated_Copy_Paste("EPIData", wb)
    ws.Range("A1:IJ" & intEPI).Name = "EPIData1"
    ws.Range("IK1:RQ" & intEPI).Name = "EPIData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "HistoricalData"
    Call Save_Repeated_Copy_Paste("HistoricalData", wb)
    ws.Range("A1:IL" & intHist).Name = "HistData1"
    ws.Range("IM1:RS" & intHist).Name = "HistData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "ConversionData"
    Call Save_Repeated_Copy_Paste("ConversionData", wb)
    ws.Range("A1:IL" & intConv).Name = "ConvData1"
    ws.Range("IM1:RS" & intConv).Name = "ConvData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "AdvancedPricing"
    Call Save_Repeated_Copy_Paste("AdvancedPricing", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Shares"
    Call Save_Repeated_Copy_Paste("Shares", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Source"
    Call Save_Repeated_Copy_Paste("Source", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Events"
    Call Save_Repeated_Copy_Paste("Events", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "OutputData"
    Call Save_Repeated_Copy_Paste("OutputData", wb)
    ws.Range("A1:IL" & intOutput).Name = "OutputData1"
    ws.Range("IM1:RS" & intOutput).Name = "OutputData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "CountryDetails"
    Call Save_Repeated_Copy_Paste("CountryDetails", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "ScenarioTable"
    Call Save_Repeated_Copy_Paste("ScenarioTable", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Parameter"
    Call Save_Repeated_Copy_Paste("Parameter", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Indication"
    Call Save_Repeated_Copy_Paste("Indication", wb)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Assumptions"
    Call Save_Repeated_Copy_Paste("Assumptions", wb)
    
    Call Replace_Blanks(wb)
    
    If frm_Save_Offline.opt_Major.Value Then
        strPath = Get_Offline_Version_Forecast + 1
    Else
        strPath = Get_Offline_Version_Forecast + 0.1
    End If
    strPath = ThisWorkbook.Path & "\BDL Tool Versions\" & ThisWorkbook.Sheets("ProjectDetails").Range("A2").Value & "_V" & strPath & ".xlsb"
    If Dir(strPath) <> "" Then Kill strPath
    
    wb.SaveAs strPath, 50
    Application.DisplayAlerts = False
    wb.Application.CutCopyMode = False
    wb.Close False
    
    Set ws = Nothing
    Set wb = Nothing
''    Call Kill_Process_ObjExcel(objExcel)
    Set objExcel = Nothing
Call Application_Event_Handler(True)
End Function

Function Get_Offline_Version_Forecast()
    Dim directory As String
    Dim Filename As String
    Dim strFName As String
    Dim strProjectName As String
    Dim intNext As Integer
    
    wks_VersionOffline.Cells.Clear
    
    intNext = 1
    strProjectName = LCase(wks_Vars.Range("A2").Value)
    
    directory = ThisWorkbook.Path & "\BDL Tool Versions\"
    Filename = Dir(directory & "*.xl??")
    Do While Filename <> ""
        strFName = Filename
        strFName = LCase(strFName)
        If Left(strFName, Len(strProjectName) + 1) = strProjectName & "_" Then
            strFName = Application.WorksheetFunction.Substitute(strFName, ".xlsx", "")
            strFName = Application.WorksheetFunction.Substitute(strFName, ".xlsb", "")
            strFName = Application.WorksheetFunction.Substitute(strFName, ".xls", "")
            strFName = Application.WorksheetFunction.Substitute(strFName, strProjectName & "_v", "")
            wks_VersionOffline.Range("A" & intNext).Value = strFName
            intNext = intNext + 1
        End If
        Filename = Dir()
    Loop
    
    Get_Offline_Version_Forecast = Application.WorksheetFunction.Max(wks_VersionOffline.Range("A:A"))
End Function

Function Assumptions_UserForm()
    frm_Assumptions.Show
End Function
