Attribute VB_Name = "mod_Forecast_Save"
Option Explicit

Function Save_Forecast_Offline()
    Call Save_Forecast
    Call Save_in_Local_Drive
End Function

Function Save_Forecast()
    Dim objExcel As Object
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim strPath As String
    Dim intHist As Long
    Dim intConv As Long
    Dim intOutput As Long
    Dim intEPI As Long
    Dim intLoop As Integer
    
Call Application_Event_Handler(False)
    Call BackEndSaveData
    
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
        .Range("J2").Value = wks_Vars.Range("I2").Value
    End With
    With wks_Products
        .Range("A2:D6").Value = wks_Vars.Range("L3:O7").Value
        .Range("E2:E6").Value = 1
        
        .Range("A7:D11").Value = wks_Vars.Range("Q3:T7").Value
        .Range("E7:E11").Value = 2
        
        .Range("D2:D11").Replace True, 1
        .Range("D2:D11").Replace False, 0
    For intLoop = 2 To 11
        If .Range("D" & intLoop).Value = "1" Then
            .Range("D" & intLoop).Value = 1
        Else
            .Range("D" & intLoop).Value = 0
        End If
    Next intLoop
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
''    Call Save_Repeated_Copy_Paste("ProjectDetails", wb)
    Call Save_Repeated_Copy_Paste_Range("ProjectDetails", wb, "A1:I2")
    ws.Range("B2:D2").NumberFormat = "MMM-YYYY"
    
    Set ws = wb.Sheets.Add
    ws.Name = "ProductDetails"
''    Call Save_Repeated_Copy_Paste("ProductDetails", wb)
    Call Save_Repeated_Copy_Paste_Range("ProductDetails", wb, "A1:E11")
    ws.Range("B2:B11").NumberFormat = "MMM-YYYY"
    
    Set ws = wb.Sheets.Add
    ws.Name = "SegmentDetails"
''    Call Save_Repeated_Copy_Paste("SegmentDetails", wb)
    Call Save_Repeated_Copy_Paste_Range("SegmentDetails", wb, "A1:I16")
    
    Set ws = wb.Sheets.Add
    ws.Name = "Segments"
''    Call Save_Repeated_Copy_Paste("Segments", wb)
    Call Save_Repeated_Copy_Paste_Range("Segments", wb, "A1:B17")
    
    Set ws = wb.Sheets.Add
    ws.Name = "MasterList"
''    Call Save_Repeated_Copy_Paste("MasterList", wb)
    Call Save_Repeated_Copy_Paste_Range("MasterList", wb, "A1:D" & wks_Vars.Range("BZ9").Value)
    
    Set ws = wb.Sheets.Add
    ws.Name = "EPIData"
''    Call Save_Repeated_Copy_Paste("EPIData", wb)
    Call Save_Repeated_Copy_Paste_Range("EPIData", wb, "A1:RQ" & intEPI)
    ws.Range("A1:IJ" & intEPI).Name = "EPIData1"
    ws.Range("IK1:RQ" & intEPI).Name = "EPIData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "HistoricalData"
''    Call Save_Repeated_Copy_Paste("HistoricalData", wb)
    Call Save_Repeated_Copy_Paste_Range("HistoricalData", wb, "A1:RS" & intHist)
    ws.Range("A1:IL" & intHist).Name = "HistData1"
    ws.Range("IM1:RS" & intHist).Name = "HistData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "ConversionData"
''    Call Save_Repeated_Copy_Paste("ConversionData", wb)
    Call Save_Repeated_Copy_Paste_Range("ConversionData", wb, "A1:RS" & intConv)
    ws.Range("A1:IL" & intConv).Name = "ConvData1"
    ws.Range("IM1:RS" & intConv).Name = "ConvData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "AdvancedPricing"
''    Call Save_Repeated_Copy_Paste("AdvancedPricing", wb)
    Call Save_Repeated_Copy_Paste_Range("AdvancedPricing", wb, "A1:I" & wks_Vars.Range("BZ8").Value)
    ws.Range("F2:F" & wks_Vars.Range("BZ8").Value).NumberFormat = "MMM-YYYY"
    
    Set ws = wb.Sheets.Add
    ws.Name = "Shares"
''    Call Save_Repeated_Copy_Paste("Shares", wb)
    Call Save_Repeated_Copy_Paste_Range("Shares", wb, "A1:J" & wks_Vars.Range("BZ5").Value)
    ws.Range("F2:F" & wks_Vars.Range("BZ5").Value).NumberFormat = "MMM-YYYY"
    
    Set ws = wb.Sheets.Add
    ws.Name = "Source"
