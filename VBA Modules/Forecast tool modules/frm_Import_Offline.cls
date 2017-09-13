VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} frm_Import_Offline 
   Caption         =   "Import Forecast"
   ClientHeight    =   4845
   ClientLeft      =   45
   ClientTop       =   390
   ClientWidth     =   5055
   OleObjectBlob   =   "frm_Import_Offline.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "frm_Import_Offline"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmd_Cancel_Click()
    Unload Me
End Sub

Private Sub cmd_Import_Click()
    Dim intLoop As Integer
    Dim strFName As String
    strFName = ""
    For intLoop = 1 To lst_Versions.ListCount
        If lst_Versions.Selected(intLoop - 1) Then
            strFName = lst_Versions.List(intLoop - 1)
            Exit For
        End If
    Next intLoop
    If strFName = "" Then
        MsgBox "Please select a version to Import", vbInformation + vbOKOnly, "PharmaACE"
        Exit Sub
    End If
    wks_Home.Range("A1").Value = "BDL Tool Versions\" & strFName & ".xlsb"
    Call Retrieve_Forecast
    Unload Me
End Sub

Private Sub txt_Search_Change()
    Dim intCount As Integer
    Dim intLoop As Integer
    If txt_Search.Text <> "" Then
        lst_Versions.Clear
        intCount = Application.WorksheetFunction.CountA(wks_VersionOffline.Range("A:A"))
        For intLoop = 1 To intCount
            If Find_Text(wks_VersionOffline.Range("A" & intLoop).Value, txt_Search.Text) <> 0 Then
                lst_Versions.AddItem wks_VersionOffline.Range("A" & intLoop).Value
            End If
        Next intLoop
    Else
        lst_Versions.Clear
        intCount = Application.WorksheetFunction.CountA(wks_VersionOffline.Range("A:A"))
        For intLoop = 1 To intCount
            lst_Versions.AddItem wks_VersionOffline.Range("A" & intLoop).Value
        Next intLoop
    End If
End Sub

Private Sub UserForm_Activate()
    Dim directory As String
    Dim Filename As String
    Dim strFName As String
    Dim intNext As Integer
    
    wks_VersionOffline.Cells.Clear
    lst_Versions.Clear
    
    intNext = 1
    
    directory = ThisWorkbook.Path & "\BDL Tool Versions\"
    Filename = Dir(directory & "*.xl??")
    Do While Filename <> ""
        strFName = Filename
        strFName = Application.WorksheetFunction.Substitute(strFName, ".xlsx", "")
        strFName = Application.WorksheetFunction.Substitute(strFName, ".xlsb", "")
        strFName = Application.WorksheetFunction.Substitute(strFName, ".xls", "")
        strFName = Application.WorksheetFunction.Substitute(strFName, ".XLSX", "")
        strFName = Application.WorksheetFunction.Substitute(strFName, ".XLSB", "")
        strFName = Application.WorksheetFunction.Substitute(strFName, ".XLS", "")
        wks_VersionOffline.Range("A" & intNext).Value = strFName
        lst_Versions.AddItem strFName
        intNext = intNext + 1
        Filename = Dir()
    Loop
End Sub

Function Find_Text(strIn As String, strWhat As String)
    On Error GoTo ErrFound
    Find_Text = Application.WorksheetFunction.Find(strWhat, strIn, 1)
    Exit Function
ErrFound:
    Find_Text = 0
End Function
