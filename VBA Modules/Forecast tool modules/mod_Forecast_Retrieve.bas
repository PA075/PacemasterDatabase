Attribute VB_Name = "mod_Forecast_Retrieve"
Option Explicit

Function Retrieve_Forecast()
    Call Retrieve_Common(ThisWorkbook.Path & "\" & wks_Home.Range("A1").Value)
End Function

Function Retrieve_Forecast_From_Offline()
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim strFileName As String

    strFileName = Select_File_From_Folder
    If strFileName = "" Then
        MsgBox "Please select a file", vbInformation + vbOKOnly, "PharmaACE"
        Exit Function
    End If
    
    Call Retrieve_Common(strFileName)
End Function

Function Retrieve_Common(strFileName As String)
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
Call Application_Event_Handler(False)
    Call Clear_All_Sheets
    
    Set objExcel = CreateObject("Excel.Application")

    Set wb = objExcel.Workbooks.Open(strFileName)

    Call Repeated_Copy_Paste("ProjectDetails", wb)
    Call Repeated_Copy_Paste("ProductDetails", wb)
    Call Repeated_Copy_Paste("SegmentDetails", wb)
    Call Repeated_Copy_Paste("Segments", wb)
    Call Repeated_Copy_Paste("MasterList", wb)
    Call Repeated_Copy_Paste("EPIData", wb)
    Call Repeated_Copy_Paste("HistoricalData", wb)
    Call Repeated_Copy_Paste("ConversionData", wb)
    Call Repeated_Copy_Paste("AdvancedPricing", wb)
    Call Repeated_Copy_Paste("Shares", wb)
    Call Repeated_Copy_Paste("Source", wb)
    Call Repeated_Copy_Paste("Events", wb)
    Call Repeated_Copy_Paste("OutputData", wb)
    Call Repeated_Copy_Paste("CountryDetails", wb)
    Call Repeated_Copy_Paste("Indication", wb)
    Call Repeated_Copy_Paste("Assumptions", wb)
    
''    Call Repeated_Copy_Paste_Range("ProjectDetails", wb, "A1:I")
''    Call Repeated_Copy_Paste_Range("ProductDetails", wb, "A1:E")
''    Call Repeated_Copy_Paste_Range("SegmentDetails", wb, "A1:I")
''    Call Repeated_Copy_Paste_Range("Segments", wb, "A1:B")
''    Call Repeated_Copy_Paste_Range("MasterList", wb, "A1:D")
''    Call Repeated_Copy_Paste_Range("EPIData", wb, "A1:RQ")
''    Call Repeated_Copy_Paste_Range("HistoricalData", wb, "A1:RS")
''    Call Repeated_Copy_Paste_Range("ConversionData", wb, "A1:RS")
''    Call Repeated_Copy_Paste_Range("AdvancedPricing", wb, "A1:I")
''    Call Repeated_Copy_Paste_Range("Shares", wb, "A1:J")
''    Call Repeated_Copy_Paste_Range("Source", wb, "A1:J")
''    Call Repeated_Copy_Paste_Range("Events", wb, "A1:M")
''    Call Repeated_Copy_Paste_Range("OutputData", wb, "A1:RS")
''    Call Repeated_Copy_Paste_Range("CountryDetails", wb, "A1:A")
''    Call Repeated_Copy_Paste_Range("Indication", wb, "A1:A")
''    Call Repeated_Copy_Paste_Range("Assumptions", wb, "A1:D")

    wb.Application.CutCopyMode = False
    wb.Close False
    Set wb = Nothing
    Set objExcel = Nothing
    
    With wks_Project
        wks_Vars.Range("A2").Value = .Range("A2").Value
        
        With wks_Vars.Range("B2")
            .Formula = "=INDEX($BC$2:$BC$13,MONTH(ProjectDetails!B2))"
            .Value = .Value
        End With
        With wks_Vars.Range("C2")
            .Formula = "=YEAR(ProjectDetails!B2)"
            .Value = .Value
        End With
        With wks_Vars.Range("D2")
            .Formula = "=INDEX($BC$2:$BC$13,MONTH(ProjectDetails!C2))"
            .Value = .Value
        End With
        With wks_Vars.Range("E2")
            .Formula = "=YEAR(ProjectDetails!C2)"
            .Value = .Value
        End With
        With wks_Vars.Range("F2")
            .Formula = "=INDEX($BC$2:$BC$13,MONTH(ProjectDetails!D2))"
            .Value = .Value
        End With
        With wks_Vars.Range("G2")
            .Formula = "=YEAR(ProjectDetails!D2)"
            .Value = .Value
        End With
        
        wks_Vars.Range("H2").Value = .Range("E2").Value
        wks_Vars.Range("M1").Value = .Range("F2").Value
        wks_Vars.Range("R1").Value = .Range("G2").Value
        wks_Vars.Range("AM1").Value = .Range("H2").Value
        
        wks_Vars.Range("I2").Value = .Range("J2").Value
        If wks_Vars.Range("I2").Value = "" Then wks_Vars.Range("I2").Value = True
    End With
    With wks_Products
        .Range("D2:D11").Replace 1, True
        .Range("D2:D11").Replace 0, False
        
        wks_Vars.Range("L3:O7").Value = .Range("A2:D6").Value
        
        wks_Vars.Range("Q3:T7").Value = .Range("A7:D11").Value
    End With
    With wks_SegmentDetails
        .Range("C2:C11").Replace 1, True
        .Range("C2:C11").Replace 0, False
        
        wks_Vars.Range("AD2:AK11").Value = .Range("B2:I11").Value
    End With
    With wks_Segments
        wks_Vars.Range("AC2:AC16").Value = .Range("B2:B16").Value
    End With
    With wks_Country
        .Range("A:A").Copy
        wks_Vars.Range("W1").PasteSpecial xlPasteValues
        Application.CutCopyMode = False
        wks_Vars.Range("W1").Clear
    End With
    
    wks_Vars.Range("V3").Value = 1
    wks_Vars.Range("BK1").Value = 1
    wks_Vars.Range("CB13").Value = 1
    wks_Vars.Range("CB14").Value = 1
    
    Call Set_All_Sheets
    Call FrontEndSaveData
    If wks_ForecastFlow.Range("A" & wks_Vars.Range("EB21").Value - 5).Value <> 2 Then
        Call ShareCalculation_1
    End If
    wks_ForecastFlow.Activate
Call Application_Event_Handler(True)
End Function

Function Repeated_Copy_Paste(strSheetName As String, wb As Workbook)
    Dim ws As Worksheet
    Set ws = wb.Sheets(strSheetName)
abcd:
    On Error GoTo abcd
    ws.Cells.Copy
    ThisWorkbook.Sheets(strSheetName).Range("A1").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    Set ws = Nothing
End Function

Function Repeated_Copy_Paste_Range(strSheetName As String, wb As Workbook, strRange As String)
    Dim ws As Worksheet
    Dim intCount As Double
    Set ws = wb.Sheets(strSheetName)
    intCount = Application.WorksheetFunction.CountA(ws.Range("A:A")) - Application.WorksheetFunction.CountBlank(ws.Range("A:A"))
    If intCount = 0 Then intCount = 1
    strRange = strRange & intCount
    ThisWorkbook.Sheets(strSheetName).Range(strRange).Value = ws.Range(strRange).Value
End Function