''    Call Save_Repeated_Copy_Paste("Source", wb)
    Call Save_Repeated_Copy_Paste_Range("Source", wb, "A1:J" & wks_Vars.Range("BZ10").Value)
    
    Set ws = wb.Sheets.Add
    ws.Name = "Events"
''    Call Save_Repeated_Copy_Paste("Events", wb)
    Call Save_Repeated_Copy_Paste_Range("Events", wb, "A1:M" & wks_Vars.Range("BZ7").Value)
    ws.Range("H2:H" & wks_Vars.Range("BZ7").Value).NumberFormat = "MMM-YYYY"
    
    Set ws = wb.Sheets.Add
    ws.Name = "OutputData"
''    Call Save_Repeated_Copy_Paste("OutputData", wb)
    Call Save_Repeated_Copy_Paste_Range("OutputData", wb, "A1:RS" & intOutput)
    ws.Range("A1:IL" & intOutput).Name = "OutputData1"
    ws.Range("IM1:RS" & intOutput).Name = "OutputData2"
    
    Set ws = wb.Sheets.Add
    ws.Name = "CountryDetails"
''    Call Save_Repeated_Copy_Paste("CountryDetails", wb)
    Call Save_Repeated_Copy_Paste_Range("CountryDetails", wb, "A1:A100")
    
    Set ws = wb.Sheets.Add
    ws.Name = "ScenarioTable"
''    Call Save_Repeated_Copy_Paste("ScenarioTable", wb)
    Call Save_Repeated_Copy_Paste_Range("ScenarioTable", wb, "A1:B4")
    
    Set ws = wb.Sheets.Add
    ws.Name = "Parameter"
''    Call Save_Repeated_Copy_Paste("Parameter", wb)
    Call Save_Repeated_Copy_Paste_Range("Parameter", wb, "A1:B144")
    
    Set ws = wb.Sheets.Add
    ws.Name = "Indication"
''    Call Save_Repeated_Copy_Paste("Indication", wb)
    Call Save_Repeated_Copy_Paste_Range("Indication", wb, "A1:A200")
    
    Set ws = wb.Sheets.Add
    ws.Name = "Assumptions"
''    Call Save_Repeated_Copy_Paste("Assumptions", wb)
    Call Save_Repeated_Copy_Paste_Range("Assumptions", wb, "A1:D" & wks_Vars.Range("BZ11").Value)
    ws.Range("A1").Value = "Country"
    
    Call Replace_Blanks(wb)
    
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
Call Application_Event_Handler(True)
wks_ForecastFlow.Activate
Save_Forecast = strPath
End Function

Function Replace_Blanks(wb As Workbook)
    On Error Resume Next
    wb.Sheets("EPIData").Range("A1:RQ" & wks_Vars.Range("BZ2").Value).SpecialCells(xlCellTypeBlanks).Clear
    wb.Sheets("HistoricalData").Range("A1:RS" & wks_Vars.Range("BZ3").Value).SpecialCells(xlCellTypeBlanks).Clear
    wb.Sheets("ConversionData").Range("A1:RS" & wks_Vars.Range("BZ4").Value).SpecialCells(xlCellTypeBlanks).Clear
    wb.Sheets("OutputData").Range("A1:RS" & wks_Vars.Range("BZ6").Value).SpecialCells(xlCellTypeBlanks).Clear
End Function

Function Select_File_From_Folder()
    Dim intChoice As Integer
    Dim strPath As String
    
    Select_File_From_Folder = ""
    
    Select_File_From_Folder = Application.GetOpenFilename(FileFilter:="Excel Files (*.XLS*), *.XLS*", Title:="Select File To Be Opened")
    If Select_File_From_Folder = False Then Select_File_From_Folder = ""
End Function

Function Save_Repeated_Copy_Paste(strSheetName As String, wb As Workbook)
    Dim ws As Worksheet
    Set ws = wb.Sheets(strSheetName)
abcd:
    On Error GoTo abcd
    ThisWorkbook.Sheets(strSheetName).Cells.Copy
    ws.Range("A1").PasteSpecial xlPasteValues
    Application.CutCopyMode = False
    Set ws = Nothing
End Function

Function Save_Repeated_Copy_Paste_Range(strSheetName As String, wb As Workbook, strRange As String)
    Dim ws As Worksheet
    Set ws = wb.Sheets(strSheetName)
    ws.Range(strRange).Value = ThisWorkbook.Sheets(strSheetName).Range(strRange).Value
    Set ws = Nothing
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

